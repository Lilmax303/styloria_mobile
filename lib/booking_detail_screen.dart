// lib/booking_detail_screen.dart

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';
import 'utils/datetime_helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'africa_countries.dart';
import 'api_client.dart';
import 'chat_screen.dart';
import 'portfolio_viewer_screen.dart';

class BookingDetailScreen extends StatefulWidget {
  final Map<String, dynamic> booking;
  final String role; // "user" or "provider"

  const BookingDetailScreen({
    super.key,
    required this.booking,
    required this.role,
  });

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  late Map<String, dynamic> _booking;
  // Enhanced job details (for providers after acceptance)
  Map<String, dynamic>? _enhancedJobDetails;
  bool _loadingEnhancedDetails = false;

  LatLng? _position;
  LatLng? _myPosition;
  LatLng? _otherPosition;

  // Other party (provider/user) location
  Map<String, dynamic>? _otherPartyLocation;

  // Distance value (miles)
  double? _distanceMilesValue;

  // ETA data
  Map<String, dynamic>? _etaData;
  bool _etaLoading = false;

  // Provider reviews (for requester to see)
  List<dynamic> _providerReviews = [];
  bool _providerReviewsLoading = false;
  bool _providerReviewsExpanded = false;
  static const int _initialProviderReviewsToShow = 2;

  bool _calling = false;
  bool _processingCancel = false;
  bool _processingComplete = false;
  bool _processingTip = false;

  // Track if user has submitted a review for this booking
  bool _reviewSubmitted = false;

  // Track if provider has reviewed the requester
  bool _requesterReviewSubmitted = false;
  bool _checkingRequesterReview = false;

  // Requester reputation (for providers to see)
  Map<String, dynamic>? _requesterReputation;
  bool _requesterReputationLoading = false;
  bool _requesterReputationExpanded = false;
  static const int _initialRequesterReviewsToShow = 2;

  DateTime? _acceptedAt;
  Duration? _cancelDeadlineDiff;
  Timer? _cancelTimer;
  Timer? _trackingTimer;
  bool _trackingStarted = false;

  // User's country for payment routing (Stripe vs Flutterwave)
  String? _userCountry;

  @override
  void initState() {
    super.initState();
    _booking = Map<String, dynamic>.from(widget.booking);
    _initPosition();
    _setupAcceptedAtAndTimer();
    _startTrackingIfNeeded();
    _loadUserCountry();
    _loadEnhancedJobDetails();

    // Check if review was already submitted (backend may provide this field)
    _reviewSubmitted = _booking['has_user_review'] == true || 
                       _booking['user_has_reviewed'] == true ||
                       _booking['review_submitted'] == true;

    // For providers: check if they've reviewed the requester
    _requesterReviewSubmitted = _booking['has_requester_review'] == true ||
                                _booking['provider_reviewed_requester'] == true;

    final status = _booking['status']?.toString() ?? '';
    if (status == 'accepted' || status == 'in_progress') {
      _loadOtherPartyLocation();
      _loadEta();
      _loadProviderReviews();
    }

    // Also load reviews for completed bookings
    if (status == 'completed') {
      _loadProviderReviews();
      if (widget.role == 'provider') {
        _checkRequesterReviewStatus();
      }
    }

    // Load requester reputation for providers
    if (widget.role == 'provider' && 
        (status == 'accepted' || status == 'in_progress' || status == 'completed')) {
      _loadRequesterReputation();
    }
  }

  @override
  void dispose() {
    _cancelTimer?.cancel();
    _trackingTimer?.cancel();
    super.dispose();
  }
  Future<void> _loadUserCountry() async {
    final user = await ApiClient.getCurrentUser();
    if (!mounted || user == null) return;
    setState(() {
      _userCountry = user['country_name']?.toString();
    });
  }

  Future<void> _loadEnhancedJobDetails() async {
    // Only for providers viewing accepted+ jobs
    if (widget.role != 'provider') return;
    
    final status = _booking['status']?.toString() ?? '';
    if (status != 'accepted' && status != 'in_progress' && status != 'completed') return;
    
    final idRaw = _booking['id'];
    final requestId = idRaw is int ? idRaw : int.tryParse(idRaw.toString());
    if (requestId == null) return;
    
    setState(() => _loadingEnhancedDetails = true);
    
    final details = await ApiClient.getJobDetails(requestId);
    if (!mounted) return;
    
    setState(() {
      _enhancedJobDetails = details;
      _loadingEnhancedDetails = false;
    });
  }

  String _resolveUrl(String? raw) {
    if (raw == null || raw.isEmpty) return '';
    if (raw.startsWith('http://') || raw.startsWith('https://')) return raw;
    if (raw.startsWith('/')) return '${ApiClient.baseUrl}$raw';
    return raw;
  }

  // Haversine distance (miles)
  double _calculateDistanceMiles(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadiusMiles = 3958.8;
    final dLat = (lat2 - lat1) * pi / 180;
    final dLon = (lon2 - lon1) * pi / 180;

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * pi / 180) * cos(lat2 * pi / 180) * sin(dLon / 2) * sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusMiles * c;
  }

  Future<void> _loadOtherPartyLocation() async {
    final idRaw = _booking['id'];
    final requestId = idRaw is int ? idRaw : int.tryParse(idRaw.toString());

    if (requestId == null) return;

    final loc = await ApiClient.getOtherPartyLocation(requestId);
    if (!mounted) return;

    setState(() {
      _otherPartyLocation = loc;

      if (loc != null) {
        final bookingLat = _booking['location_latitude'] as num? ?? 0;
        final bookingLng = _booking['location_longitude'] as num? ?? 0;
        final otherLat = loc['latitude'] as num? ?? 0;
        final otherLng = loc['longitude'] as num? ?? 0;
        _otherPosition = LatLng(otherLat.toDouble(), otherLng.toDouble());

        final miles = _calculateDistanceMiles(
          bookingLat.toDouble(),
          bookingLng.toDouble(),
          otherLat.toDouble(),
          otherLng.toDouble(),
        );

        _distanceMilesValue = miles;
      } else {
        _distanceMilesValue = null;
        _otherPosition = null;
      }
    });
  }

  Future<void> _loadEta() async {
    final idRaw = _booking['id'];
    final requestId = idRaw is int ? idRaw : int.tryParse(idRaw.toString());

    if (requestId == null) return;

    setState(() => _etaLoading = true);

    final eta = await ApiClient.getBookingEta(requestId);
    
    if (!mounted) return;

    setState(() {
      _etaData = eta?['eta'] as Map<String, dynamic>?;
      _etaLoading = false;
    });
  }

  Future<void> _loadProviderReviews() async {
    final idRaw = _booking['id'];
    final requestId = idRaw is int ? idRaw : int.tryParse(idRaw.toString());

    if (requestId == null) return;
    if (widget.role != 'user') return; // Only for requesters

    setState(() => _providerReviewsLoading = true);

    final data = await ApiClient.getProviderReviewsForBooking(requestId);

    if (!mounted) return;

    setState(() {
      _providerReviews = (data?['reviews'] as List?) ?? [];
      _providerReviewsLoading = false;
    });
  }

  Future<void> _checkRequesterReviewStatus() async {
    final idRaw = _booking['id'];
    final requestId = idRaw is int ? idRaw : int.tryParse(idRaw.toString());
    if (requestId == null) return;
    
    setState(() => _checkingRequesterReview = true);
    
    final result = await ApiClient.checkRequesterReview(requestId);
    
    if (!mounted) return;
   
    setState(() {
      _checkingRequesterReview = false;
      _requesterReviewSubmitted = result?['has_reviewed'] == true;
    });
  }

  Future<void> _loadRequesterReputation() async {
    // Only for providers viewing accepted+ jobs
    if (widget.role != 'provider') return;
    
    final status = _booking['status']?.toString() ?? '';
    if (status != 'accepted' && status != 'in_progress' && status != 'completed') return;
    
    // Get user ID from booking
    final user = _booking['user'] as Map<String, dynamic>?;
    final userId = user?['id'];
    if (userId == null) return;
    
    final userIdInt = userId is int ? userId : int.tryParse(userId.toString());
    if (userIdInt == null) return;
    
    setState(() => _requesterReputationLoading = true);
    
    final reputation = await ApiClient.getUserReputation(userIdInt);
    
    if (!mounted) return;
    
    setState(() {
      _requesterReputation = reputation;
      _requesterReputationLoading = false;
    });
  }

  Future<void> _openRequesterReviewDialog() async {
    final l10n = AppLocalizations.of(context);
    final idRaw = _booking['id'];
    final requestId = idRaw is int ? idRaw : int.tryParse(idRaw.toString());
    if (requestId == null) return;
    
    // Get requester name
    final requesterFirstName = _booking['requester_first_name']?.toString() ?? 
                               _booking['user']?['first_name']?.toString() ?? '';
    final requesterUsername = _booking['user']?['username']?.toString() ?? 'Customer';
    final requesterName = requesterFirstName.isNotEmpty ? requesterFirstName : requesterUsername;
    
    final result = await showDialog<Map<String, dynamic>?>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return _RequesterReviewDialog(
          requesterName: requesterName,
          onSubmit: (rating, comment) async {
            final response = await ApiClient.submitRequesterReview(
              serviceRequestId: requestId,
              rating: rating,
              comment: comment,
            );
            return response != null;
          },
        );
      },
    );
    
    if (!mounted) return;
    
    if (result != null && result['success'] == true) {
      setState(() {
        _requesterReviewSubmitted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Customer review submitted!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _tickTracking() async {
    final status = _booking['status']?.toString() ?? '';
    if (status != 'accepted' && status != 'in_progress') return;
    final idRaw = _booking['id'];
    final requestId = idRaw is int ? idRaw : int.tryParse(idRaw.toString());
    if (requestId == null) return;

    try {
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      if (mounted) setState(() => _myPosition = LatLng(pos.latitude, pos.longitude));
      await ApiClient.updateLocation(
        bookingId: requestId,
        latitude: pos.latitude,
        longitude: pos.longitude,
        isProvider: widget.role == 'provider',
      );
    } catch (_) {
      // ignore (no permission, gps off, etc.)
    }

    await _loadOtherPartyLocation();

    // Refresh ETA every tracking cycle (for requester)
    if (widget.role == 'user') {
      await _loadEta();
    }
  }

  void _startTrackingIfNeeded() {
    if (_trackingStarted) return;
    final status = _booking['status']?.toString() ?? '';
    if (status != 'accepted' && status != 'in_progress') return;
    _trackingStarted = true;
    _trackingTimer?.cancel();
    _trackingTimer = Timer.periodic(const Duration(seconds: 5), (_) => _tickTracking());
    _tickTracking();
  }


  void _initPosition() {
    final rawLat = _booking['location_latitude'];
    final rawLng = _booking['location_longitude'];

    double? lat;
    double? lng;

    if (rawLat is num && rawLng is num) {
      lat = rawLat.toDouble();
      lng = rawLng.toDouble();
    } else if (rawLat is String && rawLng is String) {
      lat = double.tryParse(rawLat);
      lng = double.tryParse(rawLng);
    }

    if (lat != null && lng != null) {
      setState(() {
        _position = LatLng(lat!, lng!);
      });
    }
  }

  void _setupAcceptedAtAndTimer() {
    _cancelTimer?.cancel();
    _acceptedAt = null;
    _cancelDeadlineDiff = null;

    final status = _booking['status']?.toString() ?? '';
    final acceptedAtStr = _booking['accepted_at']?.toString();

    if (acceptedAtStr == null ||
        acceptedAtStr.isEmpty ||
        !(status == 'accepted' || status == 'in_progress')) {
      return;
    }

    try {
      _acceptedAt = DateTime.parse(acceptedAtStr).toUtc();
    } catch (_) {
      return;
    }

    _tickCancelTimer();
    _cancelTimer = Timer.periodic(const Duration(seconds: 1), (_) => _tickCancelTimer());
  }

  void _tickCancelTimer() {
    if (!mounted) {
      _cancelTimer?.cancel();
      return;
    }
    if (_acceptedAt == null) return;

    final deadline = _acceptedAt!.add(const Duration(minutes: 7));
    final now = DateTime.now().toUtc();
    final remaining = deadline.difference(now);

    setState(() {
      if (remaining <= Duration.zero) {
        _cancelDeadlineDiff = Duration.zero;
        _cancelTimer?.cancel();
      } else {
        _cancelDeadlineDiff = remaining;
      }
    });
  }

  Future<void> _openChat() async {
    final idRaw = _booking['id'];
    final requestId = idRaw is int ? idRaw : int.tryParse(idRaw.toString());

    if (requestId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).invalidBookingIdForChat)),
      );
      return;
    }

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChatScreen(
          serviceRequestId: requestId,
          booking: _booking,
        ),
      ),
    );
  }

  Future<void> _callCounterpart() async {
    final idRaw = _booking['id'];
    final requestId = idRaw is int ? idRaw : int.tryParse(idRaw.toString());

    if (requestId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).invalidBookingIdForCall)),
      );
      return;
    }

    setState(() => _calling = true);

    final info = await ApiClient.getContactInfo(requestId);
    if (!mounted) return;

    setState(() => _calling = false);

    if (info == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).unableToLoadContactInfo)),
      );
      return;
    }

    final phone = info['phone_number']?.toString();
    final name = info['name']?.toString() ?? AppLocalizations.of(context).genericContact;

    if (phone == null || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).noPhoneNumberAvailableForName(name))),
      );
      return;
    }

    final uri = Uri(scheme: 'tel', path: phone);

    final canCall = await canLaunchUrl(uri);
    if (!mounted) return;

    if (!canCall) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).deviceCannotPlaceCalls)),
      );
      return;
    }

    await launchUrl(uri);
  }

  Future<void> _openNavigation() async {
    final details = _enhancedJobDetails ?? _booking;
    final lat = details['location_latitude'];
    final lng = details['location_longitude'];
    
    if (lat == null || lng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location not available')),
      );
      return;
    }
    
    final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
    
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open maps')),
        );
      }
    }
  }

  Future<void> _callCustomer() async {
    final l10n = AppLocalizations.of(context);
    
    // Use enhanced details for direct customer contact
    final phone = _enhancedJobDetails?['customer_phone']?.toString();
    final customerName = _enhancedJobDetails?['customer_full_name']?.toString() ?? 'Customer';
    
    if (phone == null || phone.isEmpty) {
      // Fallback to existing contact info method
      await _callCounterpart();
      return;
    }
    
    final uri = Uri(scheme: 'tel', path: phone);
    
    final canCall = await canLaunch(uri.toString());
    if (!mounted) return;
    
    if (!canCall) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cannot make phone calls on this device')),
      );
      return;
    }
    
    await launch(uri.toString());
  }

  Future<void> _cancelBooking() async {
    final idRaw = _booking['id'];
    final requestId = idRaw is int ? idRaw : int.tryParse(idRaw.toString());

    if (requestId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).invalidBookingIdForCall)),
      );
      return;
    }

    final l10n = AppLocalizations.of(context);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.cancelBookingDialogTitle),
        content: Text(l10n.cancelBookingDialogBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.no),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.yesCancel),
          ),
        ],
      ),
    );

    if (!mounted) return;
    if (confirm != true) return;

    setState(() => _processingCancel = true);

    final updated = await ApiClient.cancelServiceRequest(requestId);
    if (!mounted) return;

    setState(() => _processingCancel = false);

    if (updated == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.failedToCancelBooking)),
      );
      return;
    }

    setState(() => _booking = updated);
    _setupAcceptedAtAndTimer();
    if (mounted) _startTrackingIfNeeded();

    final penaltyApplied = updated['penalty_applied'] == true;
    final penaltyAmount = updated['penalty_amount']?.toString();

    if (penaltyApplied && penaltyAmount != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.bookingCancelledPenaltyApplied(penaltyAmount))),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.bookingCancelledSuccessfully)),
      );
    }
  }

  Future<void> _confirmCompletion() async {
    final idRaw = _booking['id'];
    final requestId = idRaw is int ? idRaw : int.tryParse(idRaw.toString());

    if (requestId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).invalidBookingIdForCall)),
      );
      return;
    }

    final l10n = AppLocalizations.of(context);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.confirmCompletion),
        content: Text(
          'Only confirm if the service has been fully completed. You may not be able to undo this.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.genericCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.genericContinue),
          ),
        ],
      ),
    );

    if (!mounted) return;
    if (confirm != true) return;

    setState(() => _processingComplete = true);

    final updated = await ApiClient.confirmCompletion(requestId);
    if (!mounted) return;

    setState(() => _processingComplete = false);

    if (updated == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).failedToConfirmCompletion)),
      );
      return;
    }


    setState(() => _booking = updated);
    _setupAcceptedAtAndTimer();

    final userConfirmed = updated['user_confirmed_completion'] == true;
    final providerConfirmed = updated['provider_confirmed_completion'] == true;
    final status = updated['status']?.toString() ?? '';

    final msg = (status == 'completed' && userConfirmed && providerConfirmed)
        ? l10n.bothSidesConfirmedCompletedPayoutReleased
        : (widget.role == 'user'
            ? l10n.youConfirmedCompletionWaitingForProvider
            : l10n.youConfirmedCompletionWaitingForUser);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

    Future<void> _openReviewDialog(int providerId, String providerName, int bookingId) async {
      final l10n = AppLocalizations.of(context);
      
      int selectedRating = 5;
      String commentText = '';

      final result = await showDialog<Map<String, dynamic>?>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return _ReviewDialog(
            providerName: providerName,
            initialRating: selectedRating,
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
      
      if (result != null && result['success'] == true) {
        setState(() {
          _reviewSubmitted = true;
          // Update local booking data so it persists
          _booking['has_user_review'] = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.reviewSubmitted)),
        );
      }
    }

    double? _parseAmount(dynamic raw) {
      if (raw == null) return null;
      final text = raw.toString().trim();
      if (text.isEmpty) return null;
      final cleaned = text.replaceAll(RegExp(r'[^0-9\.\-]'), '');
      if (cleaned.isEmpty) return null;
      return double.tryParse(cleaned);
    }
  
    Future<void> _tipProvider({
      required int requestId,
      required double totalPaid,
    }) async {
      final l10n = AppLocalizations.of(context);
      final messenger = ScaffoldMessenger.of(context);

      // Determine payment gateway based on user's country
      final gateway = ApiClient.getPaymentGateway(_userCountry);

      // Presets: based on total paid
      final preset5 = (totalPaid * 0.05);
      final preset10 = (totalPaid * 0.10);
      final preset15 = (totalPaid * 0.15);
  
      final controller = TextEditingController();
 
      final chosen = await showDialog<double?>(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(l10n.tipLeaveTitle),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.tipChooseAmountPrompt),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.of(ctx).pop(0.0),
                      child: Text(l10n.tipNoTip),
                    ),
                    OutlinedButton(
                      onPressed: () => Navigator.of(ctx).pop(double.parse(preset5.toStringAsFixed(2))),
                      child: Text('5% (${preset5.toStringAsFixed(2)})'),
                    ),
                    OutlinedButton(
                      onPressed: () => Navigator.of(ctx).pop(double.parse(preset10.toStringAsFixed(2))),
                      child: Text('10% (${preset10.toStringAsFixed(2)})'),
                    ),
                    OutlinedButton(
                      onPressed: () => Navigator.of(ctx).pop(double.parse(preset15.toStringAsFixed(2))),
                      child: Text('15% (${preset15.toStringAsFixed(2)})'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: l10n.tipCustomAmountLabel,
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(null),
                child: Text(l10n.genericCancel),
              ),
              ElevatedButton(
                onPressed: () {
                  final raw = controller.text.trim();
                  if (raw.isEmpty) {
                    Navigator.of(ctx).pop(null);
                    return;
                  }
                  Navigator.of(ctx).pop(_parseAmount(raw));
                },
                child: Text(l10n.genericContinue),
              ),
            ],
          );
        },
      );

      // Avoid "TextEditingController used after disposed" during dialog pop animation:
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.dispose();
      });

      if (!mounted) return;
      final selected = chosen;
      if (selected == null) return;

      // Handle "No tip" selection
      if (selected == 0) {
        setState(() => _processingTip = true);
        final updated = await ApiClient.setTip(requestId: requestId, tipAmount: 0);
        if (!mounted) return;
        setState(() => _processingTip = false);

        if (updated != null) {
          setState(() => _booking = updated);
          messenger.showSnackBar(SnackBar(content: Text(l10n.tipSkipped)));
        } else {
          messenger.showSnackBar(SnackBar(content: Text(l10n.tipFailedToSaveChoice)));
        }
        return;
      }

      if (selected < 0) return;

      setState(() => _processingTip = true);

      try {
        // PAYSTACK (Ghana, Nigeria, South Africa, Kenya, Côte d'Ivoire)
        if (gateway == 'paystack') {
          final checkout = await ApiClient.createTipPaystackCheckout(
            serviceRequestId: requestId,
            tipAmount: selected,
          );

          if (!mounted) return;
          if (checkout == null) {
            setState(() => _processingTip = false);
            messenger.showSnackBar(SnackBar(content: Text(l10n.tipFailedToCreatePayment)));
            return;
          }

          final authorizationUrl = (checkout['authorization_url'] ?? '').toString();
          final reference = (checkout['reference'] ?? '').toString();

          if (authorizationUrl.isEmpty || reference.isEmpty) {
            setState(() => _processingTip = false);
            messenger.showSnackBar(SnackBar(content: Text(l10n.tipFailedToCreatePayment)));
            return;
          }

          // Launch Paystack payment page
          final uri = Uri.tryParse(authorizationUrl);
          if (uri == null) {
            setState(() => _processingTip = false);
            messenger.showSnackBar(SnackBar(content: Text(l10n.tipFailedToCreatePayment)));
            return;
          }

          final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
          if (!launched) {
            setState(() => _processingTip = false);
            messenger.showSnackBar(
              const SnackBar(content: Text('Could not open payment page. Please try again.')),
            );
            return;
          }

          // Show verification dialog - user needs to confirm after payment
          if (!mounted) return;
          
          final shouldVerify = await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => AlertDialog(
              title: const Text('Payment Verification'),
              content: const Text(
                'After completing the payment in your browser, tap "Verify Payment" to confirm.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(false),
                  child: Text(l10n.genericCancel),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(ctx).pop(true),
                  child: const Text('Verify Payment'),
                ),
              ],
            ),
          );

          if (!mounted) return;

          if (shouldVerify != true) {
            setState(() => _processingTip = false);
            messenger.showSnackBar(
              SnackBar(content: Text(l10n.tipCancelledOrFailed(''))),
            );
            return;
          }

          // Verify the payment
          messenger.showSnackBar(
            const SnackBar(content: Text('Verifying payment...')),
          );

          final verifyResult = await ApiClient.verifyTipPaystackPayment(
            serviceRequestId: requestId,
            reference: reference,
          );

          if (!mounted) return;
          setState(() => _processingTip = false);

          if (verifyResult['verified'] == true) {
            final updatedBooking = verifyResult['booking'] as Map<String, dynamic>?;
            if (updatedBooking != null) {
              setState(() => _booking = updatedBooking);
            }
            messenger.showSnackBar(SnackBar(content: Text(l10n.tipPaidSuccessfully)));
          } else {
            final detail = verifyResult['detail']?.toString() ?? '';
            messenger.showSnackBar(
              SnackBar(content: Text(detail.isNotEmpty ? detail : l10n.tipCancelledOrFailed(''))),
            );
          }
          return;
        }

        // FLUTTERWAVE (Other African countries)
        if (gateway == 'flutterwave') {
          final checkout = await ApiClient.createTipFlutterwaveCheckout(
            serviceRequestId: requestId,
            tipAmount: selected,
          );

          if (!mounted) return;
          if (checkout == null) {
            setState(() => _processingTip = false);
            messenger.showSnackBar(SnackBar(content: Text(l10n.tipFailedToCreatePayment)));
            return;
          }

          final publicKey = (checkout['public_key'] ?? '').toString();
          final txRef = (checkout['tx_ref'] ?? '').toString();
          final currency = (checkout['currency'] ?? 'USD').toString();
          final customerEmail = (checkout['customer_email'] ?? '').toString();
          final customerPhone = (checkout['customer_phone'] ?? '').toString();
          final customerName = (checkout['customer_name'] ?? '').toString();

          final flutterwave = Flutterwave(
            publicKey: publicKey,
            currency: currency,
            txRef: txRef,
            amount: selected.toStringAsFixed(2),
            customer: Customer(
              name: customerName.isNotEmpty ? customerName : 'Customer',
              phoneNumber: customerPhone.isNotEmpty ? customerPhone : '0000000000',
              email: customerEmail.isNotEmpty ? customerEmail : 'no-reply@styloria.com',
            ),
            paymentOptions: "card,banktransfer,ussd,mobilemoney",
            customization: Customization(
              title: "Styloria Tip",
              description: "Tip for your service provider",
              logo: null,
            ),
            isTestMode: checkout['is_test_mode'] == true,
            redirectUrl: checkout['redirect_url']?.toString() ?? "https://locally-sinistrodextral-raelene.ngrok-free.dev/flutterwave/redirect/",
          );

          final resp = await flutterwave.charge(context);
          if (!mounted) return;

          // Check if we got a successful response with transaction ID
          if (resp.status == "successful" && resp.transactionId != null) {
            final int? transactionId = int.tryParse(resp.transactionId ?? '');
            if (transactionId != null) {
              // Verify with backend using transaction ID
              final verifyResult = await ApiClient.verifyTipFlutterwavePayment(
                serviceRequestId: requestId,
                txRef: txRef,
                transactionId: transactionId,
              );

              if (!mounted) return;
              setState(() => _processingTip = false);

              if (verifyResult['verified'] == true) {
                final updatedBooking = verifyResult['booking'] as Map<String, dynamic>?;
                if (updatedBooking != null) {
                  setState(() => _booking = updatedBooking);
                }
                messenger.showSnackBar(SnackBar(content: Text(l10n.tipPaidSuccessfully)));
              } else {
                messenger.showSnackBar(SnackBar(content: Text(l10n.tipPaidButUpdateFailed)));
              }
              return;
            }
          }

          // SDK didn't return success - but for MoMo, payment may have succeeded!
          // Show a "verifying" message and check with backend using tx_ref only
          messenger.showSnackBar(
            const SnackBar(content: Text('Verifying payment...')),
          );

          // Wait a moment for Flutterwave to process (MoMo can be slow)
          await Future.delayed(const Duration(seconds: 2));

          // Verify by tx_ref only
          final verifyResult = await ApiClient.verifyTipFlutterwaveByRef(
            serviceRequestId: requestId,
            txRef: txRef,
          );

          if (!mounted) return;
          setState(() => _processingTip = false);

          if (verifyResult['verified'] == true) {
            final updatedBooking = verifyResult['booking'] as Map<String, dynamic>?;
            if (updatedBooking != null) {
              setState(() => _booking = updatedBooking);
            }
            messenger.showSnackBar(SnackBar(content: Text(l10n.tipPaidSuccessfully)));
          } else {
            // Payment not found or not successful
            final status = verifyResult['status']?.toString() ?? '';
            final detail = verifyResult['detail']?.toString() ?? '';
            
            if (status == 'pending') {
              messenger.showSnackBar(
                const SnackBar(content: Text('Payment is still processing. Please check back in a moment.')),
              );
            } else {
              messenger.showSnackBar(
                SnackBar(content: Text(detail.isNotEmpty ? detail : l10n.tipCancelledOrFailed(''))),
              );
            }
          }
          return;
        }

        // STRIPE (Rest of the world) 
        final clientSecret = await ApiClient.createTipPaymentIntent(
          serviceRequestId: requestId,
          tipAmount: selected,
        );
 
        if (!mounted) return;
        if (clientSecret == null) {
          setState(() => _processingTip = false);
          messenger.showSnackBar(SnackBar(content: Text(l10n.tipFailedToCreatePayment)));
          return;
        }
  
        await stripe.Stripe.instance.initPaymentSheet(
          paymentSheetParameters: stripe.SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
            merchantDisplayName: l10n.appTitle,
            style: ThemeMode.system,
          ),
        );
  
        await stripe.Stripe.instance.presentPaymentSheet();
  
        final updated = await ApiClient.setTip(requestId: requestId, tipAmount: selected);
        if (!mounted) return;

        setState(() => _processingTip = false);
  
        if (updated != null) {
          setState(() => _booking = updated);
          messenger.showSnackBar(SnackBar(content: Text(l10n.tipPaidSuccessfully)));
        } else {
          messenger.showSnackBar(SnackBar(content: Text(l10n.tipPaidButUpdateFailed)));
        }
      } on stripe.StripeException catch (e) {
        if (!mounted) return;
        setState(() => _processingTip = false);
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.tipCancelledOrFailed(e.error.localizedMessage ?? ''))),
        );
      } catch (e) {
        if (!mounted) return;
        setState(() => _processingTip = false);
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.tipUnexpectedError(e.toString()))),
        );
      }
    }

  Color _statusColor(BuildContext context, String status) {
    final cs = Theme.of(context).colorScheme;
    switch (status) {
      case 'accepted':
        return cs.primary;
      case 'in_progress':
        return const Color(0xFFB76E79); // rose-gold
      case 'completed':
        return const Color(0xFF22C55E); // subtle green for success
      case 'cancelled':
        return cs.error;
      default:
        return cs.outline;
    }
  }

  Widget _statusPill(BuildContext context, String status, String paymentStatus) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    String localizeStatus(String s) {
      switch (s) {
        case 'pending':
        case 'open':
          return 'Pending';
        case 'accepted':
          return l10n.statusAccepted;
        case 'in_progress':
          return l10n.statusInProgress;
        case 'completed':
          return l10n.statusCompleted;
        case 'cancelled':
          return l10n.statusCancelled;
        default:
          return s.isEmpty ? l10n.statusUnknown : s.replaceAll('_', ' ');
      }
    }

    String localizePayment(String s) {
      switch (s) {
        case 'paid':
          return l10n.paymentPaid;
        case 'unpaid':
          return l10n.paymentUnpaid;
        case 'pending':
          return l10n.paymentPending;
        case 'failed':
          return l10n.paymentFailed;
        default:
          return s.isEmpty ? '' : s.replaceAll('_', ' ');
      }
    }

    final label = localizeStatus(status);
    final color = _statusColor(context, status);

    final payLabel = localizePayment(paymentStatus);
    final pay = payLabel.isEmpty ? '' : ' • $payLabel';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.9)),
      ),
      child: Text(
        '$label$pay',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: cs.onSurface,
            ),
      ),
    );
  }

  Widget _kv(BuildContext context, String k, String v, {bool strong = false}) {
    final cs = Theme.of(context).colorScheme;
    final keyStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
          color: cs.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        );
    final valStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: strong ? FontWeight.w800 : FontWeight.w600,
        );

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 140, child: Text(k, style: keyStyle)),
          Expanded(child: Text(v, style: valStyle)),
        ],
      ),
    );
  }

  Widget _providerHeaderCard(BuildContext context, Map<String, dynamic> provider) {
    final l10n = AppLocalizations.of(context);
    final providerUser = provider['user'] as Map<String, dynamic>?;
    final first = providerUser?['first_name']?.toString().trim() ?? '';
    final last = providerUser?['last_name']?.toString().trim() ?? '';
    final name = ('$first $last').trim().isNotEmpty
        ? ('$first $last').trim()
        : (providerUser?['username']?.toString() ?? l10n.genericProvider);

    final profilePic = _resolveUrl(providerUser?['profile_picture_url']?.toString());

    final avg = (provider['average_rating'] as num?)?.toDouble();
    final count = (provider['review_count'] as int?) ?? 0;
    final bio = provider['bio']?.toString() ?? '';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: (profilePic.isNotEmpty) ? NetworkImage(profilePic) : null,
                  child: (profilePic.isEmpty) ? const Icon(Icons.person) : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                      const SizedBox(height: 4),
                      if (avg != null)
                        Text(
                          l10n.ratingLine(avg.toStringAsFixed(1), count),
                          style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w600),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (bio.trim().isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                bio,
                style: TextStyle(color: Colors.grey[800]),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEtaCard(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;

    if (_etaLoading && _etaData == null) {
      return Card(
        color: cs.primaryContainer,
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (_etaData == null) {
      return const SizedBox.shrink();
    }

    final providerArrived = _etaData!['provider_arrived'] == true;
    final durationText = _etaData!['duration_text']?.toString() ?? '';
    final distanceMiles = _etaData!['distance_miles'];
    final durationMinutes = _etaData!['duration_minutes'];
    final isEstimate = _etaData!['is_estimate'] == true;

    String distanceStr = '';
    if (distanceMiles != null) {
      distanceStr = '${(distanceMiles as num).toStringAsFixed(1)} mi';
    }

    // Get provider name
    final provider = _booking['service_provider'] as Map<String, dynamic>?;
    final providerUser = provider?['user'] as Map<String, dynamic>?;
    final providerFirstName = providerUser?['first_name']?.toString() ?? '';
    final providerName = providerFirstName.isNotEmpty 
        ? providerFirstName 
        : (providerUser?['username']?.toString() ?? l10n.genericProvider);

    // If provider has arrived, show arrival card
    if (providerArrived) {
      return Card(
        elevation: 4,
        color: const Color(0xFF22C55E), // Success green
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$providerName has arrived!',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Please meet your provider to begin your service',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 4,
      color: cs.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: cs.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.directions_car,
                    color: cs.onPrimary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.providerArrivingTitle(providerName),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: cs.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            durationText.isNotEmpty 
                                ? durationText 
                                : (durationMinutes != null 
                                    ? '${(durationMinutes as num).toInt()} min' 
                                    : '--'),
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: cs.onPrimaryContainer,
                            ),
                          ),
                          if (distanceStr.isNotEmpty) ...[
                            const SizedBox(width: 8),
                            Text(
                              '($distanceStr)',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: cs.onPrimaryContainer.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                if (_etaLoading)
                  const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
            if (isEstimate) ...[
              const SizedBox(height: 8),
              Text(
                l10n.etaIsEstimate,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: cs.onPrimaryContainer.withOpacity(0.6),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProviderReviewsCard(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;

    if (_providerReviewsLoading && _providerReviews.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What others say',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 12),
              const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      );
    }

    if (_providerReviews.isEmpty) {
      return const SizedBox.shrink();
    }

    // Determine how many reviews to show
    final totalReviews = _providerReviews.length;
    final reviewsToShow = _providerReviewsExpanded
        ? _providerReviews
        : _providerReviews.take(_initialProviderReviewsToShow).toList();
    final hasMoreReviews = totalReviews > _initialProviderReviewsToShow;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.format_quote, size: 20, color: Colors.amber),
                const SizedBox(width: 8),
                Text(
                  'What others say',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reviewsToShow.length,
              separatorBuilder: (_, __) => const Divider(height: 20),
              itemBuilder: (context, index) {
                final review = reviewsToShow[index] as Map<String, dynamic>;
                final rating = (review['rating'] as int?) ?? 0;
                final comment = (review['comment'] ?? '').toString();
                final createdAt = review['created_at']?.toString() ?? '';
                final user = review['user'] as Map<String, dynamic>?;

                final firstName = user?['first_name']?.toString() ?? '';
                final lastName = user?['last_name']?.toString() ?? '';
                final username = user?['username']?.toString() ?? 'User';
                
                // Show only first name + last initial for privacy
                String displayName;
                if (firstName.isNotEmpty) {
                  displayName = lastName.isNotEmpty 
                      ? '$firstName ${lastName[0]}.' 
                      : firstName;
                } else {
                  displayName = username;
                }

                final profilePic = _resolveUrl(user?['profile_picture_url']?.toString());

                // Format date
                String dateStr = '';
                if (createdAt.isNotEmpty) {
                  try {
                    final dt = DateTime.parse(createdAt);
                    final now = DateTime.now();
                    final diff = now.difference(dt);
                    
                    if (diff.inDays == 0) {
                      dateStr = 'Today';
                    } else if (diff.inDays == 1) {
                      dateStr = 'Yesterday';
                    } else if (diff.inDays < 7) {
                      dateStr = '${diff.inDays} days ago';
                    } else if (diff.inDays < 30) {
                      final weeks = (diff.inDays / 7).floor();
                      dateStr = '$weeks week${weeks > 1 ? 's' : ''} ago';
                    } else {
                      dateStr = '${dt.day}/${dt.month}/${dt.year}';
                    }
                  } catch (_) {
                    dateStr = '';
                  }
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: profilePic.isNotEmpty
                          ? NetworkImage(profilePic)
                          : null,
                      child: profilePic.isEmpty
                          ? Text(
                              displayName.isNotEmpty ? displayName[0].toUpperCase() : '?',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  displayName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              // Star rating
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                  5,
                                  (i) => Icon(
                                    i < rating ? Icons.star : Icons.star_border,
                                    color: Colors.amber,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (comment.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              '"$comment"',
                              style: TextStyle(
                                color: cs.onSurfaceVariant,
                                fontStyle: FontStyle.italic,
                                fontSize: 13,
                              ),
                            ),
                          ],
                          if (dateStr.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              dateStr,
                              style: TextStyle(
                                color: cs.onSurfaceVariant.withOpacity(0.6),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),

            // Show More / Show Less button
            if (hasMoreReviews) ...[
              const SizedBox(height: 12),
              Center(
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _providerReviewsExpanded = !_providerReviewsExpanded;
                    });
                  },
                  icon: Icon(
                    _providerReviewsExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 20,
                  ),
                  label: Text(
                    _providerReviewsExpanded
                        ? 'Show less'
                        : 'Show more (${totalReviews - _initialProviderReviewsToShow} more)',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedJobDetailsCard(BuildContext context) {
    final l10n = AppLocalizations.of(context);
  
    // Only show for providers with accepted+ jobs
    if (widget.role != 'provider') return const SizedBox.shrink();
  
    final status = _booking['status']?.toString() ?? '';
  
    // ✅ PRIVACY: Hide customer details after completion
    if (status == 'completed') return const SizedBox.shrink();
  
    if (status != 'accepted' && status != 'in_progress') {
      return const SizedBox.shrink();
    }
    
    if (_loadingEnhancedDetails) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 8),
              Text('Loading customer details...'),
            ],
          ),
        ),
      );
    }
    
    if (_enhancedJobDetails == null) return const SizedBox.shrink();
    
    final customerName = _enhancedJobDetails!['customer_full_name']?.toString() ?? 'Customer';
    final customerPhone = _enhancedJobDetails!['customer_phone']?.toString();
    final customerAddress = _enhancedJobDetails!['customer_address']?.toString();
    final navigationAddress = _enhancedJobDetails!['navigation_address']?.toString();
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Customer Details',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            
            // Customer name
            Row(
              children: [
                const Icon(Icons.account_circle, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    customerName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Customer address
            if (customerAddress != null && customerAddress.isNotEmpty) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on, size: 20, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      customerAddress,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
            
            // Action buttons
            Row(
              children: [
                // Navigation button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _openNavigation,
                    icon: const Icon(Icons.navigation),
                    label: const Text('Navigate'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                
                // Call button
                if (customerPhone != null && customerPhone.isNotEmpty)
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _callCustomer,
                      icon: const Icon(Icons.phone),
                      label: const Text('Call'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildRequesterReputationCard(BuildContext context) {
    // Only show for providers with accepted+ jobs
    if (widget.role != 'provider') return const SizedBox.shrink();
    
    final status = _booking['status']?.toString() ?? '';
    if (status != 'accepted' && status != 'in_progress' && status != 'completed') {
      return const SizedBox.shrink();
    }
    
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Get requester info from booking
    final user = _booking['user'] as Map<String, dynamic>?;
    final requesterFirstName = _booking['requester_first_name']?.toString() ?? 
                               user?['first_name']?.toString() ?? '';
    final requesterUsername = user?['username']?.toString() ?? 'Customer';
    final requesterName = requesterFirstName.isNotEmpty ? requesterFirstName : requesterUsername;
    
    // Get profile picture from reputation data or booking
    final profilePicUrl = _requesterReputation?['profile_picture_url']?.toString() ??
                          _resolveUrl(user?['profile_picture_url']?.toString());
    
    // Get rating info
    final avgRating = (_requesterReputation?['average_rating'] as num?)?.toDouble() ??
                      (_booking['requester_average_rating'] as num?)?.toDouble() ?? 0.0;
    final totalReviews = (_requesterReputation?['total_reviews'] as int?) ??
                         (_booking['requester_review_count'] as int?) ?? 0;
    final reviews = (_requesterReputation?['reviews'] as List<dynamic>?) ?? [];
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.person_pin, color: Colors.blue.shade700),
                const SizedBox(width: 8),
                Text(
                  'Customer Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            
            // Profile section with picture and rating
            Row(
              children: [
                // Profile picture
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: profilePicUrl.isNotEmpty
                      ? NetworkImage(profilePicUrl)
                      : null,
                  child: profilePicUrl.isEmpty
                      ? Text(
                          requesterName.isNotEmpty ? requesterName[0].toUpperCase() : '?',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                
                // Name and rating
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        requesterName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Rating row
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            return Icon(
                              index < avgRating.round() ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                              size: 18,
                            );
                          }),
                          const SizedBox(width: 8),
                          Text(
                            avgRating > 0
                                ? '${avgRating.toStringAsFixed(1)} ($totalReviews)'
                                : 'New customer',
                            style: TextStyle(
                              fontSize: 13,
                              color: avgRating > 0 ? cs.onSurface : Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Reviews section (built separately to avoid if/else issues)
            _buildRequesterReviewsSection(reviews, isDark, totalReviews),
          ],
        ),
      ),
    );
  }

  Widget _buildRequesterReviewsSection(List<dynamic> reviews, bool isDark, int totalReviews) {
    // Loading state
    if (_requesterReputationLoading) {
      return const Padding(
        padding: EdgeInsets.only(top: 16),
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }
    
    // No reviews state
    if (reviews.isEmpty && totalReviews == 0) {
      return Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, size: 18, color: Colors.grey.shade600),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'This is a new customer with no reviews yet.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      );
    }
    
    // Has reviews
    if (reviews.isEmpty) return const SizedBox.shrink();
    
    final displayCount = _requesterReputationExpanded
        ? reviews.length
        : reviews.length.clamp(0, _initialRequesterReviewsToShow);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.format_quote, size: 16, color: Colors.amber),
            const SizedBox(width: 4),
            Text(
              'What other providers say',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        
        // Reviews list
        ...List.generate(displayCount, (i) {
          final review = reviews[i] as Map<String, dynamic>;
          final rating = (review['rating'] as int?) ?? 0;
          final comment = (review['comment'] ?? '').toString();
          final providerName = (review['provider_name'] ?? 'Provider').toString();
          final createdAt = review['created_at']?.toString() ?? '';
          
          // Format time ago
          String timeAgo = '';
          if (createdAt.isNotEmpty) {
            try {
              final date = DateTime.parse(createdAt);
              final diff = DateTime.now().difference(date);
              if (diff.inDays > 30) {
                timeAgo = '${(diff.inDays / 30).floor()}mo ago';
              } else if (diff.inDays > 0) {
                timeAgo = '${diff.inDays}d ago';
              } else if (diff.inHours > 0) {
                timeAgo = '${diff.inHours}h ago';
              } else {
                timeAgo = 'Just now';
              }
            } catch (_) {}
          }
          
          return Container(
            margin: EdgeInsets.only(bottom: i < displayCount - 1 ? 8 : 0),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Provider initial
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        providerName.isNotEmpty ? providerName[0].toUpperCase() : 'P',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        providerName,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // Rating
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, size: 12, color: Colors.amber),
                        const SizedBox(width: 2),
                        Text(
                          '$rating',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (comment.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    '"$comment"',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                    ),
                  ),
                ],
                if (timeAgo.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    timeAgo,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ],
            ),
          );
        }),
        
        // Show more/less button
        if (reviews.length > _initialRequesterReviewsToShow)
          Center(
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  _requesterReputationExpanded = !_requesterReputationExpanded;
                });
              },
              icon: Icon(
                _requesterReputationExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: 18,
              ),
              label: Text(
                _requesterReputationExpanded
                    ? 'Show less'
                    : 'Show more (${reviews.length - _initialRequesterReviewsToShow} more)',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
      ],
    );
  }


  /// Build location card with privacy protection for completed bookings
  Widget _buildLocationCard(
    BuildContext context,
    String latStr,
    String lngStr,
    String locationAddress,
    String status,
  ) {
    final l10n = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    final isCompleted = status == 'completed';
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isCompleted ? Icons.location_city : Icons.location_on,
                  size: 20,
                  color: cs.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.location,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
                if (isCompleted) ...[
                  const SizedBox(width: 8),
                  Icon(Icons.lock, size: 14, color: Colors.grey.shade600),
                ],
              ],
            ),
            const SizedBox(height: 10),
            
            // ✅ PRIVACY: For completed bookings, show general area only
            if (isCompleted) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 18, color: Colors.amber.shade700),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'For your safety, exact location details are hidden after service completion. Only general area is shown.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.amber.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              
              // Show only general area (city/region)
              if (locationAddress.isNotEmpty)
                _kv(context, 'General Area', _getGeneralArea(locationAddress))
              else
                _kv(context, 'General Area', 'Service completed'),
              
            ] else ...[
              // ✅ ACTIVE SERVICE: Show full location details
              _kv(context, l10n.latitude, latStr),
              _kv(context, l10n.longitude, lngStr),
              
              const SizedBox(height: 12),
              
              if (_position != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: SizedBox(
                    height: 260,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _position!,
                        zoom: 14,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId('booking'),
                          position: _position!,
                          infoWindow: InfoWindow(title: l10n.bookingLocation),
                        ),
                        if (_myPosition != null)
                          Marker(
                            markerId: const MarkerId('me'),
                            position: _myPosition!,
                            infoWindow: const InfoWindow(title: 'Me'),
                          ),
                        if (_otherPosition != null)
                          Marker(
                            markerId: const MarkerId('other'),
                            position: _otherPosition!,
                            infoWindow: const InfoWindow(title: 'Other'),
                          ),
                      },
                      myLocationEnabled: false,
                      zoomControlsEnabled: true,
                    ),
                  ),
                )
              else
                Text(
                  l10n.mapWillAppearWhenCoordinatesValid,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                ),
            ],
          ],
        ),
      ),
    );
  }
  
  /// Extract general area from full address (city/region only)
  String _getGeneralArea(String fullAddress) {
    if (fullAddress.isEmpty) return 'Completed service area';
    
    // Split by comma and take last 1-2 parts (city, country)
    final parts = fullAddress.split(',').map((s) => s.trim()).toList();
    
    if (parts.length >= 2) {
      // Return city and country only (e.g., "Accra, Ghana")
      return '${parts[parts.length - 2]}, ${parts[parts.length - 1]}';
    } else if (parts.length == 1) {
      return parts[0];
    }
    
    return 'Service area';
  }


  Widget _portfolioGridCard(BuildContext context, List<dynamic> posts) {
    final l10n = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.proofOfSkillsPortfolio, style: const TextStyle(fontWeight: FontWeight.w900)),
            const SizedBox(height: 10),
            if (posts.isEmpty)
              Text(
                l10n.noPortfolioPostsAvailable,
                style: TextStyle(color: Colors.grey[700]),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: posts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final post = posts[index] as Map<String, dynamic>;
                  final mediaType = (post['media_type'] ?? 'image').toString();
                  final mediaUrl = _resolveUrl((post['media_url'] ?? '').toString());

                  return InkWell(
                    onTap: () {
                      final fixedPosts = posts.map((p) {
                        final m = Map<String, dynamic>.from(p as Map);
                        m['media_url'] = _resolveUrl(m['media_url']?.toString());
                        return m;
                      }).toList();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PortfolioViewerScreen(posts: fixedPosts, initialIndex: index),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            color: Colors.grey[200],
                            child: mediaUrl.isEmpty
                                ? const Center(child: Icon(Icons.broken_image))
                                : Image.network(
                                    mediaUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const Center(child: Icon(Icons.broken_image)),
                                  ),
                          ),
                          if (mediaType == 'video')
                            Container(
                              color: Colors.black.withOpacity(0.25),
                              child: const Center(
                                child: Icon(Icons.play_circle_fill, color: Colors.white, size: 36),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    final booking = _booking;

    final id = booking['id']?.toString() ?? '';
    final na = l10n.genericNotAvailable;
    final status = booking['status']?.toString() ?? '';
    final paymentStatus = booking['payment_status']?.toString() ?? '';
    final serviceType = booking['service_type']?.toString() ?? na;
    final estimatedPrice = booking['estimated_price']?.toString() ?? na;
    final offeredPrice = booking['offered_price']?.toString() ?? na;

    final appointmentTime = booking['appointment_time']?.toString() ?? '';
    final appointmentDisplay = DateTimeHelper.formatAppointmentTime(appointmentTime);
    final isToday = DateTimeHelper.isToday(appointmentTime);
    final isPast = DateTimeHelper.isPast(appointmentTime);

    final acceptedAt = booking['accepted_at']?.toString();
    final cancelledAt = booking['cancelled_at']?.toString();
    final cancelledBy = booking['cancelled_by']?.toString();
    final penaltyApplied = booking['penalty_applied'] == true;
    final penaltyAmount = booking['penalty_amount']?.toString();
    final userConfirmed = booking['user_confirmed_completion'] == true;
    final providerConfirmed = booking['provider_confirmed_completion'] == true;
    final payoutReleased = booking['payout_released'] == true;

    final provider = booking['service_provider'] as Map<String, dynamic>?;
    final user = booking['user'] as Map<String, dynamic>?;

    // Portfolio posts: prefer booking-level (best for "allowed-only" logic),
    // fallback to provider-level if that's how your API returns it.
    final rawPosts = booking['portfolio_posts'] ?? provider?['portfolio_posts'];
    final portfolioPosts = (rawPosts is List) ? rawPosts : <dynamic>[];

    final tipPaymentStatus = booking['tip_payment_status']?.toString() ?? 'unpaid';
    final tipAlreadyHandled = tipPaymentStatus == 'paid' || tipPaymentStatus == 'skipped';

    int? providerIdForReview;
    if (provider != null) {
      final rawId = provider['id'];
      if (rawId is int) {
        providerIdForReview = rawId;
      } else if (rawId != null) {
        providerIdForReview = int.tryParse(rawId.toString());
      }
    }

    final totalPaid = _parseAmount(booking['offered_price']) ?? _parseAmount(booking['estimated_price']) ?? 0.0;

    String userName = '';
    String providerFirstName = '';
    String providerName = '';

    if (provider != null) {
      final providerUser = provider['user'] as Map<String, dynamic>?;
      if (providerUser != null) {
        final first = providerUser['first_name']?.toString().trim() ?? '';
        final last = providerUser['last_name']?.toString().trim() ?? '';

        providerFirstName = first;

        final full = ('$first $last').trim();
        providerName = full.isNotEmpty ? full : (providerUser['username']?.toString() ?? '');
      }
    }

    if (user != null) {
      userName = user['username']?.toString() ?? '';
    }

    final lat = booking['location_latitude'];
    final lng = booking['location_longitude'];
    final latStr = lat?.toString() ?? '';
    final lngStr = lng?.toString() ?? '';
    final locationAddress = booking['location_address']?.toString() ?? '';

    String dateStr = '';
    String timeStr = '';
    if (appointmentTime.isNotEmpty) {
      final parts = appointmentTime.split('T');
      if (parts.length >= 2) {
        dateStr = parts[0];
        final tPart = parts[1].split('Z')[0];
        timeStr = tPart.length >= 5 ? tPart.substring(0, 5) : tPart;
      }
    }

    final canCancel = status != 'cancelled' && status != 'completed';
    final canConfirmCompletion =
        paymentStatus == 'paid' &&
        status != 'cancelled' &&
        (status == 'accepted' || status == 'in_progress');

    final alreadyConfirmedByMe =
        widget.role == 'user' ? userConfirmed : providerConfirmed;

    // Countdown (same behavior, but theme-aware colors)
    Widget? countdownWidget;
    final isUserRole = widget.role == 'user';
    final isAcceptedStatus = status == 'accepted' || status == 'in_progress';
    final showCountdown = isUserRole && isAcceptedStatus && _acceptedAt != null;

    if (showCountdown) {
      Color timerColor = const Color(0xFF22C55E); // green

      if (_acceptedAt != null) {
        final now = DateTime.now().toUtc();
        final elapsed = now.difference(_acceptedAt!);

        if (elapsed < const Duration(minutes: 7)) {
          timerColor = const Color(0xFF22C55E);
        } else if (elapsed < const Duration(minutes: 40)) {
          timerColor = const Color(0xFFB76E79); // rose-gold warning
        } else {
          timerColor = cs.error;
        }
      }

      if (_cancelDeadlineDiff != null && _cancelDeadlineDiff! > Duration.zero) {
        final totalSeconds = _cancelDeadlineDiff!.inSeconds;
        final minutes = totalSeconds ~/ 60;
        final seconds = totalSeconds % 60;
        final mm = minutes.toString().padLeft(2, '0');
        final ss = seconds.toString().padLeft(2, '0');

        countdownWidget = Text(
          l10n.freeCancellationEndsIn('$mm:$ss'),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: timerColor,
              ),
        );
      } else {
        countdownWidget = Text(
          l10n.earlyFreeCancellationEndedWarning,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 11,
                color: timerColor,
              ),
        );
      }
    }

    String cancelLabel = l10n.cancelBooking;
    Color cancelColor = cs.error;

    if (widget.role == 'user') {
      cancelLabel = l10n.cancelBookingNoPenalty;

      if (isAcceptedStatus && _acceptedAt != null) {
        final now = DateTime.now().toUtc();
        final earlyDeadline = _acceptedAt!.add(const Duration(minutes: 7));
        final lateDeadline = _acceptedAt!.add(const Duration(minutes: 40));

        final inEarlyFreeWindow = now.isBefore(earlyDeadline) || now.isAtSameMomentAs(earlyDeadline);
        final inLateFreeWindow = now.isAfter(lateDeadline) || now.isAtSameMomentAs(lateDeadline);

        cancelLabel = (inEarlyFreeWindow || inLateFreeWindow)
            ? l10n.cancelBookingNoPenalty
            : l10n.cancelBookingPenaltyMayApply;

        cancelColor = cs.error;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.bookingTitle(id)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Summary card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      serviceType.toUpperCase(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.6,
                          ),
                    ),
                    const SizedBox(height: 10),
                    _statusPill(context, status, paymentStatus),
                    if (widget.role == 'user' &&
                        (status == 'accepted' || status == 'in_progress') &&
                        providerName.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Text(
                        l10n.bookingAcceptedBy(
                          providerFirstName.isNotEmpty ? providerFirstName : providerName,
                        ),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ],
                    const SizedBox(height: 14),
                    // ✅ IMPROVED: Appointment time with timezone awareness
                    if (appointmentTime.isNotEmpty) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: DateTimeHelper.isToday(appointmentTime)
                              ? Colors.orange.withOpacity(0.1)
                              : (DateTimeHelper.isPast(appointmentTime) 
                                  ? Colors.grey.withOpacity(0.1) 
                                  : cs.primaryContainer.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: DateTimeHelper.isToday(appointmentTime)
                                ? Colors.orange
                                : (DateTimeHelper.isPast(appointmentTime) 
                                    ? Colors.grey 
                                    : cs.primary),
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              DateTimeHelper.isToday(appointmentTime) 
                                  ? Icons.today 
                                  : Icons.calendar_today,
                              color: DateTimeHelper.isToday(appointmentTime)
                                  ? Colors.orange
                                  : (DateTimeHelper.isPast(appointmentTime) 
                                      ? Colors.grey 
                                      : cs.primary),
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Service Appointment',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: cs.onSurfaceVariant,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    DateTimeHelper.formatAppointmentTime(appointmentTime),
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      color: DateTimeHelper.isToday(appointmentTime) 
                                          ? Colors.orange 
                                          : cs.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 12,
                                        color: cs.onSurfaceVariant.withOpacity(0.6),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Your local time (${DateTimeHelper.getTimezoneAbbreviation()})',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          fontSize: 10,
                                          color: cs.onSurfaceVariant.withOpacity(0.6),
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (DateTimeHelper.isToday(appointmentTime))
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Text(
                                          'TODAY',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                    ],
                    if (userName.isNotEmpty) _kv(context, l10n.userLabel, userName),
                    if (providerName.isNotEmpty) _kv(context, l10n.providerLabel, providerName),
                    _kv(context, l10n.estimatedPriceLabel, estimatedPrice),
                    if (offeredPrice != na) _kv(context, l10n.offeredPaidLabel, offeredPrice, strong: true),
                    if (_distanceMilesValue != null)
                      _kv(
                        context,
                        l10n.distanceLabel,
                        l10n.distanceMiles(_distanceMilesValue!.toStringAsFixed(1)),
                        strong: true,
                      ),
                    // ✅ PRIVACY: Hide full address after completion
                    if (locationAddress.isNotEmpty && status != 'completed')
                      _kv(
                        context,
                        'Location',
                        locationAddress,
                      )
                    else if (locationAddress.isNotEmpty && status == 'completed')
                      _kv(
                        context,
                        'Service Area',
                        _getGeneralArea(locationAddress),
                      ),
                    // ✅ METADATA: Show when booking was requested
                    if (_booking['created_at'] != null && _booking['created_at'].toString().isNotEmpty)
                      _kv(
                        context,
                        'Requested',
                        DateTimeHelper.formatMetadataTime(_booking['created_at'].toString()),
                      ),
                    
                    // ✅ METADATA: Accepted at
                    if (acceptedAt != null)
                      _kv(
                        context,
                        l10n.acceptedAtLabel,
                        DateTimeHelper.formatMetadataTime(acceptedAt),
                      ),

                    // ✅ METADATA: Cancelled at
                    if (cancelledAt != null)
                      _kv(
                        context,
                        l10n.cancelledAtLabel,
                        DateTimeHelper.formatMetadataTime(cancelledAt),
                      ),
                    if (cancelledBy != null) _kv(context, l10n.cancelledByLabel, cancelledBy),
                    if (penaltyApplied && penaltyAmount != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          l10n.penaltyAppliedLabel(penaltyAmount),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: cs.error,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                    _kv(context, l10n.userConfirmedLabel, userConfirmed ? l10n.yesLower : l10n.noLower),
                    _kv(context, l10n.providerConfirmedLabel, providerConfirmed ? l10n.yesLower : l10n.noLower),
                    _kv(context, l10n.payoutReleasedLabel, payoutReleased ? l10n.yesLower : l10n.noLower),
                    const SizedBox(height: 8),
                    // ✅ TIMEZONE EXPLANATION
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, size: 14, color: cs.primary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'All times shown in your local timezone (${DateTimeHelper.getTimezoneAbbreviation()})',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 11,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _openChat,
                            icon: const Icon(Icons.chat_bubble_outline),
                            label: Text(l10n.chat),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _calling ? null : _callCounterpart,
                            icon: _calling
                                ? const SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : const Icon(Icons.call),
                            label: Text(l10n.call),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ETA Card (show for requester when booking is accepted/in_progress)
            if (widget.role == 'user' &&
                (status == 'accepted' || status == 'in_progress') &&
                provider != null) ...[
              const SizedBox(height: 8),
              _buildEtaCard(context),
            ],

            // Enhanced job details and requester reputation for providers (after acceptance)
            if (widget.role == 'provider' &&
                (status == 'accepted' || status == 'in_progress' || status == 'completed')) ...[
              const SizedBox(height: 8),
              _buildEnhancedJobDetailsCard(context),
              const SizedBox(height: 8),
              _buildRequesterReputationCard(context),
            ],

            // Provider evaluation section (USER only, once accepted/in_progress)
            if (widget.role == 'user' &&
                (status == 'accepted' || status == 'in_progress') &&
                provider != null) ...[
              _providerHeaderCard(context, provider),
              _buildProviderReviewsCard(context),
              _portfolioGridCard(context, portfolioPosts),
            ],

            // Actions card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.actions,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    const SizedBox(height: 10),
                    if (canCancel)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _processingCancel ? null : _cancelBooking,
                          icon: _processingCancel
                              ? const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.cancel),
                          label: Text(cancelLabel),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: cancelColor,
                            foregroundColor: cs.onError,
                          ),
                        ),
                      ),
                    if (canCancel) const SizedBox(height: 10),
                    if (canConfirmCompletion)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: (_processingComplete || alreadyConfirmedByMe)
                              ? null
                              : _confirmCompletion,
                          icon: _processingComplete
                              ? const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.check_circle),
                          label: Text(
                            alreadyConfirmedByMe
                                ? 'Completion confirmed'
                                : l10n.confirmCompletion,
                          ),
                        ),
                      ),

                    // Review button (only shows if NOT already reviewed)
                    if (widget.role == 'user' &&
                        status == 'completed' &&
                        providerIdForReview != null &&
                        !_reviewSubmitted) ...[
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            final idRaw = booking['id'];
                            final bookingId = idRaw is int ? idRaw : int.tryParse(idRaw.toString());
                            if (bookingId == null) return;
                            _openReviewDialog(
                              providerIdForReview!,
                              providerName.isNotEmpty ? providerName : l10n.genericProvider,
                              bookingId,
                            );
                          },
                          icon: const Icon(Icons.star_rate),
                          label: Text(l10n.rateThisService),
                        ),
                      ),
                    ],
                    // Show "Already Reviewed" indicator if review was submitted
                    if (widget.role == 'user' &&
                        status == 'completed' &&
                        providerIdForReview != null &&
                        _reviewSubmitted) ...[
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              l10n.reviewAlreadySubmitted,
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    // NEW: Provider reviews requester
                    if (widget.role == 'provider' &&
                        status == 'completed' &&
                        !_requesterReviewSubmitted &&
                        !_checkingRequesterReview) ...[
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: _openRequesterReviewDialog,
                        icon: const Icon(Icons.rate_review),
                        label: const Text('Rate Customer'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black87,
                        ),
                      ),
                    ],
                    
                    // Show if already reviewed
                    if (widget.role == 'provider' &&
                        status == 'completed' &&
                        _requesterReviewSubmitted) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green.shade200),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle, color: Colors.green.shade700, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'Customer reviewed',
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    
                    // Loading state
                    if (widget.role == 'provider' &&
                        status == 'completed' &&
                        _checkingRequesterReview) ...[
                      const SizedBox(height: 12),
                      const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ],


                    // Tip button - ALWAYS shows for completed bookings (separate from review)
                    if (widget.role == 'user' &&
                        status == 'completed' &&
                        providerIdForReview != null) ...[
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: (tipAlreadyHandled || _processingTip || totalPaid <= 0)
                              ? null
                              : () {
                                  final idRaw = booking['id'];
                                  final requestId = idRaw is int ? idRaw : int.tryParse(idRaw.toString());
                                  if (requestId == null) return;
                                  _tipProvider(requestId: requestId, totalPaid: totalPaid);
                                },
                          icon: _processingTip
                              ? const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.volunteer_activism),
                          label: Text(
                            tipPaymentStatus == 'paid'
                                ? l10n.tipAlreadyPaidLabel
                                : (tipPaymentStatus == 'skipped' ? l10n.tipSkippedLabel : l10n.tipLeaveButton),
                          ),
                        ),
                      ),
                    ],
                   

                    if (!canCancel && !canConfirmCompletion)
                      Text(
                        l10n.noFurtherActionsForBooking,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: cs.onSurfaceVariant,
                            ),
                      ),
                    const SizedBox(height: 10),
                    if (countdownWidget != null) countdownWidget,
                    if (widget.role == 'user' && countdownWidget == null)
                      Text(
                        l10n.cancellationPolicyInfo,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 11,
                              color: cs.onSurfaceVariant,
                            ),
                      ),
                  ],
                ),
              ),
            ),

            // ✅ PRIVACY: Location card with completion protection
            if (latStr.isNotEmpty && lngStr.isNotEmpty)
              _buildLocationCard(context, latStr, lngStr, locationAddress, status),
          ],
        ),
      ),
    );
  }
}


// Separate stateful widget for review dialog to avoid framework issues
class _ReviewDialog extends StatefulWidget {
  final String providerName;
  final int initialRating;
  final Future<bool> Function(int rating, String comment) onSubmit;

  const _ReviewDialog({
    required this.providerName,
    required this.initialRating,
    required this.onSubmit,
  });

  @override
  State<_ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<_ReviewDialog> {
  late int _selectedRating;
  late TextEditingController _commentController;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _selectedRating = widget.initialRating;
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
      Navigator.of(context).pop({'success': true});
    } else {
      setState(() => _submitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit review. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return AlertDialog(
      scrollable: true,
      title: Text(l10n.rateProviderTitle(widget.providerName)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.reviewSelectRatingPrompt),
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
              labelText: l10n.reviewCommentOptionalLabel,
              hintText: 'Share your experience...',
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _submitting ? null : () => Navigator.of(context).pop(null),
          child: Text(l10n.genericCancel),
        ),
        ElevatedButton(
          onPressed: _submitting ? null : _handleSubmit,
          child: _submitting
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(l10n.genericSubmit),
        ),
      ],
    );
  }
}
// =====================
// REQUESTER REVIEW DIALOG (Provider rates Customer)
// =====================
 
class _RequesterReviewDialog extends StatefulWidget {
  final String requesterName;
  final Future<bool> Function(int rating, String comment) onSubmit;

  const _RequesterReviewDialog({
    required this.requesterName,
    required this.onSubmit,
  });
 
  @override
  State<_RequesterReviewDialog> createState() => _RequesterReviewDialogState();
}

class _RequesterReviewDialogState extends State<_RequesterReviewDialog> {
  int _rating = 5;
  final _commentController = TextEditingController();
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _submitting = true;
      _error = null;
    });

    try {
      final success = await widget.onSubmit(_rating, _commentController.text.trim());
      if (!mounted) return;

      if (success) {
        Navigator.of(context).pop({'success': true});
      } else {
        setState(() {
          _error = 'Failed to submit review. Please try again.';
          _submitting = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Error: $e';
        _submitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.rate_review, color: Colors.amber),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Rate ${widget.requesterName}',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How was your experience with this customer?',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
            // Star rating
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  final starNumber = index + 1;
                  return IconButton(
                    icon: Icon(
                      starNumber <= _rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 36,
                    ),
                    onPressed: _submitting
                        ? null
                        : () => setState(() => _rating = starNumber),
                  );
                }),
              ),
            ),
             
            // Rating label
            Center(
              child: Text(
                _getRatingLabel(_rating),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: _getRatingColor(_rating),
                ),
              ),
            ),
             
            const SizedBox(height: 16),
             
            // Comment field
            TextField(
              controller: _commentController,
              maxLines: 3,
              maxLength: 500,
              enabled: !_submitting,
              decoration: const InputDecoration(
                labelText: 'Comment (optional)',
                hintText: 'Share your experience with this customer...',
                border: OutlineInputBorder(),
              ),
            ),
             
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(
                _error!,
                style: const TextStyle(color: Colors.red, fontSize: 13),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _submitting ? null : () => Navigator.of(context).pop(null),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitting ? null : _submit,
          child: _submitting
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Submit'),
        ),
      ],
    );
  }
 
  String _getRatingLabel(int rating) {
    switch (rating) {
      case 1:
        return 'Poor';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Very Good';
      case 5:
        return 'Excellent';
      default:
        return '';
    }
  }
 
  Color _getRatingColor(int rating) {
    switch (rating) {
       case 1:
         return Colors.red;
       case 2:
         return Colors.orange;
       case 3:
         return Colors.amber;
       case 4:
         return Colors.lightGreen;
       case 5:
         return Colors.green;
       default:
         return Colors.grey;
      }
    }
  }
