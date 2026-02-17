// lib/open_jobs_screen.dart - Updated with currency formatting

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';

import 'api_client.dart';
import 'currency_helper.dart';
import 'utils/datetime_helper.dart';

class OpenJobsScreen extends StatefulWidget {
  const OpenJobsScreen({super.key});

  @override
  State<OpenJobsScreen> createState() => _OpenJobsScreenState();
}

class _OpenJobsScreenState extends State<OpenJobsScreen> {
  bool _loading = true;
  String? _error;
  List<dynamic>? _jobs;
  String? _userCountry; // Store user's country
  String? _userCurrencySymbol; // Store currency symbol
  bool _providerUnavailable = false;
  String? _unavailableMessage;

  // NEW: Provider tier info
  String? _providerTier;
  int? _providerTrustScore;
  List<String>? _eligibleTiers;
  String? _selectedTierFilter; // For optional UI filtering

  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _loadUserCountryAndJobs();

    // Optional: refresh every 10 seconds (comment out if you don't want auto refresh)
    _refreshTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      if (mounted) _loadUserCountryAndJobs();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadUserCountryAndJobs() async {
    setState(() {
      _loading = true;
      _error = null;
      _providerUnavailable = false;
      _unavailableMessage = null;
    });

    Position? pos;

    try {
      pos = await Geolocator.getCurrentPosition();
    } catch (_) {}
    if (pos != null) {
      // Optional: ApiClient.updateLocation for provider
    }

    try {
      // First, get user data to know their country
      final userData = await ApiClient.getCurrentUser();
      if (userData != null && userData['country_name'] != null) {
        _userCountry = userData['country_name'] as String;
        _userCurrencySymbol = CurrencyHelper.getCurrencySymbol(_userCountry!);
      } else {
        // Default to Ghana if not set
        _userCountry = 'Ghana';
        _userCurrencySymbol = 'GH₵';
      }

      // Then load jobs
      final data = await ApiClient.getOpenJobs();

      setState(() {
        _loading = false;
        if (data == null) {

          _error = AppLocalizations.of(context).failedToLoadOpenJobsHint;
        } else {
          // NEW: Handle structured response with tier info
          _jobs = data['jobs'] as List<dynamic>? ?? [];
          _providerTier = data['provider_tier'] as String?;
          _providerTrustScore = data['provider_trust_score'] as int?;
          _eligibleTiers = (data['eligible_tiers'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList();
        }

      });
    } catch (e) {

      // Check if error is due to provider being unavailable
      final errorStr = e.toString();
      if (errorStr.contains('provider_unavailable') || errorStr.contains('unavailable for bookings')) {
        setState(() {
          _loading = false;
          _providerUnavailable = true;
          _unavailableMessage = 'To view and accept open jobs, please enable "Available for Bookings" in your Provider Profile settings.';
        });
        return;
      }

      setState(() {
        _loading = false;
        _error = AppLocalizations.of(context).errorLoadingJobsWithValue(e.toString());
      });
    }
  }

  /// Format a price that is ALREADY in the user's currency.
  /// Do NOT use this for raw offered_price from other currencies.
  String _formatPrice(dynamic price) {
    if (price == null || price == 'N/A') return 'N/A';
    
    try {
      final priceNum = double.tryParse(price.toString());
      if (priceNum == null) return price.toString();
      
      // Use the currency helper to format the price
      return CurrencyHelper.formatAmount(priceNum, _userCountry ?? 'Ghana');
    } catch (e) {
      return price.toString();
    }
  }

  // NEW: Get tier display info
  Map<String, dynamic> _getTierInfo(String? tier) {
    switch (tier?.toLowerCase()) {
      case 'premium':
        return {
          'color': const Color(0xFFA855F7), // Purple
          'bgColor': const Color(0xFFF3E8FF),
          'icon': Icons.workspace_premium,
          'badge': '💜 Premium',
          'title': 'Certified Expert',
        };
      case 'standard':
        return {
          'color': const Color(0xFF3B82F6), // Blue
          'bgColor': const Color(0xFFDBEAFE),
          'icon': Icons.verified_user,
          'badge': '💙 Standard',
          'title': 'Verified Pro',
        };
      case 'budget':
      default:
        return {
          'color': const Color(0xFF22C55E), // Green
          'bgColor': const Color(0xFFDCFCE7),
          'icon': Icons.eco,
          'badge': '💚 Budget',
          'title': 'New & Eager',
        };
    }
  }

  // NEW: Build provider tier status card
  Widget _buildProviderTierCard() {
    if (_providerTier == null) return const SizedBox.shrink();
    
    final tierInfo = _getTierInfo(_providerTier);
    final l10n = AppLocalizations.of(context);
    
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            (tierInfo['color'] as Color).withOpacity(0.1),
            (tierInfo['color'] as Color).withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: (tierInfo['color'] as Color).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: tierInfo['bgColor'] as Color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  tierInfo['icon'] as IconData,
                  color: tierInfo['color'] as Color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Tier: ${tierInfo['title']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: tierInfo['color'] as Color,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Trust Score: ${_providerTrustScore ?? 0}/100',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              // Trust score progress indicator
              SizedBox(
                width: 50,
                height: 50,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: (_providerTrustScore ?? 0) / 100,
                      backgroundColor: Colors.grey.shade200,
                      color: tierInfo['color'] as Color,
                      strokeWidth: 5,
                    ),
                    Text(
                      '${_providerTrustScore ?? 0}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: tierInfo['color'] as Color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Eligible tiers chips
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              Text(
                'You can accept:',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              ...(_eligibleTiers ?? ['budget']).map((tier) {
                final info = _getTierInfo(tier);
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: info['bgColor'] as Color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    info['badge'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: info['color'] as Color,
                    ),
                  ),
                );
              }),
            ],
          ),
          // Upgrade hint for non-premium providers
          if (_providerTier != 'premium') ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 18,
                    color: Colors.amber.shade700,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _getUpgradeHint(),
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.amber.shade900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // NEW: Get upgrade hint based on current tier
  String _getUpgradeHint() {
    if (_providerTier == 'budget') {
      return 'Complete your bio, add portfolio photos, and upload certifications to unlock Standard & Premium jobs!';
    } else if (_providerTier == 'standard') {
      return 'Add more portfolio items and certifications to unlock Premium jobs with higher earnings!';
    }
    return '';
  }

  // NEW: Build tier filter chips (optional UI)
  Widget _buildTierFilterChips() {
    if (_eligibleTiers == null || _eligibleTiers!.isEmpty) {
      return const SizedBox.shrink();
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const Text(
              'Filter: ',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            // "All" chip
            _buildFilterChip(null, 'All'),
            const SizedBox(width: 8),
            // Tier chips
            ..._eligibleTiers!.map((tier) {
              final info = _getTierInfo(tier);
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _buildFilterChip(tier, info['badge'] as String),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String? tier, String label) {
    final isSelected = _selectedTierFilter == tier;
    final tierInfo = tier != null ? _getTierInfo(tier) : null;
    
    return FilterChip(
      selected: isSelected,
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: isSelected 
              ? Colors.white 
              : (tierInfo?['color'] as Color?) ?? Colors.grey.shade700,
        ),
      ),
      backgroundColor: tierInfo != null 
          ? (tierInfo['bgColor'] as Color) 
          : Colors.grey.shade100,
      selectedColor: tierInfo != null 
          ? (tierInfo['color'] as Color) 
          : Colors.grey.shade700,
      onSelected: (selected) {
        setState(() {
          _selectedTierFilter = selected ? tier : null;
        });
      },
      checkmarkColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }

  // NEW: Get filtered jobs based on selected tier filter
  List<dynamic> _getFilteredJobs() {
    if (_jobs == null) return [];
    if (_selectedTierFilter == null) return _jobs!;
    
    return _jobs!.where((job) {
      final jobTier = (job as Map<String, dynamic>)['selected_tier']?.toString().toLowerCase();
      return jobTier == _selectedTierFilter?.toLowerCase();
    }).toList();
  }

  // NEW: Build job tier badge
  Widget _buildJobTierBadge(String? tier) {
    final info = _getTierInfo(tier);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: info['bgColor'] as Color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: (info['color'] as Color).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            info['icon'] as IconData,
            size: 14,
            color: info['color'] as Color,
          ),
          const SizedBox(width: 4),
          Text(
            (info['badge'] as String).replaceAll(RegExp(r'[💚💙💜] '), ''),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: info['color'] as Color,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _acceptJob(int id) async {
    final result = await ApiClient.acceptJob(id);
    if (!mounted) return;

    if (result['success'] != true) {
      // Check for tier mismatch error
      if (result['error_code'] == 'tier_mismatch') {
        _showTierMismatchDialog(result);
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['detail']?.toString() ?? AppLocalizations.of(context).failedToAcceptJob),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context).jobAcceptedSuccessfully),
        backgroundColor: Colors.green,
      ),
    );

    // Reload list, this job should disappear since it's now assigned
    _loadUserCountryAndJobs();
  }

  void _showTierMismatchDialog(Map<String, dynamic> result) {
   final yourTier = result['your_tier']?.toString() ?? 'budget';
   final requiredTier = result['required_tier']?.toString() ?? 'premium';
   final howToUpgrade = result['how_to_upgrade']?.toString() ?? '';
   
   final yourTierInfo = _getTierInfo(yourTier);
   final requiredTierInfo = _getTierInfo(requiredTier);
   
   showDialog(
     context: context,
     builder: (context) => AlertDialog(
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
       title: Row(
         children: [
           Icon(Icons.lock, color: Colors.orange.shade700),
           const SizedBox(width: 8),
           const Text('Tier Required'),
         ],
       ),
       content: Column(
         mainAxisSize: MainAxisSize.min,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(
             'This is a ${requiredTierInfo['title']} job.',
             style: const TextStyle(fontWeight: FontWeight.bold),
           ),
           const SizedBox(height: 12),
           Row(
             children: [
               const Text('Your tier: '),
               Container(
                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                 decoration: BoxDecoration(
                   color: yourTierInfo['bgColor'] as Color,
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: Text(
                   yourTierInfo['badge'] as String,
                   style: TextStyle(
                     fontSize: 12,
                     fontWeight: FontWeight.w600,
                     color: yourTierInfo['color'] as Color,
                   ),
                 ),
               ),
             ],
           ),
           const SizedBox(height: 8),
           Row(
             children: [
               const Text('Required: '),
               Container(
                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                 decoration: BoxDecoration(
                   color: requiredTierInfo['bgColor'] as Color,
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: Text(
                   requiredTierInfo['badge'] as String,
                   style: TextStyle(
                     fontSize: 12,
                     fontWeight: FontWeight.w600,
                     color: requiredTierInfo['color'] as Color,
                   ),
                 ),
               ),
             ],
           ),
           if (howToUpgrade.isNotEmpty) ...[
             const SizedBox(height: 16),
             Container(
               padding: const EdgeInsets.all(12),
               decoration: BoxDecoration(
                 color: Colors.blue.shade50,
                 borderRadius: BorderRadius.circular(8),
               ),
               child: Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Icon(Icons.lightbulb, size: 20, color: Colors.blue.shade700),
                   const SizedBox(width: 8),
                   Expanded(
                     child: Text(
                       howToUpgrade,
                       style: TextStyle(fontSize: 13, color: Colors.blue.shade900),
                     ),
                   ),
                 ],
               ),
             ),
           ],
         ],
       ),
       actions: [
         TextButton(
           onPressed: () => Navigator.pop(context),
           child: const Text('OK'),
         ),
         ElevatedButton(
           onPressed: () {
             Navigator.pop(context);
             // Navigate to profile to improve tier
             Navigator.pushNamed(context, '/provider-profile');
           },
           child: const Text('Improve Profile'),
         ),
       ],
     ),
   );
 }

Widget _buildUnavailablePrompt() {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.visibility_off,
                    size: 48,
                    color: Colors.orange.shade700,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.youAreCurrentlyUnavailable,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.toBrowseAndAcceptJobsEnableAvailability,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Navigate to profile settings
                    },
                    icon: const Icon(Icons.settings),
                    label: Text(l10n.goToProfileSettings),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        size: 20,
                        color: Colors.blue.shade700,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          l10n.tipToggleAvailableForBookings,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final filteredJobs = _getFilteredJobs();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.nearbyOpenJobsTitle),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _providerUnavailable
              ? _buildUnavailablePrompt()
              : _error != null
              ? Center(child: Text(_error!))
              : _jobs == null || _jobs!.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.work_outline, size: 64, color: Colors.grey),
                          const SizedBox(height: 16),
                          Text(
                            l10n.noOpenJobsFoundNearbyTitle,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.noOpenJobsFoundNearbyBody,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          // Still show tier card even when no jobs
                          _buildProviderTierCard(),

                          if (_userCurrencySymbol != null)
                            Text(
                              'Your currency: $_userCurrencySymbol',
                              style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                            ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        // Provider tier status card
                        _buildProviderTierCard(),
                        
                        // Tier filter chips
                        _buildTierFilterChips(),

                        // Currency indicator
                        if (_userCurrencySymbol != null && _userCountry != null)
                          Container(
                            padding: const EdgeInsets.all(12),
                            color: Colors.blue[50],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.currency_exchange, size: 16, color: Colors.blue.shade700),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    'All prices shown in your currency ($_userCurrencySymbol)',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue.shade700,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: _loadUserCountryAndJobs,
                            child: filteredJobs.isEmpty
                                ? ListView(
                                    children: [
                                      const SizedBox(height: 60),
                                      Center(
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.filter_list_off,
                                              size: 48,
                                              color: Colors.grey.shade400,
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              'No ${_selectedTierFilter ?? ""} jobs available',
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  _selectedTierFilter = null;
                                                });
                                              },
                                              child: const Text('Clear filter'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : ListView.builder(
                                    padding: const EdgeInsets.all(8.0),
                                    itemCount: filteredJobs.length,
                              itemBuilder: (context, index) {
                                final job = filteredJobs[index] as Map<String, dynamic>;
                                final id = job['id'] as int?;
                                final serviceType =
                                    job['service_type']?.toString() ?? 'N/A';
                                final appointmentTime =
                                    job['appointment_time']?.toString() ?? '';
                                // ═══════════════════════════════════════
                                // CURRENCY-AWARE PRICE: Use converted_price
                                // (backend converts to provider's currency)
                                // Provider ONLY sees their own currency.
                                // ═══════════════════════════════════════
                                final convertedPrice =
                                    job['converted_price']?.toString() ??
                                        job['converted_estimated_price']?.toString();
                                final rawPrice =
                                    job['offered_price']?.toString() ??
                                        job['estimated_price']?.toString() ??
                                        'N/A';
                                final viewerSymbol =
                                    job['currency_symbol']?.toString() ??
                                        _userCurrencySymbol ?? '';

                                // Always show in provider's own currency
                                String priceDisplay;
                                if (convertedPrice != null) {
                                  final num = double.tryParse(convertedPrice);
                                  priceDisplay = num != null
                                      ? '$viewerSymbol${num.toStringAsFixed(2)}'
                                      : '$viewerSymbol$convertedPrice';
                                } else if (rawPrice != 'N/A') {
                                  priceDisplay = '$viewerSymbol$rawPrice';
                                } else {
                                  priceDisplay = 'N/A';
                                }
                                // ═══════════════════════════════════════

                                // Get job tier
                                final jobTier = job['selected_tier']?.toString();
                                
                                // Get distance if available
                                final distance = job['distance_miles'] != null
                                    ? double.tryParse(job['distance_miles'].toString())?.toStringAsFixed(1)
                                    : null;

                                // Get requester info
                                final requesterName = job['requester_first_name']?.toString() ?? '';
                                final requesterAddress = job['requester_address']?.toString() ?? '';

                                // ✅ IMPROVED: Use DateTimeHelper for timezone-aware display
                                final dateStr = DateTimeHelper.formatDateOnly(appointmentTime);
                                final timeStr = DateTimeHelper.formatTimeOnly(appointmentTime);
                                final isToday = DateTimeHelper.isToday(appointmentTime);

                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 6,
                                    horizontal: 4,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                      color: (_getTierInfo(jobTier)['color'] as Color).withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Fixed Row structure
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    l10n.jobTitleWithId((id ?? 'N/A').toString()),
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  // Job tier badge
                                                  _buildJobTierBadge(jobTier),
                                                ],
                                              ),
                                            ),
                                            if (distance != null)
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue[100],
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Text(
                                                  l10n.distanceMiles(distance),
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          l10n.serviceLine(serviceType.replaceAll('_', ' ').toUpperCase()),
                                        ),

                                        if (requesterName.isNotEmpty)
                                          Text(
                                            l10n.requestedBy(requesterName),
                                            style: const TextStyle(fontWeight: FontWeight.w500),
                                          ),
                                        // Requester rating (from providers' reviews)
                                        if (job['requester_average_rating'] != null) ...[
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              const Icon(Icons.star, size: 14, color: Colors.amber),
                                              const SizedBox(width: 4),
                                              Text(
                                                '${(job['requester_average_rating'] as num).toStringAsFixed(1)} rating',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey.shade600,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              if (job['requester_review_count'] != null) ...[
                                                Text(
                                                  ' (${job['requester_review_count']} reviews)',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey.shade500,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ] else ...[
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(Icons.star_border, size: 14, color: Colors.grey.shade400),
                                              const SizedBox(width: 4),
                                              Text(
                                                'New customer',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey.shade500,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],

                                        if (requesterAddress.isNotEmpty)
                                          Text(
                                            l10n.locationLabel(requesterAddress),
                                            style: const TextStyle(color: Colors.grey),
                                          ),
                                        // Customer notes (if any)
                                        if ((job['notes'] ?? '').toString().trim().isNotEmpty) ...[
                                          const SizedBox(height: 8),
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.amber.shade50,
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(
                                                color: Colors.amber.shade200,
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.note_alt_outlined,
                                                  size: 16,
                                                  color: Colors.amber.shade800,
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Customer Note',
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.w700,
                                                          color: Colors.amber.shade900,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Text(
                                                        job['notes'].toString().trim(),
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.amber.shade900,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],

                                        // ✅ IMPROVED: Better time display with TODAY indicator
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
                                                    ? (isToday 
                                                        ? 'Today at $timeStr' 
                                                        : '$dateStr at $timeStr')
                                                    : dateStr,
                                                style: TextStyle(
                                                  fontWeight: isToday ? FontWeight.w600 : FontWeight.normal,
                                                  color: isToday ? Colors.orange : null,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                        Text(
                                          l10n.priceLine(priceDisplay),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: ElevatedButton(
                                            onPressed: id == null
                                                ? null
                                                : () => _acceptJob(id),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(Icons.check_circle),
                                                const SizedBox(width: 8),
                                                Text(l10n.acceptJob),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
    );
  }
}