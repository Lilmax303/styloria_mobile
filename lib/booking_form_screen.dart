// lib/booking_form_screen.dart

import 'dart:io' show Platform;
import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:flutterwave_standard/flutterwave.dart';
import 'paystack_payment_screen.dart';
import 'package:app_links/app_links.dart';
import 'africa_countries.dart';
import 'app_tab_state.dart';
import 'package:geocoding/geocoding.dart';

import 'api_client.dart';
import 'currency_helper.dart';


bool get _stripeSupported {
  if (kIsWeb) return true;
  return Platform.isAndroid || Platform.isIOS || Platform.isMacOS;
}

class BookingFormScreen extends StatefulWidget {
  const BookingFormScreen({super.key});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();

   // Deep link handling
   late AppLinks _appLinks;
   StreamSubscription? _linkSubscription;
   String? _pendingTxRef;
   String? _pendingPaystackRef;
   bool _waitingForPaymentReturn = false;
   String? _pendingGateway; // 'flutterwave' or 'paystack'

  int? _toInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString());
  }

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final _latController = TextEditingController(text: '5.6037');
  final _lngController = TextEditingController(text: '-0.1870');
  String? _locationAddress;

  String _serviceType = 'haircut';
  final _notesController = TextEditingController();

  bool _submitting = false;
  bool _paying = false;
  String? _resultMessage;
  bool _resultIsSuccess = false;

  int? _createdRequestId;

  // Breakdown variables
  Map<String, dynamic>? _budgetBreakdown;
  Map<String, dynamic>? _standardBreakdown;
  Map<String, dynamic>? _priorityBreakdown;

  String _selectedPriceTier = 'standard'; // 'budget', 'standard', 'priority'
  double? _transportationCost;
  double? _budgetPrice;
  double? _standardPrice;
  double? _priorityPrice;
  double? _selectedOffer;

  // Currency and user info
  String? _userCountry;
  String? _userCurrencySymbol;
  String? _userCurrency;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
    _loadUserInfo();
    _initDeepLinks();
  }

  @override
  void dispose() {
    _latController.dispose();
    _lngController.dispose();
    _notesController.dispose();
    _linkSubscription?.cancel();
    super.dispose();
  }

  void _initDeepLinks() {
    _appLinks = AppLinks();

    // Handle deep link when app is already running
    _linkSubscription = _appLinks.uriLinkStream.listen((Uri uri) {
      _handleDeepLink(uri);
    });

    // Handle deep link that opened the app (cold start)
    _appLinks.getInitialLink().then((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri);
      }
    });
  }

  Future<void> _handleDeepLink(Uri uri) async {
    print('=== DEEP LINK RECEIVED ===');
    print('URI: $uri');
    print('Scheme: ${uri.scheme}');
    print('Host: ${uri.host}');
    print('Query params: ${uri.queryParameters}');
    print('==========================');

    // Check if this is a payment return
    if (uri.scheme == 'styloria' && uri.host == 'payment-return') {
      final status = uri.queryParameters['status'] ?? '';
      final txRef = uri.queryParameters['tx_ref'] ?? '';
      final transactionId = uri.queryParameters['transaction_id'] ?? '';
      final gateway = uri.queryParameters['gateway'] ?? '';
      final reference = uri.queryParameters['reference'] ?? '';

      print('Payment return - gateway: $gateway, status: $status, tx_ref: $txRef, reference: $reference');

      // Only process if we're waiting for a payment return
      if (!_waitingForPaymentReturn) {
        print('Not waiting for payment return, ignoring');
        return;
      }

      // Handle Paystack callback
      if (gateway == 'paystack' || reference.startsWith('styloria_')) {
        if (_pendingPaystackRef != null && reference != _pendingPaystackRef) {
          print('Paystack reference mismatch: expected $_pendingPaystackRef, got $reference');
          return;
        }
        _waitingForPaymentReturn = false;
        await _verifyPaystackPaymentFromDeepLink(reference: reference);
        return;
      }

      // Handle Flutterwave callback
      if (_pendingTxRef != null && txRef != _pendingTxRef) {
        print('tx_ref mismatch: expected $_pendingTxRef, got $txRef');
        return;
      }

      _waitingForPaymentReturn = false;

      // Automatically verify the payment
      await _verifyPaymentFromDeepLink(
        txRef: txRef,
        transactionId: transactionId,
        status: status,
      );
    }
  }

  Future<void> _verifyPaymentFromDeepLink({
    required String txRef,
    required String transactionId,
    required String status,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final navigator = Navigator.of(context);

    if (!mounted) return;

    // Show loading
    setState(() {
      _paying = true;
      _resultMessage = null;
    });

    // Check if status indicates failure
    final statusLower = status.toLowerCase();
    if (statusLower == 'cancelled' || statusLower == 'failed') {
      // Even if status says cancelled, still try to verify - user might have actually paid
      print('Status is $status, but will still attempt verification');
    }

    // Try to verify with transaction_id first
    int? txnId = _toInt(transactionId);

    Map<String, dynamic> verifyResult;

    if (txnId != null && txnId > 0) {
      // Verify with transaction_id
      verifyResult = await ApiClient.verifyFlutterwavePaymentDetailed(
        txRef: txRef,
        transactionId: txnId,
      );
    } else {
      // Fallback: verify by tx_ref only
      verifyResult = await ApiClient.verifyFlutterwaveByTxRef(txRef: txRef);
    }

    if (!mounted) return;

    print('Verification result: $verifyResult');

    if (verifyResult["verified"] == true) {
      setState(() => _paying = false);

      await showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Payment Successful'),
          content: Text(l10n.paymentSuccessfulShort),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );

      mainTabIndex.value = 1;
      if (mounted) navigator.pop();
    } else {
      // Payment verification failed
      final detail = verifyResult["detail"]?.toString() ?? 'Payment could not be verified';

      setState(() {
        _paying = false;
        _resultIsSuccess = false;
        _resultMessage = detail;
      });

      // Reset the booking payment status so user can try again
      if (_createdRequestId != null) {
        await ApiClient.resetFlutterwavePayment(_createdRequestId!);
      }
    }
  }

  Future<void> _verifyPaystackPaymentFromDeepLink({
    required String reference,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final navigator = Navigator.of(context);

    if (!mounted) return;

    setState(() {
      _paying = true;
      _resultMessage = null;
    });

    final verifyResult = await ApiClient.verifyPaystackPayment(reference: reference);

    if (!mounted) return;

    print('Paystack verification result: $verifyResult');

    if (verifyResult["verified"] == true) {
      setState(() => _paying = false);

      await showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Payment Successful'),
          content: Text(l10n.paymentSuccessfulShort),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );

      mainTabIndex.value = 1;
      if (mounted) navigator.pop();
    } else {
      final detail = verifyResult["detail"]?.toString() ?? 'Payment could not be verified';

      setState(() {
        _paying = false;
        _resultIsSuccess = false;
        _resultMessage = detail;
      });

      // Reset the booking payment status so user can try again
      if (_createdRequestId != null) {
        await ApiClient.resetPaystackPayment(_createdRequestId!);
      }
    }
  }

  Future<void> _loadUserInfo() async {
    final userData = await ApiClient.getCurrentUser();
    if (!mounted) return;
    if (userData != null && userData['country_name'] != null) {
      setState(() {
        _userCountry = userData['country_name'] as String;
        _userCurrencySymbol = CurrencyHelper.getCurrencySymbol(_userCountry!);
      });
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today,
      lastDate: today, // keeping your current behavior
    );

    if (!mounted) return;

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
    );

    if (!mounted) return;

    if (picked != null) {
      final now = DateTime.now();
      final baseDate = _selectedDate ?? DateTime(now.year, now.month, now.day);

      final chosen = DateTime(
        baseDate.year,
        baseDate.month,
        baseDate.day,
        picked.hour,
        picked.minute,
      );

      if (chosen.isBefore(now)) {
        setState(() {
          _resultIsSuccess = false;
          _resultMessage =
              AppLocalizations.of(context)!.chooseTimeLaterThanCurrent;
        });
        return;
      }

      setState(() {
        _selectedTime = picked;
        _resultMessage = null;
      });
    }
  }

  Future<void> _useCurrentLocation() async {
    setState(() {
      _resultMessage = null;
    });

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!mounted) return;

    if (!serviceEnabled) {
      setState(() {
        _resultIsSuccess = false;
        _resultMessage = AppLocalizations.of(context)!.locationServicesDisabled;
      });
      return;
    }

    var permission = await Geolocator.checkPermission();
    if (!mounted) return;

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (!mounted) return;

      if (permission == LocationPermission.denied) {
        setState(() {
          _resultIsSuccess = false;
          _resultMessage =
              AppLocalizations.of(context)!.locationPermissionDenied;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _resultIsSuccess = false;
        _resultMessage =
            AppLocalizations.of(context)!.locationPermissionPermanentlyDenied;
      });
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (!mounted) return;

      // Reverse geocode to get address
      String? address;
      try {
        final placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (placemarks.isNotEmpty) {
          final p = placemarks.first;
          final parts = <String>[
            if (p.street != null && p.street!.isNotEmpty) p.street!,
            if (p.subLocality != null && p.subLocality!.isNotEmpty) p.subLocality!,
            if (p.locality != null && p.locality!.isNotEmpty) p.locality!,
            if (p.administrativeArea != null && p.administrativeArea!.isNotEmpty) p.administrativeArea!,
            if (p.country != null && p.country!.isNotEmpty) p.country!,
          ];
          address = parts.join(', ');
        }
      } catch (_) {
        // Geocoding failed, continue without address
      }
 

      setState(() {
        _latController.text = position.latitude.toStringAsFixed(6);
        _lngController.text = position.longitude.toStringAsFixed(6);
        _locationAddress = address;
        _resultIsSuccess = true;
        _resultMessage = address != null
            ? '${AppLocalizations.of(context)!.locationUpdatedFromGps}\n$address'
            : AppLocalizations.of(context)!.locationUpdatedFromGps;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _resultIsSuccess = false;
        _resultMessage =
            AppLocalizations.of(context)!.failedToGetLocation(e.toString());
      });
    }
  }

  double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  String _money(dynamic value) {
    final d = _parseDouble(value);
    final sym = _userCurrencySymbol ?? '\$';
    if (d == null) return '${sym}0.00';
    return '$sym${d.toStringAsFixed(2)}';
  }

  Future<void> _createBooking() async {
    if (_selectedDate == null || _selectedTime == null) {
      setState(() {
        _resultIsSuccess = false;
        _resultMessage = AppLocalizations.of(context)!.pleasePickDateAndTime;
      });
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _submitting = true;
      _resultMessage = null;
      _createdRequestId = null;

      _budgetPrice = null;
      _standardPrice = null;
      _priorityPrice = null;
      _selectedOffer = null;

      _budgetBreakdown = null;
      _standardBreakdown = null;
      _priorityBreakdown = null;
      _transportationCost = null;
    });

    final localDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    final now = DateTime.now();
    if (localDateTime.isBefore(now)) {
      setState(() {
        _resultIsSuccess = false;
        _resultMessage =
            AppLocalizations.of(context)!.chooseTimeLaterThanCurrent;
        _submitting = false;
      });
      return;
    }

    final utcString = localDateTime.toUtc().toIso8601String();

    final lat = double.parse(_latController.text.trim());
    final lng = double.parse(_lngController.text.trim());

    final response = await ApiClient.createServiceRequest(
      appointmentTime: utcString,
      latitude: lat,
      longitude: lng,
      serviceType: _serviceType,
      notes: _notesController.text,
      locationAddress: _locationAddress,
    );

    if (!mounted) return;

    setState(() {
      _submitting = false;

      if (response != null) {
        final id = response['id'] as int?;
        _createdRequestId = id;

        if (id != null) {
          _loadPriceOptions(id, lat, lng);
        }

        _resultIsSuccess = true;
        _resultMessage = (id != null)
            ? AppLocalizations.of(context)!.bookingCreatedChoosePrice(id)
            : AppLocalizations.of(context)!.failedToCreateBooking;
      } else {
        _resultIsSuccess = false;
        _resultMessage = AppLocalizations.of(context)!.failedToCreateBooking;
      }
    });
  }

  Future<void> _loadPriceOptions(int? bookingId, double lat, double lng) async {
    if (bookingId == null) return;

    final priceData = await ApiClient.getPriceOptions(bookingId);

    if (priceData != null && mounted) {
      setState(() {

        // If backend says no providers are available, show the message to the requester.
        final detail = priceData['detail']?.toString();
        final hasNoProvidersMessage = detail != null && detail.isNotEmpty;

        final budget = _parseDouble(priceData['budget_price']);
        final standard = _parseDouble(priceData['standard_price']);
        final priority = _parseDouble(priceData['priority_price']);

        if (hasNoProvidersMessage && budget == null && standard == null && priority == null) {
          _resultIsSuccess = false;
          _resultMessage = detail; // shows: “We’re sorry—there are currently no available providers...”

          // Clear price UI state
          _budgetPrice = null;
          _standardPrice = null;
          _priorityPrice = null;
          _selectedOffer = null;
          _transportationCost = null;
          _budgetBreakdown = null;
          _standardBreakdown = null;
          _priorityBreakdown = null;
          return;
        }

        _budgetPrice = budget;
        _standardPrice = standard;
        _priorityPrice = priority;
        _transportationCost = _parseDouble(priceData['transportation_cost']);

        _userCurrency = priceData['user_currency'] as String? ?? _userCurrency;
        _userCurrencySymbol =
            priceData['currency_symbol'] as String? ?? _userCurrencySymbol;
        _userCountry = priceData['user_country'] as String? ?? _userCountry;

        final breakdown = priceData['breakdown'] as Map<String, dynamic>?;

        if (breakdown != null) {
          _budgetBreakdown = breakdown['budget'] as Map<String, dynamic>?;
          _standardBreakdown = breakdown['standard'] as Map<String, dynamic>?;
          _priorityBreakdown = breakdown['priority'] as Map<String, dynamic>?;
        }

        _selectedPriceTier = 'standard';
        _selectedOffer = _standardPrice;
      });
    } else {
      // fallback
      const estimatedPrice = 50.0;
      if (!mounted) return;
      setState(() {
        _budgetPrice = estimatedPrice * 0.9;
        _standardPrice = estimatedPrice;
        _priorityPrice = estimatedPrice * 1.1;
        _transportationCost = 8.0;
        _selectedPriceTier = 'standard';
        _selectedOffer = _standardPrice;
      });
    }
  }

  Future<void> _confirmOffer() async {
    final l10n = AppLocalizations.of(context)!;
    final navigator = Navigator.of(context);

    // Determine payment gateway
    final gateway = ApiClient.getPaymentGateway(_userCountry);
    final isPaystack = gateway == 'paystack';
    final isFlutterwave = gateway == 'flutterwave';
    final isAfrica = isPaystack || isFlutterwave;

    if (!isAfrica && !_stripeSupported) {
      setState(() {
        _resultIsSuccess = false;
        _resultMessage = l10n.paymentsNotSupportedLong;
      });
      return;
    }

    if (_createdRequestId == null) {
      setState(() {
        _resultIsSuccess = false;
        _resultMessage = l10n.noBookingToConfirm;
      });
      return;
    }

    if (_selectedOffer == null) {
      setState(() {
        _resultIsSuccess = false;
        _resultMessage = l10n.pleaseChoosePriceOption;
      });
      return;
    }

    setState(() {
      _paying = true;
      _resultMessage = null;
    });

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

      // PAYSTACK COUNTRIES -> Paystack (Ghana, Nigeria, South Africa, Kenya, Côte d'Ivoire)
      if (isPaystack) {
        final amount = _selectedOffer!;
        final checkout = await ApiClient.createPaystackCheckout(
          serviceRequestId: _createdRequestId!,
          amount: amount,
        );
        
        if (!mounted) return;

        if (checkout == null) {
          setState(() {
            _paying = false;
            _resultIsSuccess = false;
            _resultMessage = l10n.failedCreatePaymentTryAgain;
          });
          return;
        }

        final authorizationUrl = (checkout['authorization_url'] ?? '').toString();
        final reference = (checkout['reference'] ?? '').toString();
        final currency = (checkout['currency'] ?? (_userCurrency ?? 'GHS')).toString();

        if (authorizationUrl.isEmpty) {
          setState(() {
            _paying = false;
            _resultIsSuccess = false;
            _resultMessage = checkout['detail']?.toString() ?? l10n.failedCreatePaymentTryAgain;
          });
          return;
        }

        // Store reference for deep link verification
        _pendingPaystackRef = reference;
        _pendingGateway = 'paystack';
        _waitingForPaymentReturn = true;

        // Navigate to Paystack WebView screen
        final result = await navigator.push<Map<String, dynamic>>(
          MaterialPageRoute(
            builder: (_) => PaystackPaymentScreen(
              bookingId: _createdRequestId!,
              amount: amount,
              currency: currency,
            ),
          ),
        );

        _waitingForPaymentReturn = false;

        if (!mounted) return;

        if (result != null && result['success'] == true) {
          setState(() => _paying = false);
          await showDialog(
            context: context,
            builder: (dialogContext) => AlertDialog(
              title: const Text('Payment Successful'),
              content: Text(l10n.paymentSuccessfulShort),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          mainTabIndex.value = 1;
          if (mounted) navigator.pop();
          return;
        } else if (result != null && result['cancelled'] == true) {
          setState(() {
            _paying = false;
            _resultIsSuccess = false;
            _resultMessage = l10n.paymentCancelledOrFailed('cancelled');
          });
          // Reset payment so user can try again
          await ApiClient.resetPaystackPayment(_createdRequestId!);
          return;
        } else {
          setState(() {
            _paying = false;
            _resultIsSuccess = false;
            _resultMessage = l10n.paymentCancelledOrFailed('');
          });
          return;
        }
      }

      // OTHER AFRICA -> Flutterwave
      if (isFlutterwave) {
        final amount = _selectedOffer!;
        final checkout = await ApiClient.createFlutterwaveCheckout(
          serviceRequestId: _createdRequestId!,
          amount: amount,
        );
        if (!mounted) return;

        if (checkout == null) {
          setState(() {
            _paying = false;
            _resultIsSuccess = false;
            _resultMessage = l10n.failedCreatePaymentTryAgain;
          });
          return;
        }

        final publicKey = (checkout['public_key'] ?? '').toString();
        final txRef = (checkout['tx_ref'] ?? '').toString();
        final currency = (checkout['currency'] ?? (_userCurrency ?? 'USD')).toString();
        final customerEmail = (checkout['customer_email'] ?? '').toString();
        final customerPhone = (checkout['customer_phone'] ?? '').toString();
        final customerName = (checkout['customer_name'] ?? '').toString();
        final redirectUrl = (checkout['redirect_url'] ?? '').toString();

        // Store tx_ref for deep link verification
        _pendingTxRef = txRef;
        _pendingGateway = 'flutterwave';
        _waitingForPaymentReturn = true;

        final amountStr = amount.toStringAsFixed(2);

        final flutterwave = Flutterwave(
          publicKey: publicKey,
          currency: currency,
          txRef: txRef,
          amount: amountStr,
          customer: Customer(
            name: customerName.isNotEmpty ? customerName : 'Customer',
            phoneNumber: customerPhone.isNotEmpty ? customerPhone : '0000000000',
            email: customerEmail.isNotEmpty ? customerEmail : 'no-reply@styloria.com',
          ),
          paymentOptions: "card,banktransfer,ussd,mobilemoney",
          customization: Customization(
            title: "Styloria Booking",
            description: "Pay for your service booking",
            logo: "https://styloria.com/logo.png",
          ),
          isTestMode: (checkout['is_test_mode'] == true),
          redirectUrl: redirectUrl,
        );

        // Launch Flutterwave - don't await the result
        // The deep link handler will take over when user returns
        final resp = await flutterwave.charge(context);
        if (!mounted) return;

        print('=== FLUTTERWAVE SDK RESPONSE ===');
        print('Status: "${resp.status}"');
        print('Transaction ID: "${resp.transactionId}"');
        print('================================');

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
          setState(() => _paying = false);
          await showDialog(
            context: context,
            builder: (dialogContext) => AlertDialog(
              title: const Text('Payment successful'),
              content: Text(l10n.paymentSuccessfulShort),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          mainTabIndex.value = 1;
          if (mounted) navigator.pop();
          return;
        }

        // Verification failed here, but deep link might handle it
        // Reset paying state and let user see the bookings
        setState(() {
          _paying = false;
          _resultIsSuccess = false;
          _resultMessage = l10n.paymentCancelledOrFailed(resp.status ?? '');
        });
        return;
      }

      // NON-AFRICA -> Stripe (existing flow)

      final pi = await ApiClient.createPaymentIntentDetailed(
        _createdRequestId!,
        offeredPrice: _selectedOffer,
      );

      if (!mounted) return;

      if (pi["ok"] != true || (pi["client_secret"] ?? '').toString().isEmpty) {
        setState(() {
          _paying = false;
          _resultIsSuccess = false;
         _resultMessage = l10n.failedCreatePaymentTryAgain;
        });
        return;
      }
      final clientSecret = pi["client_secret"].toString();
      final piId = (pi["payment_intent_id"] ?? "").toString();

      await stripe.Stripe.instance.initPaymentSheet(
        paymentSheetParameters: stripe.SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Styloria',
          style: ThemeMode.system,
        ),
      );

      await stripe.Stripe.instance.presentPaymentSheet();

      await ApiClient.confirmStripePayment(
        serviceRequestId: _createdRequestId!,
        paymentIntentId: piId.isNotEmpty ? piId : null,
      );
      final paidBooking = await _waitForPaid(_createdRequestId!);

      if (!mounted) return;

      if (paidBooking == null) {
        setState(() {
          _paying = false;
          _resultIsSuccess = false;
          _resultMessage = l10n.paymentSucceededButFailedUpdate;
        });
        return;
      }

      setState(() {
        _paying = false;

        // We rely on Stripe webhook, but proceed even if it’s delayed.
        final paid = _parseDouble(paidBooking?['offered_price']) ?? _selectedOffer!;
        _resultIsSuccess = true;
        final paidText = '${_userCurrencySymbol ?? '\$'}${paid.toStringAsFixed(2)}';
        _resultMessage = l10n.paymentSuccessfulMessage(
          _createdRequestId!,
          paidText,
        );
      });

      if (!mounted) return;
      {
        await showDialog(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('Payment successful'),
            content: Text(l10n.paymentSuccessfulShort),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        // Go to Bookings tab
        mainTabIndex.value = 1;
        if (mounted) navigator.pop();
      }
    } on stripe.StripeException catch (e) {
      if (!mounted) return;
      setState(() {
        _paying = false;
        _resultIsSuccess = false;
        _resultMessage = l10n.paymentCancelledOrFailed(
          e.error.localizedMessage ?? '',
        );
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _paying = false;
        _resultIsSuccess = false;
        _resultMessage = l10n.unexpectedPaymentError(e.toString());
      });
    }
  }

  Widget _buildBreakdownRow(String label, String value,
      {bool isTotal = false}) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              color: isTotal ? cs.primary : cs.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
              color: isTotal ? cs.primary : cs.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceOptionCard({
    required String title,
    required String tier,
    required double? price,
    required String description,
    required bool isSelected,
    required Color accentColor,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    Map<String, dynamic>? breakdown;
    if (tier == 'budget') {
      breakdown = _budgetBreakdown;
    } else if (tier == 'standard') {
      breakdown = _standardBreakdown;
    } else if (tier == 'priority') {
      breakdown = _priorityBreakdown;
    }

    final borderColor = isSelected ? accentColor : cs.outline;
    final bgColor = isSelected ? cs.primary.withOpacity(0.08) : null;

    return Card(
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: borderColor,
          width: isSelected ? 1.6 : 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedPriceTier = tier;
            _selectedOffer = price;
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: tier,
                    groupValue: _selectedPriceTier,
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _selectedPriceTier = value;
                        _selectedOffer = price;
                      });
                    },
                    activeColor: accentColor,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                            color: accentColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: cs.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    price != null ? _money(price) : l10n.naShort,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ],
              ),
              if (isSelected && breakdown != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: cs.outline),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.priceBreakdownTitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: cs.onSurface,
                            ),
                      ),
                      const SizedBox(height: 8),
                      _buildBreakdownRow(
                        l10n.servicePriceLabel,
                        _money(breakdown['service_price']),
                      ),
                      _buildBreakdownRow(
                        l10n.transportationLabel,
                        _money(breakdown['transportation_cost']),
                      ),
                      _buildBreakdownRow(
                        l10n.serviceFeeLabel(
                            (breakdown['service_fee_percent'] ?? '0')
                                .toString()),
                        _money(breakdown['service_fee_amount']),
                      ),
                      const Divider(height: 16),
                      _buildBreakdownRow(
                        l10n.totalLabel,
                        _money(breakdown['total_price']),
                        isTotal: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.allPricesIn(
                    _userCurrency ?? 'USD',
                    _userCountry ?? l10n.userCountryPlaceholder,
                  ),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 11,
                        color: cs.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    // Luxury tier colors
    final Color budgetColor = cs.onSurfaceVariant; // neutral graphite-ish
    final Color standardColor = cs.primary; // gold from AppTheme
    const Color priorityColor = Color(0xFFB76E79); // rose-gold

    final dateText = _selectedDate == null
        ? l10n.pickDate
        : _selectedDate!.toLocal().toString().split(' ').first;

    final timeText =
        _selectedTime == null ? l10n.pickTime : _selectedTime!.format(context);

    final showPrices = _budgetPrice != null &&
        _standardPrice != null &&
        _priorityPrice != null;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.newBookingTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: 450,
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    l10n.appointmentDetailsTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _pickDate,
                          child: Text(dateText),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _pickTime,
                          child: Text(timeText),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.serviceTypeTitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 8),
                  DropdownMenu<String>(
                    initialSelection: _serviceType,
                    label: Text(l10n.serviceDropdownLabel),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                          value: 'haircut', label: l10n.serviceHaircutLabel),
                      DropdownMenuEntry(
                          value: 'braids', label: l10n.serviceBraidsLabel),
                      DropdownMenuEntry(
                          value: 'shave', label: l10n.serviceShaveLabel),
                      DropdownMenuEntry(
                          value: 'color', label: l10n.serviceHairColoringLabel),
                      DropdownMenuEntry(
                          value: 'manicure', label: l10n.serviceManicureLabel),
                      DropdownMenuEntry(
                          value: 'pedicure', label: l10n.servicePedicureLabel),
                      DropdownMenuEntry(
                          value: 'nails', label: l10n.serviceNailArtLabel),
                      DropdownMenuEntry(
                          value: 'makeup', label: l10n.serviceMakeupLabel),
                      DropdownMenuEntry(
                          value: 'facial', label: l10n.serviceFacialLabel),
                      DropdownMenuEntry(
                          value: 'waxing', label: l10n.serviceWaxingLabel),
                      DropdownMenuEntry(
                          value: 'massage', label: l10n.serviceMassageLabel),
                      DropdownMenuEntry(
                          value: 'tattoo', label: l10n.serviceTattooLabel),
                      DropdownMenuEntry(
                          value: 'styling',
                          label: l10n.serviceHairStylingLabel),
                      DropdownMenuEntry(
                          value: 'treatment',
                          label: l10n.serviceHairTreatmentLabel),
                      DropdownMenuEntry(
                          value: 'extensions',
                          label: l10n.serviceHairExtensionsLabel),
                      DropdownMenuEntry(
                          value: 'other',
                          label: l10n.serviceOtherServicesLabel),
                    ],
                    onSelected: (value) {
                      if (value == null) return;
                      setState(() => _serviceType = value);
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _notesController,
                    decoration: InputDecoration(
                      labelText: l10n.notesForProviderOptionalLabel,
                      border: const OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.locationTitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _latController,
                          decoration: InputDecoration(
                            labelText: l10n.latitudeLabel,
                            border: const OutlineInputBorder(),
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          validator: (value) => (value == null || value.isEmpty)
                              ? l10n.requiredField
                              : null,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: _lngController,
                          decoration: InputDecoration(
                            labelText: l10n.longitudeLabel,
                            border: const OutlineInputBorder(),
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          validator: (value) => (value == null || value.isEmpty)
                              ? l10n.requiredField
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: _useCurrentLocation,
                      icon: const Icon(Icons.my_location),
                      label: Text(l10n.useMyCurrentLocation),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_userCountry != null && _userCurrencySymbol != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: cs.outline),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.currency_exchange,
                              size: 16, color: cs.primary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              l10n.pricesShownIn(
                                  _userCurrencySymbol!, _userCountry!),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 12),
                  if (_resultMessage != null)
                    Text(
                      _resultMessage!,
                      style: TextStyle(
                        color: _resultIsSuccess ? cs.primary : cs.error,
                      ),
                    ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _submitting ? null : _createBooking,
                    child: _submitting
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.createBookingButton),
                  ),
                  const SizedBox(height: 24),
                  if (showPrices) ...[
                    const Divider(),
                    Text(
                      l10n.chooseYourPriceOptionTitle,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 8),
                    if (_transportationCost != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: cs.outline),
                        ),
                        child: Text(
                          l10n.transportationCostLabel(
                              _money(_transportationCost)),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    const SizedBox(height: 14),
                    _buildPriceOptionCard(
                      title: l10n.budgetTierTitle,
                      tier: 'budget',
                      price: _budgetPrice,
                      description: l10n.budgetTierDescription,
                      isSelected: _selectedPriceTier == 'budget',
                      accentColor: budgetColor,
                    ),
                    const SizedBox(height: 12),
                    _buildPriceOptionCard(
                      title: l10n.standardTierTitle,
                      tier: 'standard',
                      price: _standardPrice,
                      description: l10n.standardTierDescription,
                      isSelected: _selectedPriceTier == 'standard',
                      accentColor: standardColor,
                    ),
                    const SizedBox(height: 12),
                    _buildPriceOptionCard(
                      title: l10n.priorityTierTitle,
                      tier: 'priority',
                      price: _priorityPrice,
                      description: l10n.priorityTierDescription,
                      isSelected: _selectedPriceTier == 'priority',
                      accentColor: priorityColor,
                    ),
                    const SizedBox(height: 16),
                    if (_selectedOffer != null)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: cs.outline),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.totalToPayTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _money(_selectedOffer),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: cs.primary,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              l10n.includesServiceTransportation,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: cs.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _paying ? null : _confirmOffer,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: _paying
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(l10n.confirmAndPay,
                              style: const TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: cs.outline),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.howPricingWorksTitle,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: cs.primary,
                                    ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            l10n.howPricingWorksBullets,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: cs.onSurfaceVariant,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
