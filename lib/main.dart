// lib/main.dart

// lib/main.dart

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_theme.dart';
import 'widgets/background_layer.dart';
import 'profile_picture_screen.dart';
import 'my_reputation_screen.dart';
import 'api_client.dart';
import 'app_tab_state.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'provider_wallet_screen.dart';
import 'register_screen.dart';
import 'provider_earnings_screen.dart';
import 'profile_screen.dart';
import 'referral_screen.dart';
import 'account_settings_screen.dart';
import 'app_tab_state.dart';
import 'request_email_verification_screen.dart';
import 'provider_profile_screen.dart';
import 'bookings_screen.dart';
import 'booking_form_screen.dart';
import 'notifications_screen.dart';
import 'my_reviews_screen.dart';
import 'account_screen.dart';
import 'provider_kyc_screen.dart';
import 'provider_check_service.dart';
import 'open_jobs_screen.dart';
import 'package:app_links/app_links.dart';
import 'dart:async';
import 'forgot_password_screen.dart';
import 'l10n/fallback_localization_delegates.dart';

const Color kGradientStart = Color(0xFF111827);
const Color kGradientEnd = Color(0xFF0B0F14);

bool get _stripeSupported {
  if (kIsWeb) return true;
  return Platform.isAndroid || Platform.isIOS || Platform.isMacOS;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Use compile-time environment variable OR default
  const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://styloria.up.railway.app',
  );
  
  const stripeKey = String.fromEnvironment(
    'STRIPE_PUBLISHABLE_KEY',
    defaultValue: '', // Empty default, Stripe won't initialize
  );

  debugPrint('API URL: $apiBaseUrl');

  // Initialize Stripe if key is provided
  if (_stripeSupported && stripeKey.isNotEmpty) {
    try {
      stripe.Stripe.publishableKey = stripeKey;
      await stripe.Stripe.instance.applySettings();
      debugPrint('✅ Stripe initialized successfully');
    } catch (e) {
      debugPrint('⚠️ Warning: Stripe initialization failed: $e');
    }
  }

  runApp(const StyloriaApp());
}


// =======================
// ROOT APP WITH THEME MODE
// =======================

class StyloriaApp extends StatefulWidget {
  const StyloriaApp({super.key});

  static StyloriaAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<StyloriaAppState>();
  }

  @override
  State<StyloriaApp> createState() => StyloriaAppState();
}

class StyloriaAppState extends State<StyloriaApp> {
  ThemeMode _themeMode = ThemeMode.light;
  Locale? _locale;

  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSub;

  bool get isDarkMode => _themeMode == ThemeMode.dark;
  Locale? get locale => _locale;

  // Language list (as requested)
  static const List<Locale> supportedLocales = [
    Locale('en'), // English
    Locale('fr'), // French
    Locale('zh'), // Mandarin (Chinese)
    Locale('ru'), // Russian
    Locale('ko'), // Korean
    Locale('ja'), // Japanese
    Locale('ur'), // Urdu
    Locale('ar'), // Arabic
    Locale('he'), // Hebrew
    Locale('de'), // German
    Locale('it'), // Italian
    Locale('hi'), // Hindi
    Locale('sw'), // Swahili
    Locale('af'), // Afrikaans
    Locale('ha'), // Hausa
    Locale('am'), // Amharic
    Locale('ak'), // Twi (see note: 'ak' is more standard)
  ];

  @override
  void initState() {
    super.initState();
    _loadThemeFromStorage();
    _loadLanguageFromStorage();
    _initDeepLinks();
  }

  void _initDeepLinks() {
    _linkSub?.cancel();
    _linkSub = _appLinks.uriLinkStream.listen((uri) async {
      if (!mounted) return;
      
      print('=== DEEP LINK RECEIVED ===');
      print('URI: $uri');
      print('Scheme: ${uri.scheme}');
      print('Host: ${uri.host}');
      print('Query params: ${uri.queryParameters}');
      print('==========================');
      
      if (uri.scheme != 'styloria') return;
      if (uri.host != 'payment-return') return;

      final gateway = (uri.queryParameters['gateway'] ?? '').trim();
      final txRef = (uri.queryParameters['tx_ref'] ?? '').trim();
      final status = (uri.queryParameters['status'] ?? '').trim();
      final txIdRaw = (uri.queryParameters['transaction_id'] ?? '').trim();
      final reference = (uri.queryParameters['reference'] ?? '').trim();
      final txId = int.tryParse(txIdRaw);

      // Handle Paystack callback
      if (gateway == 'paystack' || reference.startsWith('styloria_')) {
        if (reference.isEmpty) {
          debugPrint('No reference in Paystack deep link');
          mainTabIndex.value = 1;
          bookingsRefreshTick.value++;
          return;
        }
      
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)),
                  SizedBox(width: 16),
                  Text('Verifying Paystack payment...'),
                ],
              ),
              duration: Duration(seconds: 10),
            ),
          );
        }

        try {
          final verifyResult = await ApiClient.verifyPaystackPayment(reference: reference);
 
          if (!mounted) return;
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
 
          mainTabIndex.value = 1;
          bookingsRefreshTick.value++;

          if (verifyResult != null && verifyResult['verified'] == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Payment verified successfully!'), backgroundColor: Colors.green),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(verifyResult?['detail']?.toString() ?? 'Payment verification failed'),
                backgroundColor: Colors.red,
              ),
            );
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error verifying payment: $e'), backgroundColor: Colors.red),
            );
          }
        }
        return;
      }

      // If no tx_ref, we can't verify anything
      if (txRef.isEmpty) {
        debugPrint('No tx_ref in deep link, cannot verify');
        mainTabIndex.value = 1;
        bookingsRefreshTick.value++;
        return;
      }

      // Show a loading indicator via SnackBar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                ),
                SizedBox(width: 16),
                Text('Verifying payment...'),
              ],
            ),
            duration: Duration(seconds: 10),
          ),
        );
      }

      Map<String, dynamic>? verifyResult;

      try {
        // Try verification with transaction_id first (if available)
        if (txId != null && txId > 0) {
          print('Verifying with transaction_id: $txId');
          verifyResult = await ApiClient.verifyFlutterwavePaymentDetailed(
            txRef: txRef,
            transactionId: txId,
          );
        }

        // If verification failed or no transaction_id, try by tx_ref only
        if (verifyResult == null || verifyResult['verified'] != true) {
          print('Falling back to verify by tx_ref only');
          verifyResult = await ApiClient.verifyFlutterwaveByTxRef(txRef: txRef);
        }

        print('Verification result: $verifyResult');

      } catch (e) {
        debugPrint('Payment verification error: $e');
        verifyResult = {'verified': false, 'detail': e.toString()};
      }

      if (!mounted) return;

      // Dismiss the loading SnackBar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      // Navigate to bookings tab
      mainTabIndex.value = 1;
      bookingsRefreshTick.value++;

      // Show result
      if (verifyResult != null && verifyResult['verified'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment verified successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        final detail = verifyResult?['detail']?.toString() ?? 'Payment could not be verified';
        
        // Check if it's actually a cancellation vs failed verification
        final statusLower = status.toLowerCase();
        if (statusLower == 'cancelled') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Payment was cancelled.'),
              backgroundColor: Colors.orange,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Payment verification failed: $detail'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }, onError: (e) {
      debugPrint('Deep link error: $e');
    });

    // Also handle cold start (app opened from deep link)
    _appLinks.getInitialLink().then((uri) {
      if (uri != null) {
        // Re-use the same listener logic
        _linkSub?.onData((u) {}); // trigger with uri
      }
    });
  }

  @override
  void dispose() {
    _linkSub?.cancel();
    super.dispose();
  }

  Future<void> _loadThemeFromStorage() async {
    final saved = await ApiClient.getThemeMode();
    setState(() {
      _themeMode = (saved == 'dark') ? ThemeMode.dark : ThemeMode.light;
    });
  }

  Future<void> toggleTheme() async {
    setState(() {
      _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    });
    await ApiClient.saveThemeMode(isDarkMode ? 'dark' : 'light');
  }

  // -------- LANGUAGE --------

  Future<void> _loadLanguageFromStorage() async {
    final code = await ApiClient.getLanguageCode(); // you must add this in ApiClient
    if (!mounted) return;

    if (code == null || code.trim().isEmpty) {
      setState(() => _locale = null); // follow system language by default
      return;
    }

    final normalized = code.trim();
    final candidate = Locale(normalized);
    final supported = AppLocalizations.supportedLocales
        .any((l) => l.languageCode == candidate.languageCode);
    setState(() => _locale = supported ? candidate : null);
  
  }

  Future<void> setLanguage(String languageCode) async {
    final code = languageCode.trim();
    setState(() => _locale = Locale(code));

    // Save locally (so it persists even if user is logged out)
    await ApiClient.saveLanguageCode(code);

    // Optional: also sync to backend (won’t break if backend doesn’t support it yet)
    try {
      await ApiClient.updateCurrentUser({"preferred_language": code});
    } catch (_) {}
  }

  Future<void> clearLanguageToSystemDefault() async {
    setState(() => _locale = null);
    await ApiClient.saveLanguageCode('');
    try {
      await ApiClient.updateCurrentUser({"preferred_language": ""});
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final lightTheme = AppTheme.light();
    final darkTheme = AppTheme.dark();

    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,

      // Locale support
      locale: _locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        // Your app's localizations
        AppLocalizations.delegate,
        
        // Fallback delegates for unsupported locales (must come BEFORE Global delegates)
        FallbackMaterialLocalizationsDelegate(),
        FallbackCupertinoLocalizationsDelegate(),
        FallbackWidgetsLocalizationsDelegate(),
        
        // Flutter's built-in localizations
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

      home: const AuthGate(),
    );
  }
}


// =======================
// AUTH GATE (AUTO LOGIN)
// =======================

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _loading = true;
  Widget? _child;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    // 1) Check if we even have a token
    final hasToken = await ApiClient.hasAccessToken();
    if (!hasToken) {
      if (!mounted) return;
      setState(() {
        _child = const LoginScreen();
        _loading = false;
      });
      return;
    }

    // 2) Read cached role (allowed), BUT do not skip server call:
    //    we must fetch user at least once to check email_verified.
    final cachedRole = await ApiClient.getCachedUserRole();

    Map<String, dynamic>? userData;
    try {
      userData = await ApiClient.getCurrentUser();
    } catch (_) {
      userData = null;
    }

    if (!mounted) return;

    if (userData == null) {
      // token invalid or server error -> force login
      await ApiClient.logout();
      if (!mounted) return;
      setState(() {
        _child = const LoginScreen();
        _loading = false;
      });
      return;
    }

    final role = (userData['role'] as String?) ?? cachedRole ?? 'user';
    final emailVerified = userData['email_verified'] == true;

    // 3) Email verification gate
    if (!emailVerified) {
      await ApiClient.logout();
      if (!mounted) return;
      setState(() {
        _child = const LoginScreen();
        _loading = false;
      });
      return;
    }

    // 4) Verified -> proceed
    await ApiClient.saveUserRole(role);


    // 5) KYC gate (providers only) BEFORE home
    if (role == 'provider') {
      final provider = await ApiClient.getMyProviderProfileAnyStatus();
      final status = provider?['verification_status']?.toString();

      if (!mounted) return;
  
      if (status != 'approved') {
        setState(() {
          _child = ProviderKycScreen(
            verificationStatus: status,
            reviewNotes: provider?['verification_review_notes']?.toString(),
          );
          _loading = false;
        });
        return;
      }
    }

    // finally go to app
    if (!mounted) return;
    setState(() {
      _child = MainShell(role: role);
      _loading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (_loading || _child == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return _child!;
  }
}

// =======================
// LOGIN SCREEN
// =======================

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  String? _error;
  bool _showPassword = false;

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);

    setState(() {
      _loading = true;
      _error = null;
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    final errorMessage = await ApiClient.login(username, password);

    setState(() => _loading = false);

    if (errorMessage != null) {
      setState(() => _error = errorMessage);
      return;
    }

    final userData = await ApiClient.getCurrentUser();
    if (!mounted) return;

    if (userData == null) {
      setState(() => _error = l10n.loginFailedToLoadUserInfo);
      return;
    }

    final role = userData['role'] as String? ?? 'user';
    await ApiClient.saveUserRole(role);

    if (!mounted) return;

    navigator.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const AuthGate()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: Stack(
        children: [
          BackgroundLayer(
            imageAsset: 'assets/backgrounds/bg_login_black_marble.jpg',
            overlayColor: const Color(0xFF0B0F14),
            overlayOpacity: 0.68,
            child: Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 12,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              l10n.loginWelcomeTitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              l10n.loginWelcomeSubtitle,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                labelText: l10n.username,
                                border: const OutlineInputBorder(),
                              ),
                              validator: (value) =>
                                  (value == null || value.isEmpty)
                                      ? l10n.required
                                      : null,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: l10n.password,
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _showPassword ? Icons.visibility_off : Icons.visibility,
                                  ),
                                  onPressed: () => setState(() => _showPassword = !_showPassword),
                                  tooltip: _showPassword
                                      ? l10n.hidePassword
                                      : l10n.showPassword,
                                ),
                              ),
                              obscureText: !_showPassword,
                              validator: (value) =>
                                  (value == null || value.isEmpty)
                                      ? l10n.required
                                      : null,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              l10n.tapEyeToShowPassword,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            if (_error != null)
                              Text(
                                _error!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: _loading ? null : _handleLogin,
                              child: _loading
                                  ? const SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2),
                                    )
                                  : Text(l10n.login),
                            ),
                            const SizedBox(height: 4),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: _loading
                                    ? null
                                    : () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const ForgotPasswordScreen(),
                                          ),
                                        );
                                      },
                                child: Text(
                                  l10n.forgotPassword,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: _loading
                                  ? null
                                  : () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const RegisterScreen(),
                                        ),
                                      );
                                    },
                              child: Text(l10n.createNewAccount),
                            ),
                            TextButton(
                              onPressed: _loading ? null : () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) => const RequestEmailVerificationScreen()),
                                );
                              },
                              child: Text(l10n.requestEmailVerificationCode),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (_loading)
            Container(
              color: Colors.black45,
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ======================
// MAIN SHELL WITH TABS
// ======================

class MainShell extends StatefulWidget {
  final String role;

  const MainShell({super.key, required this.role});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;
  late List<Widget> _pages;
  late List<BottomNavigationBarItem> _items;
  bool _navBuilt = false;
  String? _firstName;
  String? _profilePictureUrl;
  late final VoidCallback _tabListener;

  @override
  void initState() {
    super.initState();
    _loadHeaderUser();

    _tabListener = () {
      if (!mounted) return;
      setState(() => _currentIndex = mainTabIndex.value);
    };
    mainTabIndex.addListener(_tabListener);
  }

  @override
  void dispose() {
    mainTabIndex.removeListener(_tabListener);
    super.dispose();
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_navBuilt) return;
    final l10n = AppLocalizations.of(context);

    if (widget.role == 'provider') {
      _pages = [
        HomeScreen(role: widget.role),
        const BookingsScreen(role: 'user'),      // provider’s own requests
        const BookingsScreen(role: 'provider'),  // assigned jobs
        const NotificationsScreen(),
        AccountScreen(role: widget.role),
      ];
      _items = [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: AppLocalizations.of(context).navHome),
        BottomNavigationBarItem(icon: Icon(Icons.book_online), label: AppLocalizations.of(context).navBookings),
        const BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Assigned Jobs'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: AppLocalizations.of(context).navNotifications),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: AppLocalizations.of(context).navAccount),
      ];
    } else {
      _pages = [
        HomeScreen(role: widget.role),
        const BookingsScreen(role: 'user'),
        const NotificationsScreen(),
        AccountScreen(role: widget.role),
      ];
      _items = [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: AppLocalizations.of(context).navHome),
        BottomNavigationBarItem(icon: Icon(Icons.book_online), label: AppLocalizations.of(context).navBookings),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: AppLocalizations.of(context).navNotifications),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: AppLocalizations.of(context).navAccount),
      ];
    }

    _navBuilt = true;
  }

  String _resolveUrl(String? raw) {
    if (raw == null || raw.isEmpty) return '';
    if (raw.startsWith('http://') || raw.startsWith('https://')) return raw;
    if (raw.startsWith('/')) return '${ApiClient.baseUrl}$raw';
    return raw;
  }

  Future<void> _loadHeaderUser() async {
    final u = await ApiClient.getCurrentUser();
    if (!mounted || u == null) return;
    setState(() {
      _firstName = (u['first_name'] ?? '').toString().trim();
      _profilePictureUrl = _resolveUrl(u['profile_picture_url']?.toString());
    });
  }

  int get _bookingsTabIndex => 1;
  int get _notificationsTabIndex => widget.role == 'provider' ? 3 : 2;

  Future<void> _openHelp() async {
    final uri = Uri.parse('mailto:support@styloria.app?subject=Styloria%20Help');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Widget _topMenuBar() {
    final isProvider = widget.role == 'provider';
    final greeting = (_firstName != null && _firstName!.isNotEmpty)
        ? 'Hello ${_firstName!}'
        : 'Hello';

    return Material(
      elevation: 2,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: (_profilePictureUrl != null && _profilePictureUrl!.isNotEmpty)
                        ? NetworkImage(_profilePictureUrl!)
                        : null,
                    child: (_profilePictureUrl == null || _profilePictureUrl!.isEmpty)
                        ? const Icon(Icons.person, size: 18)
                        : null,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      greeting,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
                    ),
                    child: const Text('View Profile'),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () => mainTabIndex.value = _bookingsTabIndex,
                      child: const Text('Bookings'),
                    ),
                    TextButton(
                      onPressed: () => mainTabIndex.value = _notificationsTabIndex,
                      child: const Text('Notifications'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ReferralScreen()),
                      ),
                      child: const Text('Referral'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AccountSettingsScreen()),
                      ),
                      child: const Text('Settings'),
                    ),
                    TextButton(
                      onPressed: _openHelp,
                      child: const Text('Help'),
                    ),
                    if (isProvider) ...[
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const ProviderWalletScreen()),
                        ),
                        child: const Text('Wallet'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const ProviderEarningsScreen()),
                        ),
                        child: const Text('Earnings'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const OpenJobsScreen()),
                        ),
                        child: const Text('Open Jobs'),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {  
    // Safety: don't build BottomNavigationBar (needs _items) until nav is built.
    if (!_navBuilt) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          mainTabIndex.value = index;
          if (index == _bookingsTabIndex) {
            bookingsRefreshTick.value++;
          }
        },
        items: _items,
      ),
    );
  }
}

// ============
// HOME SCREEN
// ============

class HomeScreen extends StatefulWidget {
  final String role;

  const HomeScreen({super.key, required this.role});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _unreadCount = 0;
  String? _profilePictureUrl;
  String? _userAddress;
  String? _firstName;

  @override
  void initState() {
    super.initState();
    _loadProfilePicture();
    _loadUnreadCount();
    _loadUserAddress();
    _loadFirstName();
    _checkAndSurfaceImportantNotifications();

  }

  Future<void> _checkAndSurfaceImportantNotifications() async {
    final messenger = ScaffoldMessenger.of(context);

    try {
      final notes = await ApiClient.getNotifications();
      if (!mounted || notes == null || notes.isEmpty) return;

      // find the newest unread important message
      Map<String, dynamic>? important;
      for (final item in notes) {
        final n = item as Map<String, dynamic>;
        final read = n['read'] == true;
        if (read) continue;
        final msg = (n['message'] ?? '').toString();

        final isNoProviders = msg.contains('We’re sorry—there are currently no available providers');
        final isGoodNews = msg.contains('Good news—providers are now available for your request');

        if (isNoProviders || isGoodNews) {
          important = n;
          break;
        }
      }

      if (important == null) return;

      final id = important['id'];
      final message = (important['message'] ?? '').toString();

      if (message.trim().isNotEmpty) {
        messenger.showSnackBar(
          SnackBar(content: Text(message)),
        );
      }

      // Mark read so it doesn't keep popping up.
      if (id != null) {
        final parsedId = (id is int) ? id : int.tryParse(id.toString());
        if (parsedId != null) {
          await ApiClient.markNotificationRead(parsedId);
          if (mounted) _loadUnreadCount();
        }
      }
    } catch (_) {}
  }

  Future<void> _loadUserAddress() async {
    try {
      final userData = await ApiClient.getCurrentUser();
      if (!mounted || userData == null) return;
      setState(() {
        _userAddress = userData['address']?.toString();
      });
    } catch (_) {}
  }

  Future<void> _loadProfilePicture() async {
    try {
      final userData = await ApiClient.getCurrentUser();
      if (!mounted || userData == null) return;
      setState(() {
        _profilePictureUrl = userData['profile_picture_url']?.toString();
      });
    } catch (_) {}
  }

  Future<void> _loadFirstName() async {
    try {
      final userData = await ApiClient.getCurrentUser();
      if (!mounted || userData == null) return;

      final first = (userData['first_name'] ?? '').toString().trim();
      setState(() => _firstName = first);
    } catch (_) {}
  }

  Future<void> _loadUnreadCount() async {
    try {
      final count = await ApiClient.getUnreadNotificationCount();
      if (!mounted) return;
      setState(() => _unreadCount = count);
    } catch (_) {
      if (!mounted) return;
      setState(() => _unreadCount = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = StyloriaApp.of(context);
    final isDark = appState?.isDarkMode ?? false;
    final l10n = AppLocalizations.of(context);
    final roleLabel = (widget.role == 'provider')
        ? l10n.providerLabel
        : l10n.customer;

    return Scaffold(
      body: BackgroundLayer(
        imageAsset: 'assets/backgrounds/bg_home_white_marble.jpg',
        overlayColor: Colors.white,
        overlayOpacity: 0.35,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kGradientStart, kGradientEnd],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (_firstName != null && _firstName!.isNotEmpty)
                              ? l10n.welcomeName(_firstName!)
                              : l10n.welcome,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const ProfilePictureScreen(),
                                      ),
                                    )
                                    .then((_) => _loadProfilePicture());
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: _profilePictureUrl != null
                                    ? NetworkImage(_profilePictureUrl!)
                                    : null,
                                child: _profilePictureUrl == null
                                    ? const Icon(Icons.person,
                                        size: 20, color: Colors.white)
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: Icon(
                                isDark ? Icons.dark_mode : Icons.light_mode,
                                color: Colors.white,
                              ),
                              tooltip: l10n.toggleThemeTooltip,
                              onPressed: () => appState?.toggleTheme(),
                            ),
                            PopupMenuButton<String>(
                              iconColor: Colors.white,
                              onSelected: (v) async {
                                if (v == 'bookings') mainTabIndex.value = 1;
                                if (v == 'notifications') mainTabIndex.value = (widget.role == 'provider' ? 3 : 2);
                                if (v == 'referral') {
                                  await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ReferralScreen()));
                                }
                                if (v == 'settings') {
                                  await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AccountSettingsScreen()));
                                }
                                if (v == 'help') {
                                  final uri = Uri.parse('mailto:support@styloria.app?subject=Styloria%20Help');
                                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                                }
                                if (v == 'wallet') {
                                  await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProviderWalletScreen()));
                                }
                                if (v == 'earnings') {
                                  await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProviderEarningsScreen()));
                                }
                                if (v == 'open_jobs') {
                                  await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OpenJobsScreen()));
                                }
                              },
                              itemBuilder: (_) => [
                                const PopupMenuItem(value: 'bookings', child: Text('Bookings')),
                                const PopupMenuItem(value: 'notifications', child: Text('Notifications')),
                                const PopupMenuItem(value: 'referral', child: Text('Referral')),
                                const PopupMenuItem(value: 'settings', child: Text('Settings')),
                                const PopupMenuItem(value: 'help', child: Text('Help')),
                                if (widget.role == 'provider') ...[
                                  const PopupMenuDivider(),
                                  const PopupMenuItem(value: 'wallet', child: Text('Wallet')),
                                  const PopupMenuItem(value: 'earnings', child: Text('Earnings')),
                                  const PopupMenuItem(value: 'open_jobs', child: Text('Open Jobs')),
                                ],
                              ],
                            ),
                            IconButton(
                              icon:
                                  const Icon(Icons.logout, color: Colors.white),
                              onPressed: () async {
                                await ApiClient.logout();
                                if (!context.mounted) return;
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (_) => const LoginScreen()),
                                  (route) => false,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.loggedInAs(roleLabel),
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    if (_userAddress != null && _userAddress!.isNotEmpty)
                      Text(
                        l10n.locationWithValue(_userAddress!),
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 13),
                      )
                    else
                      Text(
                        l10n.homeTagline,
                        style: const TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (widget.role == 'provider') ...[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const ProviderProfileScreen(),
                              ),
                            );
                          },
                          child: Text(l10n.manageProviderProfile),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const OpenJobsScreen(),
                              ),
                            );
                          },
                          child: Text(l10n.browseOpenJobs),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const ProviderWalletScreen(),
                              ),
                            );
                          },
                          child: Text(l10n.walletTitle),
                        ),
                        const SizedBox(height: 12),
                      ],
                      Center(
                        child: Text(
                          l10n.quickActions,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const BookingFormScreen(),
                            ),
                          );
                        },
                        child: Text(l10n.newBooking),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const MyReviewsScreen(),
                            ),
                          );
                        },
                        child: Text(l10n.myReviewsTitle),
                      ),
                      const SizedBox(height: 12),

                      // ✅ NEW: "My Reputation" button - only for user/customer accounts
                      if (widget.role != 'provider') ...[
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const MyReputationScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.star_outline),
                          label: const Text('My Reputation'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade600,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],

                      ElevatedButton(
                        onPressed: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const NotificationsScreen()),
                          );
                          if (!mounted) return;
                          _loadUnreadCount();
                        },
                        child: Text(
                          _unreadCount > 0
                              ? l10n.notificationsWithUnread(_unreadCount)
                              : l10n.navNotifications,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
