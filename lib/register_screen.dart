// lib/register_screen.dart

import 'package:flutter/material.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/countries.dart' as phone_countries;
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';
import 'api_client.dart';
import 'package:url_launcher/url_launcher.dart';
import 'email_verification_screen.dart';
import 'widgets/background_layer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  String _completePhoneNumber = '';

  DateTime? _selectedDate;
  String _selectedRole = 'user';
  bool _acceptedTerms = false;

  bool _loading = false;
  String? _error;
  String? _success;

  String _selectedIso2ForPhone = 'GH';

  // Password visibility toggles
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  // GPS Detection state
  bool _detectingLocation = false;
  String? _detectedCountry;
  String? _detectedCity;
  bool _locationDetectionAttempted = false;
  bool _userChangedCountry = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now().subtract(const Duration(days: 365 * 18));
    _countryController.addListener(_syncPhoneCountryWithSelectedCountry);
    _countryController.addListener(_onCountryChanged);
    // Auto-detect location on startup
    _detectLocationAndAutoFill();
  }

  @override
  void dispose() {
    _countryController.removeListener(_syncPhoneCountryWithSelectedCountry);
    _countryController.removeListener(_onCountryChanged);

    _countryController.dispose();
    _stateController.dispose();
    _cityController.dispose();

    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _syncPhoneCountryWithSelectedCountry() {
    final countryName = _countryController.text.trim();
    if (countryName.isEmpty) return;

    final iso2 = _countryNameToIso2(countryName);
    if (iso2 == null) return;

    if (iso2 != _selectedIso2ForPhone) {
      setState(() {
        _selectedIso2ForPhone = iso2;
        _completePhoneNumber = '';
      });
    }
  }

  void _onCountryChanged() {
    // Check if user manually changed the country after auto-detection
    if (_detectedCountry != null && _locationDetectionAttempted) {
      final currentCountry = _countryController.text.trim().toLowerCase();
      final detected = _detectedCountry!.toLowerCase();
      
      if (currentCountry.isNotEmpty && currentCountry != detected) {
        if (!_userChangedCountry) {
          setState(() {
            _userChangedCountry = true;
          });
        }
      } else if (currentCountry == detected && _userChangedCountry) {
        setState(() {
          _userChangedCountry = false;
        });
      }
    }
  }

  Future<void> _detectLocationAndAutoFill() async {
    setState(() {
      _detectingLocation = true;
    });

    try {
      // Check if location services are enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _detectingLocation = false;
          _locationDetectionAttempted = true;
        });
        return;
      }

      // Check/request permission
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _detectingLocation = false;
            _locationDetectionAttempted = true;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _detectingLocation = false;
          _locationDetectionAttempted = true;
        });
        return;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low, // Low accuracy is faster and sufficient for country
        timeLimit: const Duration(seconds: 15),
      );

      // Reverse geocode to get country
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty && mounted) {
        final placemark = placemarks.first;
        final country = placemark.country;
        final city = placemark.locality ?? placemark.administrativeArea;

        if (country != null && country.isNotEmpty) {
          setState(() {
            _detectedCountry = country;
            _detectedCity = city;  // Keep for reference/logging, but don't auto-fill
            _detectingLocation = false;
            _locationDetectionAttempted = true;
          });

          // Auto-fill the country field
          // Note: CountryStateCityPicker uses specific country names
          // We need to set it programmatically
          _countryController.text = country;
          
          // ✅ ULTRA HACK: Force CountryStateCityPicker to rebuild
          // The widget needs a frame to process the controller change
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                // This empty setState forces the CountryStateCityPicker 
                // to rebuild and recognize the new country value
              });
            }
          });

          // Sync phone country code
          _syncPhoneCountryWithSelectedCountry();
          return;
        }
      }
    } catch (e) {
      debugPrint('Location detection failed: $e');
    }

    if (mounted) {
      setState(() {
        _detectingLocation = false;
        _locationDetectionAttempted = true;
      });
    }
  }

  String? _countryNameToIso2(String countryName) {
    final name = countryName.trim().toLowerCase();
    if (name.isEmpty) return null;

    for (final c in phone_countries.countries) {
      final dynamic d = c;

      String cName = '';
      String cCode = '';

      if (d is Map) {
        cName = (d['name'] ?? '').toString().trim().toLowerCase();
        cCode = (d['code'] ?? '').toString().trim().toUpperCase();
      } else {
        // ignore: avoid_dynamic_calls
        cName = (d.name ?? '').toString().trim().toLowerCase();
        // ignore: avoid_dynamic_calls
        cCode = (d.code ?? '').toString().trim().toUpperCase();
      }

      if (cName == name && cCode.isNotEmpty) return cCode;
    }

    if (name == 'usa' || name == 'united states of america') return 'US';
    if (name == 'uk' || name == 'great britain') return 'GB';

    return null;
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initialDate = _selectedDate ?? now.subtract(const Duration(days: 365 * 18));

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (!mounted) return;
    if (picked != null) setState(() => _selectedDate = picked);
  }

  String? _validatePassword(BuildContext context, String? value) {
    final l10n = AppLocalizations.of(context);
    if (value == null || value.isEmpty) return l10n.passwordIsRequired;
    if (value.length < 10) return l10n.passwordMin10;
    return null;
  }


  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }


  Future<void> _submitRegistration() async {
    final l10n = AppLocalizations.of(context);
    if (!_formKey.currentState!.validate()) return;

    if (_selectedDate == null) {
      setState(() => _error = l10n.pleaseSelectDob);
      return;
    }
    if (_countryController.text.isEmpty) {
      setState(() => _error = l10n.pleaseSelectCountry);
      return;
    }
    if (_cityController.text.isEmpty) {
      setState(() => _error = l10n.pleaseSelectCity);
      return;
    }
    if (_completePhoneNumber.isEmpty) {
      setState(() => _error = l10n.pleaseEnterValidPhone);
      return;
    }
    if (!_acceptedTerms) {
      setState(() => _error = l10n.mustAcceptTerms);
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
      _success = null;
    });

    final dateOfBirth = _selectedDate!;
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }

    if (age < 18) {
      setState(() {
        _loading = false;
        _error = l10n.mustBeAtLeast18;
      });
      return;
    }

    final email = _emailController.text.trim();
    final role = _selectedRole;

    final errorMessage = await ApiClient.registerUser(
      username: _usernameController.text.trim(),
      email: email,
      phoneNumber: _completePhoneNumber,
      role: role,
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      countryName: _countryController.text.trim(),
      cityName: _cityController.text.trim(),
      acceptedTerms: _acceptedTerms,
      password: _passwordController.text,
      passwordConfirm: _passwordConfirmController.text,
      dateOfBirth:
          '${dateOfBirth.year}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}',
      detectedCountry: _detectedCountry,
      countryMismatch: _userChangedCountry,
    );

    if (!mounted) return;

    setState(() => _loading = false);

    if (errorMessage != null) {
      setState(() => _error = errorMessage);
      return;
    }

    final verified = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => EmailVerificationScreen(identifier: email, role: role),
      ),
    );

    if (!mounted) return;

    if (verified == true) {
      setState(() {
        _success = l10n.emailVerifiedSuccessPleaseLogin;
        _error = null;
      });
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _error = l10n.pleaseVerifyEmailToContinue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final horizontalPadding = isSmallScreen ? 12.0 : 16.0;

    final dateText = _selectedDate == null
        ? l10n.selectDateOfBirth
        : '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(title: Text(l10n.createAccountTitle)),
      body: BackgroundLayer(
        imageAsset: 'assets/backgrounds/bg_login_black_marble.jpg',
        overlayColor: const Color(0xFF0B0F14),
        overlayOpacity: 0.68,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 16.0,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isSmallScreen ? double.infinity : 520),
                child: Card(
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            l10n.joinStyloria,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.registerSubtitle,
                            style: TextStyle(color: cs.onSurfaceVariant),
                          ),
                          const SizedBox(height: 20),

                          if (_error != null)
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: cs.errorContainer,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: cs.error),
                              ),
                              child: Text(
                                _error!,
                                style: TextStyle(color: cs.onErrorContainer),
                              ),
                            ),

                          if (_success != null)
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: cs.primary.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: cs.primary),
                              ),
                              child: Text(
                                _success!,
                                style: TextStyle(color: cs.onSurface),
                              ),
                            ),

                          if (_error != null || _success != null) const SizedBox(height: 16),

                          Text(
                            l10n.iWantTo,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          SegmentedButton<String>(
                            segments: [
                              ButtonSegment<String>(
                                value: 'user',
                                label: Text(l10n.bookServices),
                                icon: const Icon(Icons.person),
                              ),
                              ButtonSegment<String>(
                                value: 'provider',
                                label: Text(l10n.provideServices),
                                icon: const Icon(Icons.business),
                              ),
                            ],
                            selected: {_selectedRole},
                            onSelectionChanged: (Set<String> newSelection) {
                              setState(() => _selectedRole = newSelection.first);
                            },
                          ),

                          const SizedBox(height: 20),
                          Text(
                            l10n.personalInformation,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),

                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _firstNameController,
                                  decoration: InputDecoration(
                                    labelText: l10n.firstName,
                                    border: const OutlineInputBorder(),
                                  ),
                                  validator: (value) =>
                                      value == null || value.isEmpty ? l10n.required : null,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextFormField(
                                  controller: _lastNameController,
                                  decoration: InputDecoration(
                                    labelText: l10n.lastName,
                                    border: const OutlineInputBorder(),
                                  ),
                                  validator: (value) =>
                                      value == null || value.isEmpty ? l10n.required : null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Date of Birth Label
                          Text(
                            l10n.dateOfBirth,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),

                          OutlinedButton(
                            onPressed: _pickDate,
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.cake_outlined, size: 20, color: cs.onSurfaceVariant),
                                    const SizedBox(width: 8),
                                    Text(
                                      dateText,
                                      style: TextStyle(
                                        color: _selectedDate == null ? cs.onSurfaceVariant : cs.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(Icons.calendar_today, size: 20, color: cs.primary),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Location Detection Status
                          if (_detectingLocation)
                            Container(
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: cs.primaryContainer,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      l10n.detectingYourLocation,
                                      style: TextStyle(color: cs.onPrimaryContainer),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // Location Detected Success Message
                          if (_detectedCountry != null && !_userChangedCountry && !_detectingLocation)
                            Container(
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.green.shade200),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on, color: Colors.green.shade700, size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      l10n.locationDetectedAs(_detectedCountry!),
                                      style: TextStyle(color: Colors.green.shade700, fontSize: 13),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.refresh, color: Colors.green.shade700, size: 20),
                                    onPressed: _detectLocationAndAutoFill,
                                    tooltip: l10n.refresh,
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                ],
                              ),
                            ),

                          // Country Mismatch Warning
                          if (_userChangedCountry && _detectedCountry != null)
                            Container(
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.orange.shade200),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.info_outline, color: Colors.orange.shade700, size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          l10n.countryMismatchWarningTitle,
                                          style: TextStyle(
                                            color: Colors.orange.shade800,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          l10n.countryMismatchWarningBody(_detectedCountry!),
                                          style: TextStyle(
                                            color: Colors.orange.shade700,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // ✅ COUNTRY PICKER with "Other" support
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CountryStateCityPicker(
                                country: _countryController,
                                state: _stateController,
                                city: _cityController,
                                dialogColor: cs.surface,
                                textFieldDecoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                ),
                              ),
                              
                              // ✅ ULTRA HACK: "Other" helper buttons
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  // State "Other" button
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: _countryController.text.isEmpty
                                          ? null
                                          : () {
                                              setState(() {
                                                _stateController.text = 'Other';
                                              });
                                            },
                                      icon: const Icon(Icons.location_city, size: 16),
                                      label: Text(
                                        _stateController.text == 'Other'
                                            ? '✓ State: Other'
                                            : 'State not listed?',
                                        style: TextStyle(fontSize: 11),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 8,
                                        ),
                                        side: BorderSide(
                                          color: _stateController.text == 'Other'
                                              ? Colors.green
                                              : cs.outline,
                                        ),
                                        foregroundColor: _stateController.text == 'Other'
                                            ? Colors.green
                                            : cs.onSurface,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // City "Other" button
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: _countryController.text.isEmpty
                                          ? null
                                          : () {
                                              setState(() {
                                                _cityController.text = 'Other';
                                              });
                                            },
                                      icon: const Icon(Icons.more_horiz, size: 16),
                                      label: Text(
                                        _cityController.text == 'Other'
                                            ? '✓ City: Other'
                                            : 'City not listed?',
                                        style: TextStyle(fontSize: 11),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 8,
                                        ),
                                        side: BorderSide(
                                          color: _cityController.text == 'Other'
                                              ? Colors.green
                                              : cs.outline,
                                        ),
                                        foregroundColor: _cityController.text == 'Other'
                                            ? Colors.green
                                            : cs.onSurface,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              // Helper text
                              if (_stateController.text == 'Other' || _cityController.text == 'Other')
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.green.shade200),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.check_circle, 
                                          color: Colors.green.shade700, 
                                          size: 16,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            'Location marked as "Other" - you can proceed with registration',
                                            style: TextStyle(
                                              color: Colors.green.shade700,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          Text(
                            l10n.phoneNumber,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),

                          IntlPhoneField(
                            key: ValueKey(_selectedIso2ForPhone),
                            decoration: InputDecoration(
                              labelText: l10n.phoneNumber,
                              border: const OutlineInputBorder(),
                            ),
                            initialCountryCode: _selectedIso2ForPhone,
                            onChanged: (phone) {
                              setState(() => _completePhoneNumber = phone.completeNumber);
                            },
                            validator: (value) {
                              if (value == null || value.number.isEmpty) {
                                return l10n.pleaseEnterPhoneNumber;
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 12),
                          Text(
                            l10n.accountInformation,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),

                          TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelText: l10n.username,
                              border: const OutlineInputBorder(),
                              hintText: l10n.chooseUniqueUsernameHint,
                            ),
                            validator: (value) =>
                                value == null || value.isEmpty ? l10n.required : null,
                          ),
                          const SizedBox(height: 12),

                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: l10n.email,
                              border: const OutlineInputBorder(),
                              hintText: l10n.emailHint,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) return l10n.required;
                              if (!value.contains('@')) return l10n.enterValidEmail;
                              return null;
                            },
                          ),

                          const SizedBox(height: 12),
                          Text(
                            l10n.security,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),

                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: l10n.password,
                              border: const OutlineInputBorder(),
                              hintText: l10n.passwordHintAtLeast10,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showPassword ? Icons.visibility_off : Icons.visibility,
                                ),
                                onPressed: () => setState(() => _showPassword = !_showPassword),
                                tooltip: _showPassword ? l10n.hidePassword : l10n.showPassword,
                              ),
                            ),
                            obscureText: !_showPassword,
                            validator: (value) => _validatePassword(context, value),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4, left: 4),
                            child: Text(
                              l10n.tapEyeToShowPassword,
                              style: TextStyle(fontSize: 11, color: cs.onSurfaceVariant),
                            ),
                          ),
                          const SizedBox(height: 12),

                          TextFormField(
                            controller: _passwordConfirmController,
                            decoration: InputDecoration(
                              labelText: l10n.confirmPassword,
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showConfirmPassword ? Icons.visibility_off : Icons.visibility,
                                ),
                                onPressed: () => setState(() => _showConfirmPassword = !_showConfirmPassword),
                                tooltip: _showConfirmPassword ? l10n.hidePassword : l10n.showPassword,
                              ),
                            ),
                            obscureText: !_showConfirmPassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) return l10n.required;
                              if (value != _passwordController.text) return l10n.passwordsDoNotMatch;
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: _acceptedTerms,
                                onChanged: (bool? value) =>
                                    setState(() => _acceptedTerms = value ?? false),
                              ),
                              Expanded(
                                child: Wrap(
                                  children: [
                                    Text(l10n.iAgreeTo),
                                    GestureDetector(
                                      onTap: () => _openUrl('https://lilmax303.github.io/styloria-website/terms.html'),
                                      child: Text(
                                        l10n.termsOfService,
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                    Text(' ${l10n.and} '),
                                    GestureDetector(
                                      onTap: () => _openUrl('https://lilmax303.github.io/styloria-website/privacy.html'),
                                      child: Text(
                                        l10n.privacyPolicy,
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          ElevatedButton(
                            onPressed: _loading ? null : _submitRegistration,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: _loading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : Text(
                                    l10n.createAccountButton,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                          ),

                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(l10n.alreadyHaveAccount),
                              TextButton(
                                onPressed: _loading ? null : () => Navigator.pop(context),
                                child: Text(l10n.login),
                              ),
                            ],
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
      ),
    );
  }
}