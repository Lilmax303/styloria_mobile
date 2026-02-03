// lib/bookings_screen.dart

import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import 'api_client.dart';
import 'app_tab_state.dart';
import 'booking_detail_screen.dart';
import 'utils/datetime_helper.dart';
import 'open_jobs_screen.dart';
import 'provider_profile_screen.dart';
import 'currency_helper.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'africa_countries.dart';

bool get _stripeSupported {
  if (kIsWeb) return true;
  return Platform.isAndroid || Platform.isIOS || Platform.isMacOS;
}

class BookingsScreen extends StatefulWidget {
  final String role; // "user" or "provider"

  const BookingsScreen({super.key, required this.role});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  bool _loading = true;
  bool _needsProfileSetup = false;
  String? _error;
  List<dynamic>? _bookings;

  // Used to format money properly for the logged-in user
  String _userCountry = 'United States';


  int? _toInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString());
  }

  void _onRefreshTick() {
    if (!mounted) return;
    _loadBookings();
  }

  @override
  void dispose() {
    bookingsRefreshTick.removeListener(_onRefreshTick);
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    _bootstrap();
    bookingsRefreshTick.addListener(_onRefreshTick);
  }

  Future<void> _bootstrap() async {
    await _loadUserCountry();
    await _loadBookings();
    await _checkAndSurfaceImportantNotifications();
  }

  Future<void> _checkAndSurfaceImportantNotifications() async {
    // Only the requester (user role) should see the "good news" prompt.
    if (widget.role != 'user') return;

    final messenger = ScaffoldMessenger.of(context);

    try {
      final notes = await ApiClient.getNotifications();
      if (!mounted || notes == null || notes.isEmpty) return;

      Map<String, dynamic>? important;
      for (final item in notes) {
        final n = item as Map<String, dynamic>;
        final read = n['read'] == true;
        if (read) continue;
        final msg = (n['message'] ?? '').toString();

        final isGoodNews =
            msg.contains('Good news—providers are now available for your request');
        if (isGoodNews) {
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
      final parsedId = (id is int) ? id : int.tryParse(id?.toString() ?? '');
      if (parsedId != null) {
        await ApiClient.markNotificationRead(parsedId);
      }
    } catch (_) {}
  }

  Future<void> _loadUserCountry() async {
    try {
      final user = await ApiClient.getCurrentUser();
      if (!mounted) return;

      final country = user?['country_name']?.toString().trim();
      if (country != null && country.isNotEmpty) {
        setState(() => _userCountry = country);
      }
    } catch (_) {
      // keep default
    }
  }

  Future<void> _loadBookings() async {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _loading = true;
      _needsProfileSetup = false;
      _error = null;
    });

    List<dynamic>? data;

    if (widget.role == 'provider') {
      // Check if provider has a profile before loading bookings
      final profile = await ApiClient.getMyProviderProfile();
      if (profile == null) {
        if (!mounted) return;
        setState(() {
          _loading = false;
          _needsProfileSetup = true;
          _error = l10n.pleaseCompleteProviderProfileFirst;
        });
        _showProfileSetupPrompt();
        return;
      }

      data = await ApiClient.getProviderBookings();
    } else {
      data = await ApiClient.getUserBookings();
    }

    if (!mounted) return;

    setState(() {
      _loading = false;
      if (data == null) {
        _error = l10n.failedToLoadBookings;
      } else {
        _bookings = data;
      }
    });

    // While user is sitting on Bookings tab, surface "good news" notifications too.
    await _checkAndSurfaceImportantNotifications();
  }

  void _showProfileSetupPrompt() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final l10n = AppLocalizations.of(context)!;
      if (!mounted) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text(l10n.profileSetupRequiredTitle),
          content: Text(l10n.profileSetupRequiredBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.later),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (context) => const ProviderProfileScreen(),
                  ),
                )
                    .then((_) {
                  _loadBookings();
                });
              },
              child: Text(l10n.setupNow),
            ),
          ],
        ),
      );
    });
  }

  // Accepts "50.00" or "GH₵50.00" or "$ 50" etc.
  double? _parseAmount(dynamic raw) {
    if (raw == null) return null;
    final text = raw.toString().trim();
    if (text.isEmpty) return null;

    // keep digits, dot and minus only
    final cleaned = text.replaceAll(RegExp(r'[^0-9\.\-]'), '');
    if (cleaned.isEmpty) return null;

    return double.tryParse(cleaned);
  }

  String _formatMoney(dynamic raw) {
    final amount = _parseAmount(raw);
    if (amount == null) return raw?.toString() ?? '';
    return CurrencyHelper.formatAmount(amount, _userCountry);
  }

  Future<double?> _chooseAmountFromPriceOptions(int bookingId) async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);

    final priceData = await ApiClient.getPriceOptions(bookingId);
    if (!mounted) return null;
    if (priceData == null) {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.failedToCreatePaymentIntent)),
      );
      return null;
    }

    final detail = priceData['detail']?.toString();
    final budget = _parseAmount(priceData['budget_price']);
    final standard = _parseAmount(priceData['standard_price']);
    final priority = _parseAmount(priceData['priority_price']);

    final hasNoProvidersMessage = detail != null && detail.trim().isNotEmpty;
    final hasNoPrices = budget == null && standard == null && priority == null;

    // If backend says no providers, show that message to the requester.
    if (hasNoProvidersMessage && hasNoPrices) {
      messenger.showSnackBar(
        SnackBar(content: Text(detail)),
      );
      return null;
    }

    // If we have prices, let user pick one.
    return showDialog<double>(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text(l10n.chooseYourPriceOptionTitle),
        children: [
          if (budget != null)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, budget),
              child: Text('${l10n.budgetTierTitle}: ${_formatMoney(budget)}'),
            ),
          if (standard != null)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, standard),
              child: Text('${l10n.standardTierTitle}: ${_formatMoney(standard)}'),
            ),
          if (priority != null)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, priority),
              child: Text('${l10n.priorityTierTitle}: ${_formatMoney(priority)}'),
            ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }

  String _localizedPaymentStatus(AppLocalizations l10n, String raw) {
    final s = raw.trim().toLowerCase();
    switch (s) {
      case 'paid':
        return l10n.paymentPaid;
      case 'unpaid':
        return l10n.paymentUnpaid;
      case 'pending':
        return l10n.paymentPending;
      case '':
        return l10n.paymentUnknown;
      default:
        return raw; // keep server value if it’s something new
    }
  }

  /// Shows dialog to reset appointment time for unpaid booking
  Future<bool> _showAppointmentResetDialog(int bookingId) async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    
    TimeOfDay? selectedTime;
    
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.schedule, color: Colors.orange),
                  const SizedBox(width: 8),
                  const Expanded(child: Text('Reschedule Required')),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.orange.shade700, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Your booking was left unpaid. Please select a new time for TODAY to continue with payment.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.orange.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Select new appointment time:',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final now = TimeOfDay.now();
                        // Start from at least 30 minutes from now
                        final minHour = now.hour + (now.minute >= 30 ? 1 : 0);
                        final minMinute = now.minute >= 30 ? 0 : 30;
                        
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                            hour: minHour < 24 ? minHour : 23,
                            minute: minMinute,
                          ),
                          helpText: 'Select time for TODAY',
                        );
                        
                        if (picked != null) {
                          // Validate: must be at least 30 minutes from now
                          final nowDateTime = DateTime.now();
                          final pickedDateTime = DateTime(
                            nowDateTime.year,
                            nowDateTime.month,
                            nowDateTime.day,
                            picked.hour,
                            picked.minute,
                          );
                          final minDateTime = nowDateTime.add(const Duration(minutes: 30));
                          
                          if (pickedDateTime.isBefore(minDateTime)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a time at least 30 minutes from now.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          
                          setDialogState(() {
                            selectedTime = picked;
                          });
                        }
                      },
                      icon: const Icon(Icons.access_time),
                      label: Text(
                        selectedTime != null
                            ? 'Today at ${selectedTime!.format(context)}'
                            : 'Tap to select time',
                        style: TextStyle(
                          fontWeight: selectedTime != null ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '* Must be at least 30 minutes from now',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: Text(l10n.cancel),
                ),
                ElevatedButton(
                  onPressed: selectedTime == null
                      ? null
                      : () async {
                          // Build ISO datetime string for today
                          final now = DateTime.now();
                          final appointmentDateTime = DateTime(
                            now.year,
                            now.month,
                            now.day,
                            selectedTime!.hour,
                            selectedTime!.minute,
                          );
                          final isoString = appointmentDateTime.toUtc().toIso8601String();

                          // Call API to reset appointment time
                          final result = await ApiClient.resetAppointmentTime(
                            serviceRequestId: bookingId,
                            appointmentTime: isoString,
                          );

                          if (result['success'] == true) {
                            Navigator.of(dialogContext).pop(true);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(result['detail'] ?? 'Failed to update time'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                  child: const Text('Continue to Payment'),
                ),
              ],
            );
          },
        );
      },
    );

    return result == true;
  }

  Future<void> _payForBooking({
    required int bookingId,
    double? amount,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    // Check if this is an unpaid booking that needs time reset
    final booking = await ApiClient.getServiceRequest(bookingId);
    if (!mounted) return;
    
    if (booking != null) {
      final paymentStatus = booking['payment_status']?.toString() ?? '';
      final status = booking['status']?.toString() ?? '';

      // If booking is unpaid and pending, check if appointment time needs reset
      if (paymentStatus == 'unpaid' && status == 'pending') {
        final appointmentTimeStr = booking['appointment_time']?.toString() ?? '';
        if (appointmentTimeStr.isNotEmpty) {
          try {
            final appointmentTime = DateTime.parse(appointmentTimeStr);
            final now = DateTime.now();
            final today = DateTime(now.year, now.month, now.day);
            final appointmentDay = DateTime(
              appointmentTime.year,
              appointmentTime.month,
              appointmentTime.day,
            );

            // If appointment is not today OR is in the past, require reset
            final isNotToday = appointmentDay != today;
            final isInPast = appointmentTime.isBefore(now);

            if (isNotToday || isInPast) {
              final resetSuccess = await _showAppointmentResetDialog(bookingId);
              if (!mounted) return;
              if (!resetSuccess) {
                // User cancelled the reset dialog
                return;
              }
            }
          } catch (e) {
            // If we can't parse the date, require reset to be safe
            final resetSuccess = await _showAppointmentResetDialog(bookingId);
            if (!mounted) return;
            if (!resetSuccess) return;
          }
        }
      }
    }

    // Determine the correct payment gateway
    final paymentGateway = ApiClient.getPaymentGateway(_userCountry);
    final isPaystack = paymentGateway == 'paystack';
    final isFlutterwave = paymentGateway == 'flutterwave';
    final isStripe = paymentGateway == 'stripe';

    // Only block if we actually need Stripe and it's not supported
    if (isStripe && !_stripeSupported) {
      if (!mounted) return;
      messenger.showSnackBar(SnackBar(content: Text(l10n.paymentsNotSupportedShort)));
      return;
    }

    // If no amount was provided (waitlist case), fetch live price options now.
    amount ??= await _chooseAmountFromPriceOptions(bookingId);
    if (!mounted) return;
    if (amount == null || amount <= 0) return;

    // Optional confirm dialog (helps prevent accidental charges)
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l10n.confirmPaymentTitle),
        content: Text(l10n.confirmPaymentBody(_formatMoney(amount))),
        actions: [
          TextButton(
            onPressed: () => navigator.pop(false),
            child: Text(l10n.no),
          ),
          ElevatedButton(
            onPressed: () => navigator.pop(true),
            child: Text(l10n.yesPay),
          ),
        ],
      ),
    );

    if (!mounted) return;
    if (confirm != true) return;

    try {
      Future<Map<String, dynamic>?> _waitForPaid(int requestId) async {
        const timeout = Duration(seconds: 20);
        const step = Duration(seconds: 2);
        final start = DateTime.now();
        while (DateTime.now().difference(start) < timeout) {
          final sr = await ApiClient.getServiceRequest(requestId);
          if (sr != null) {
            final pay = (sr['payment_status'] ?? '').toString();
            if (pay == 'paid') return sr;
          }
          await Future.delayed(step);
        }
        return null;
      }

      // PAYSTACK COUNTRIES (Ghana, Nigeria, South Africa, Kenya, Côte d'Ivoire)
      if (isPaystack) {
        // Reset any previous failed/cancelled payment attempt
        await ApiClient.resetPaystackPayment(bookingId);
 
        final checkout = await ApiClient.createPaystackCheckout(
          serviceRequestId: bookingId,
          amount: amount,
        );
        if (!mounted) return;
        if (checkout == null) {
          messenger.showSnackBar(
            SnackBar(content: Text(l10n.failedToCreatePaymentIntent)),
          );
          return;
        }
 
        final authorizationUrl = (checkout['authorization_url'] ?? '').toString();
        final reference = (checkout['reference'] ?? '').toString();
 
        if (authorizationUrl.isEmpty) {
          messenger.showSnackBar(
            SnackBar(content: Text(l10n.failedToCreatePaymentIntent)),
          );
          return;
        }
 
        // Open Paystack checkout in WebView or external browser
        final result = await _openPaystackCheckout(authorizationUrl, reference, bookingId);
        if (!mounted) return;
 
        if (result == true) {
          // Payment was verified automatically by the polling dialog
          await showDialog(
            context: context,
            builder: (dialogContext) => AlertDialog(
              title: Row(
                children: const [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Payment Successful'),
                ],
              ),
              content: Text(l10n.paymentSuccessfulShort),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          mainTabIndex.value = 1;
          _loadBookings();
          return;
        }

        // Payment was cancelled or failed - refresh bookings anyway
        _loadBookings();
        return;
      }
 
      // OTHER AFRICAN COUNTRIES -> Flutterwave
      if (isFlutterwave) {
        // Reset any previous failed/cancelled payment attempt
        await ApiClient.resetFlutterwavePayment(bookingId);

        final checkout = await ApiClient.createFlutterwaveCheckout(
          serviceRequestId: bookingId,
          amount: amount,
        );
        if (!mounted) return;
        if (checkout == null) {
          messenger.showSnackBar(
            SnackBar(content: Text(l10n.failedToCreatePaymentIntent)),
          );
          return;
        }

        final publicKey = (checkout['public_key'] ?? '').toString();
        final txRef = (checkout['tx_ref'] ?? '').toString();
        final currency = (checkout['currency'] ?? 'USD').toString();
        final customerEmail = (checkout['customer_email'] ?? '').toString();
        final customerPhone = (checkout['customer_phone'] ?? '').toString();
        final customerName = (checkout['customer_name'] ?? '').toString();


        final amountStr = amount.toStringAsFixed(2);

        final flutterwave = Flutterwave(
          publicKey: publicKey,
          currency: currency,
          txRef: txRef,
          amount: amountStr,
          customer: Customer(
            name: customerName.isNotEmpty ? customerName : 'Customer',
            phoneNumber: customerPhone.isNotEmpty ? customerPhone : '+0000000000',
            email: customerEmail.isNotEmpty ? customerEmail : 'user@styloria.com',
          ),
          paymentOptions: "card,banktransfer,ussd,mobilemoney",
          customization: Customization(
            title: "Styloria Booking Payment",
            description: "Confirm your booking payment",
            logo: "https://styloria.com/logo.png",  // Optional
          ),
          isTestMode: (checkout['is_test_mode'] == true),
          redirectUrl: checkout['redirect_url']?.toString() ?? "https://locally-sinistrodextral-raelene.ngrok-free.dev/flutterwave/redirect/",
        );

        final resp = await flutterwave.charge(context);
        if (!mounted) return;

        print('=== FLUTTERWAVE SDK RESPONSE ===');
        print('Status: "${resp.status}"');
        print('Transaction ID: "${resp.transactionId}"');
        print('================================');

        // Try to get transaction ID
        final int? transactionId = _toInt(resp.transactionId);

        Map<String, dynamic>? verifiedRes;

        // Try verification with transaction_id first
        if (transactionId != null && transactionId > 0) {
          verifiedRes = await ApiClient.verifyFlutterwavePaymentDetailed(
            txRef: txRef,
            transactionId: transactionId,
          );
        }

        // Fallback: verify by tx_ref only
        if (verifiedRes == null || verifiedRes["verified"] != true) {
          verifiedRes = await ApiClient.verifyFlutterwaveByTxRef(txRef: txRef);
        }

        if (!mounted) return;

        if (verifiedRes["verified"] == true) {
          await showDialog(
            context: context,
            builder: (dialogContext) => AlertDialog(
              title: const Text('Payment successful'),
              content: Text(l10n.paymentSuccessfulShort),
              actions: [
                TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('OK')),
              ],
            ),
          );
          mainTabIndex.value = 1;
          _loadBookings();
          return;
        }

        // Verification failed - but don't show error yet
        // The deep link handler might catch it when user returns
        // Just refresh bookings in case it was verified via webhook
        _loadBookings();
        return;
      }

      // NON-AFRICA -> Stripe (existing flow)
      final pi = await ApiClient.createPaymentIntentDetailed(
        bookingId,
        offeredPrice: amount,
      );

      if (!mounted) return;

      if (pi["ok"] != true || (pi["client_secret"] ?? '').toString().isEmpty) {

        // Backend now blocks payment when no providers are available.
        // We already surface the correct message via price_options, but keep a fallback.

        messenger.showSnackBar(
          SnackBar(content: Text(l10n.failedToCreatePaymentIntent)),
        );
        return;
      }
      final clientSecret = pi["client_secret"].toString();

      await stripe.Stripe.instance.initPaymentSheet(
        paymentSheetParameters: stripe.SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Styloria',
          style: ThemeMode.system,
        ),
      );

      await stripe.Stripe.instance.presentPaymentSheet();

      await ApiClient.confirmStripePayment(
        serviceRequestId: bookingId,
        paymentIntentId: (pi["payment_intent_id"] ?? "").toString(),
      );
      final paid = await _waitForPaid(bookingId);

      if (!mounted) return;
      if (paid == null) {
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.paymentSucceededButFailedUpdateBooking)),
        );
        return;
      }

      await showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Payment successful'),
          content: Text(l10n.paymentSuccessfulShort),
          actions: [
            TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('OK')),
          ],
        ),
      );
      mainTabIndex.value = 1; // Bookings tab
      _loadBookings();
    } on stripe.StripeException catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            l10n.paymentCancelledOrFailedReason(e.error.localizedMessage ?? ''),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.unexpectedPaymentErrorReason(e.toString())),
        ),
      );
    }
  }

  /// Opens Paystack checkout URL and automatically polls for payment completion
  Future<bool> _openPaystackCheckout(String authorizationUrl, String reference, int bookingId) async {
    final uri = Uri.parse(authorizationUrl);
    bool paymentVerified = false;
    bool dialogDismissed = false;
    
    // Launch Paystack checkout URL
    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
 
    if (!launched) {
      if (!mounted) return false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open payment page')),
      );
      return false;
    }
 
    if (!mounted) return false;
 
    // Show waiting dialog with auto-polling
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => _PaymentWaitingDialog(
        reference: reference,
        bookingId: bookingId,
        onPaymentVerified: () {
          paymentVerified = true;
          if (!dialogDismissed) {
            dialogDismissed = true;
            Navigator.of(dialogContext).pop();
          }
        },
        onCancel: () {
          if (!dialogDismissed) {
            dialogDismissed = true;
            Navigator.of(dialogContext).pop();
          }
        },
      ),
    );
 
    // Wait for dialog to be dismissed
    await Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 100));
      return !dialogDismissed && mounted;
    });
 
    return paymentVerified;
  }

  Future<void> _openReviewDialog(int providerId, String providerName, int bookingId) async {
    final l10n = AppLocalizations.of(context)!;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return _ReviewDialogWidget(
          providerName: providerName,
          onSubmit: (rating, comment) async {
            final ok = await ApiClient.submitReview(
              providerId: providerId,
              rating: rating,
              comment: comment,
              serviceRequestId: bookingId,
            );
            return ok;
          },
        );
      },
    );

    if (!mounted) return;

    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.reviewSubmitted)),
      );
      _loadBookings(); // Refresh to update the UI
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final title = widget.role == 'provider'
      ? 'Assigned Jobs'
      : l10n.myBookingsTitle;

    Widget bodyContent;

    if (_loading) {
      bodyContent = const Center(child: CircularProgressIndicator());
    } else if (_error != null) {
      bodyContent = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            if (_needsProfileSetup) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (context) => const ProviderProfileScreen(),
                    ),
                  )
                      .then((_) {
                    _loadBookings();
                  });
                },
                child: Text(l10n.setupProfileNow),
              ),
            ],
          ],
        ),
      );
    } else if (_bookings == null || _bookings!.isEmpty) {
      bodyContent = Center(child: Text(l10n.noBookingsFound));
    } else {
      final listView = RefreshIndicator(
        onRefresh: _loadBookings,
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: _bookings!.length,
          itemBuilder: (context, index) {
            final booking = _bookings![index] as Map<String, dynamic>;

            final idRaw = booking['id'];
            final id = idRaw is int ? idRaw : int.tryParse(idRaw.toString()) ?? 0;

            final status = booking['status']?.toString() ?? '';
            final paymentStatus = booking['payment_status']?.toString() ?? '';

            final estimatedPriceRaw = booking['estimated_price'];
            final estimatedPriceText = estimatedPriceRaw?.toString() ?? '';

            // ✅ USE TIMEZONE HELPER FOR APPOINTMENT TIME
            final appointmentTime = booking['appointment_time']?.toString() ?? '';
            final dateStr = DateTimeHelper.formatDateOnly(appointmentTime);
            final timeStr = DateTimeHelper.formatTimeOnly(appointmentTime);
            final isToday = DateTimeHelper.isToday(appointmentTime);

            final serviceType = booking['service_type']?.toString() ?? 'N/A';

            final provider = booking['service_provider'] as Map<String, dynamic>?;
            final user = booking['user'] as Map<String, dynamic>?;

            String counterpart = '';
            int? providerId;

            if (widget.role == 'user') {
              if (provider != null) {
                providerId = provider['id'] as int?;
                final providerUser = provider['user'] as Map<String, dynamic>?;
                if (providerUser != null) {
                  counterpart = providerUser['username']?.toString() ?? '';
                }
              }
            } else {
              if (user != null) {
                counterpart = user['username']?.toString() ?? '';
              }
            }


            final isPaid = paymentStatus == 'paid';
            final isCancelled = status == 'cancelled';
            final isCompleted = status == 'completed';
           

            final canPay = widget.role == 'user' &&
                !isPaid &&
                !isCancelled &&
                !isCompleted &&
                status == 'pending';

            // Check if user already reviewed (backend provides this in booking data)
            final hasUserReview = booking['has_user_review'] == true;
            final canRate = widget.role == 'user' && isCompleted && providerId != null && !hasUserReview;

            final List<Widget> actionWidgets = [];

            if (widget.role == 'user') {
              if (canPay) {
                actionWidgets.add(
                  TextButton(
                    onPressed: () => _payForBooking(
                      bookingId: id,
                    ),
                    child: Text(l10n.pay),
                  ),
                );
              }

              if (canRate) {
                actionWidgets.add(
                  TextButton(
                    onPressed: () => _openReviewDialog(providerId!, counterpart, id),
                    child: Text(l10n.rate),
                  ),
                );
              }
            }

            Widget? actionsRow;
            if (actionWidgets.isNotEmpty) {
              actionsRow = Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actionWidgets,
              );
            }

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BookingDetailScreen(
                        booking: booking,
                        role: widget.role,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.bookingNumber(id),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          _StatusChip(status: status),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(l10n.serviceLine(serviceType), style: const TextStyle(fontSize: 14)),
                      // Auto-cancel warning for unpaid bookings
                      if (_buildAutoCancelWarning(booking) != null) ...[
                        const SizedBox(height: 6),
                        _buildAutoCancelWarning(booking)!,
                      ],

                      // ✅ IMPROVED TIME DISPLAY WITH TIMEZONE
                      if (dateStr.isNotEmpty || timeStr.isNotEmpty) ...[
                        Row(
                          children: [
                            Icon(
                              isToday ? Icons.today : Icons.calendar_today,
                              size: 14,
                              color: isToday ? Colors.orange : Colors.grey[600],
                            ),
                            const SizedBox(width: 6),
                            Text(
                              timeStr.isNotEmpty 
                                  ? (isToday ? 'Today at $timeStr' : '$dateStr at $timeStr')
                                  : dateStr,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: isToday ? FontWeight.w600 : FontWeight.normal,
                                color: isToday ? Colors.orange : null,
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (counterpart.isNotEmpty)
                        Text(
                          widget.role == 'user' ? l10n.providerLine(counterpart) : l10n.userLine(counterpart),
                          style: const TextStyle(fontSize: 13),
                        ),

                      Text(
                        l10n.paymentLine(_localizedPaymentStatus(l10n, paymentStatus)),
                        style: const TextStyle(fontSize: 13),
                      ),

                      if (actionsRow != null) ...[
                        const SizedBox(height: 8),
                        actionsRow,
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );

      if (widget.role == 'provider') {
        bodyContent = Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const OpenJobsScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.search),
                label: Text(l10n.findNearbyOpenJobs),
              ),
            ),
            Expanded(child: listView),
          ],
        );
      } else {
        bodyContent = listView;
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: bodyContent,
    );
  }
  
  /// Builds auto-cancel warning widget if booking is approaching deadline
  Widget? _buildAutoCancelWarning(Map<String, dynamic> booking) {
    final warning = booking['auto_cancel_warning'] as Map<String, dynamic>?;
    if (warning == null) return null;

    final level = warning['level']?.toString() ?? 'info';
    final message = warning['message']?.toString() ?? '';
    final hoursRemaining = (warning['hours_remaining'] as num?)?.toDouble() ?? 0;

    if (message.isEmpty) return null;

    Color bgColor;
    Color borderColor;
    Color textColor;
    IconData icon;
    
    switch (level) {
      case 'critical':
        bgColor = Colors.red.shade50;
        borderColor = Colors.red.shade300;
        textColor = Colors.red.shade900;
        icon = Icons.error;
        break;
      case 'warning':
        bgColor = Colors.orange.shade50;
        borderColor = Colors.orange.shade300;
        textColor = Colors.orange.shade900;
        icon = Icons.warning;
        break;
      default:
        bgColor = Colors.blue.shade50;
        borderColor = Colors.blue.shade200;
        textColor = Colors.blue.shade900;
        icon = Icons.info_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 11,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  Color get _color {
    switch (status) {
      case 'pending':
      case 'open':
        return Colors.grey;
      case 'accepted':
        return Colors.blue;
      case 'in_progress':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    String display;
    switch (status) {
     case 'pending':
      case 'open':
        display = 'Pending';
        break;
      case 'accepted':
        display = l10n.statusAccepted;
        break;
      case 'in_progress':
        display = l10n.statusInProgress;
        break;
      case 'completed':
        display = l10n.statusCompleted;
        break;
      case 'cancelled':
        display = l10n.statusCancelled;
        break;
      default:
        display = l10n.statusUnknown;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withAlpha(26),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _color),
      ),


      child: Text(
        display,
        style: TextStyle(
          color: _color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// Separate stateful widget for review dialog to properly manage controller lifecycle
class _ReviewDialogWidget extends StatefulWidget {
  final String providerName;
  final Future<bool> Function(int rating, String comment) onSubmit;

  const _ReviewDialogWidget({
    required this.providerName,
    required this.onSubmit,
  });

  @override
  State<_ReviewDialogWidget> createState() => _ReviewDialogWidgetState();
}

class _ReviewDialogWidgetState extends State<_ReviewDialogWidget> {
  int _selectedRating = 5;
  late TextEditingController _commentController;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_submitting) return;

    setState(() => _submitting = true);

    final rating = _selectedRating;
    final comment = _commentController.text.trim();

    final ok = await widget.onSubmit(rating, comment);

    if (!mounted) return;

    if (ok) {
      Navigator.of(context).pop(true);
    } else {
      setState(() => _submitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit review. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      scrollable: true,
      title: Text(l10n.rateProviderTitle(widget.providerName)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.selectRatingHelp),
          const SizedBox(height: 12),
          // Star rating row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final starValue = index + 1;
              return IconButton(
                icon: Icon(
                  starValue <= _selectedRating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 36,
                ),
                onPressed: _submitting
                    ? null
                    : () => setState(() => _selectedRating = starValue),
              );
            }),
          ),
          const SizedBox(height: 8),
          Text(
            '$_selectedRating / 5',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _commentController,
            maxLines: 3,
            enabled: !_submitting,
            decoration: InputDecoration(
              labelText: l10n.commentsOptionalLabel,
              hintText: 'Share your experience...',
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _submitting ? null : () => Navigator.of(context).pop(null),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: _submitting ? null : _handleSubmit,
          child: _submitting
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(l10n.submit),
        ),
      ],
    );
  }
}


/// Dialog that shows while waiting for Paystack payment and auto-polls for verification
class _PaymentWaitingDialog extends StatefulWidget {
  final String reference;
  final int bookingId;
  final VoidCallback onPaymentVerified;
  final VoidCallback onCancel;

  const _PaymentWaitingDialog({
    required this.reference,
    required this.bookingId,
    required this.onPaymentVerified,
    required this.onCancel,
  });

  @override
  State<_PaymentWaitingDialog> createState() => _PaymentWaitingDialogState();
}

class _PaymentWaitingDialogState extends State<_PaymentWaitingDialog> {
  bool _polling = true;
  String _statusText = 'Complete your payment in the browser...';
  int _pollCount = 0;
  static const int _maxPolls = 60; // 60 polls × 3 seconds = 3 minutes max

  @override
  void initState() {
    super.initState();
    _startPolling();
  }

  @override
  void dispose() {
    _polling = false;
    super.dispose();
  }

  Future<void> _startPolling() async {
    while (_polling && mounted && _pollCount < _maxPolls) {
      await Future.delayed(const Duration(seconds: 3));
      if (!_polling || !mounted) break;

      _pollCount++;

      // Update status text periodically
      if (mounted) {
        setState(() {
          if (_pollCount < 5) {
            _statusText = 'Complete your payment in the browser...';
          } else if (_pollCount < 15) {
            _statusText = 'Waiting for payment confirmation...';
          } else {
            _statusText = 'Still waiting... Please complete payment.';
          }
        });
      }

      // Check payment status via API
      try {
        // Method 1: Check booking status directly
        final booking = await ApiClient.getServiceRequest(widget.bookingId);
        if (!mounted || !_polling) break;

        if (booking != null) {
          final paymentStatus = (booking['payment_status'] ?? '').toString();
          if (paymentStatus == 'paid') {
            _polling = false;
            widget.onPaymentVerified();
            return;
          }
        }

        // Method 2: Also try verifying with Paystack reference
        final verifyResult = await ApiClient.verifyPaystackPayment(
          reference: widget.reference,
        );
        if (!mounted || !_polling) break;

        if (verifyResult['verified'] == true) {
          _polling = false;
          widget.onPaymentVerified();
          return;
        }
      } catch (e) {
        // Ignore errors during polling, just continue
        debugPrint('Payment polling error: $e');
      }
    }

    // If we've exceeded max polls, show timeout message
    if (mounted && _polling && _pollCount >= _maxPolls) {
      setState(() {
        _statusText = 'Payment verification timed out. Please check your bookings.';
      });
      await Future.delayed(const Duration(seconds: 2));
      if (mounted && _polling) {
        widget.onCancel();
      }
    }
  }

  void _handleManualCheck() async {
    if (!mounted) return;

    setState(() {
      _statusText = 'Checking payment status...';
    });

    try {
      final verifyResult = await ApiClient.verifyPaystackPayment(
        reference: widget.reference,
      );

      if (!mounted) return;

      if (verifyResult['verified'] == true) {
        _polling = false;
        widget.onPaymentVerified();
      } else {
        setState(() {
          _statusText = 'Payment not yet received. Please complete payment.';
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _statusText = 'Could not verify. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
          const SizedBox(height: 20),
          const Text(
            'Processing Payment',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _statusText,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'This will update automatically when payment is complete.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    _polling = false;
                    widget.onCancel();
                  },
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _handleManualCheck,
                  child: const Text('Check Now'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}