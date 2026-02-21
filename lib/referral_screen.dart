// lib/referral_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';

import 'api_client.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  Map<String, dynamic>? _stats;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final stats = await ApiClient.getReferralStats();

      if (!mounted) return;

      setState(() {
        _stats = stats;
        _loading = false;
        if (stats == null) {
          _error = AppLocalizations.of(context).referralLoadFailed;
        }
      });
    } catch (e) {
      if (!mounted) return;
      print('!!!! REFERRAL SCREEN ERROR: Failed to load referral stats: $e');
      setState(() {
        _loading = false;
        _error = AppLocalizations.of(context).referralLoadFailed;
        _stats = null; // Ensure stats is cleared on error
      });
    }
  }

  Future<void> _copyCode() async {
    final code = _stats?['referral_code']?.toString() ?? '';
    if (code.isEmpty) return;

    await Clipboard.setData(ClipboardData(text: code));
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context).referralCodeCopiedSnackbar(code)),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _shareCode() async {
    final code = _stats?['referral_code']?.toString() ?? '';
    if (code.isEmpty) return;

    final discountPercent = int.tryParse(_stats?['discount_percent']?.toString() ?? '') ?? 7;
    final creditsPerReferral = int.tryParse(_stats?['credits_per_referral']?.toString() ?? '') ?? 5;
    final l10n = AppLocalizations.of(context);

    final shareText = l10n.referralShareText(code, creditsPerReferral, discountPercent);

    await Share.share(shareText, subject: l10n.referralShareSubject);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.referFriendsTitle)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null || _stats == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.referFriendsTitle)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: cs.error),
              const SizedBox(height: 16),
              Text(_error ?? l10n.somethingWentWrong),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadStats,
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
      );
    }

    final code = _stats!['referral_code']?.toString() ?? '';
    final credits = int.tryParse(_stats!['referral_credits']?.toString() ?? '') ?? 0;
    final totalReferrals = int.tryParse(_stats!['total_referrals']?.toString() ?? '') ?? 0;
    final totalEarned = int.tryParse(_stats!['total_credits_earned']?.toString() ?? '') ?? 0;
    final totalUsed = int.tryParse(_stats!['total_credits_used']?.toString() ?? '') ?? 0;
    final discountPercent = int.tryParse(_stats!['discount_percent']?.toString() ?? '') ?? 7;
    final creditsPerReferral = int.tryParse(_stats!['credits_per_referral']?.toString() ?? '') ?? 5;
    final pendingReferrals = int.tryParse(_stats!['pending_referrals']?.toString() ?? '') ?? 0;
    final referralRaw = _stats!['referrals'];
    final referrals = (referralRaw is List) ? referralRaw : [];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.referFriendsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadStats,
            tooltip: l10n.refresh,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadStats,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hero Card - Referral Code
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        cs.primaryContainer,
                        cs.secondaryContainer,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.card_giftcard,
                        size: 48,
                        color: cs.primary,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.referralYourCode,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: cs.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.black26 : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: cs.primary, width: 2),
                        ),
                        child: Text(
                          code,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            letterSpacing: 3,
                            color: cs.primary,
                            fontFamily: 'monospace', // Monospace for code readability
                            fontSize: code.length > 16 ? 18 : null, // Shrink for legacy codes
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: _copyCode,
                            icon: const Icon(Icons.copy, size: 18),
                            label: Text(l10n.copy),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black87,
                              elevation: 2,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton.icon(
                            onPressed: _shareCode,
                            icon: const Icon(Icons.share, size: 18),
                            label: Text(l10n.shareLabel),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black87,
                              foregroundColor: Colors.white,
                              elevation: 2,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // How it Works Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: cs.primary),
                          const SizedBox(width: 8),
                          Text(
                            l10n.howItWorks,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      _buildStep(context, '1', l10n.referralStep1Share),
                      _buildStep(context, '2', l10n.referralStep2SignUp),
                      _buildStep(context, '3', l10n.referralStep3Booking),
                      _buildStep(
                        context,
                        '🎉',
                        l10n.referralStepReward(creditsPerReferral, discountPercent),
                        isHighlight: true,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Stats Grid
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      context,
                      '$credits',
                      l10n.creditsAvailable,
                      Icons.confirmation_number,
                      Colors.green,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      '$totalReferrals',
                      l10n.successfulReferrals,
                      Icons.people,
                      Colors.blue,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      context,
                      '$totalEarned',
                      l10n.totalEarned,
                      Icons.emoji_events,
                      Colors.amber,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      '$totalUsed',
                      l10n.creditsUsed,
                      Icons.check_circle,
                      Colors.purple,
                    ),
                  ),
                ],
              ),

              if (pendingReferrals > 0) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.hourglass_empty, color: Colors.orange.shade700),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l10n.referralPendingFriendsMessage(pendingReferrals),
                          style: TextStyle(color: Colors.orange.shade700),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Referral History
              if (referrals.isNotEmpty) ...[
                const SizedBox(height: 24),
                Text(
                  l10n.referralHistory,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: referrals.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final rawRef = referrals[index];
                      if (rawRef is! Map<String, dynamic>) {
                        return const SizedBox.shrink();
                      }
                      final ref = rawRef;
                      final name = ref['referred_first_name']?.toString() ??
                          ref['referred_username']?.toString() ??
                          l10n.userFallbackName;
                      final status = ref['status']?.toString() ?? 'pending';
                      final createdAt = ref['created_at']?.toString() ?? '';

                      IconData statusIcon;
                      Color statusColor;
                      String statusText;

                      switch (status) {
                        case 'qualified':
                          statusIcon = Icons.check_circle;
                          statusColor = Colors.green;
                          statusText = l10n.referralStatusCompleted;
                          break;
                        case 'expired':
                          statusIcon = Icons.cancel;
                          statusColor = Colors.grey;
                          statusText = l10n.referralStatusExpired;
                          break;
                        default:
                          statusIcon = Icons.hourglass_empty;
                          statusColor = Colors.orange;
                          statusText = l10n.referralStatusPending;
                      }

                      // Format date
                      String dateText = '';
                      try {
                        final dt = DateTime.parse(createdAt);
                        dateText = '${dt.day}/${dt.month}/${dt.year}';
                      } catch (_) {}

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: statusColor.withValues(alpha: 0.1),
                          child: Text(
                            name.isNotEmpty ? name[0].toUpperCase() : '?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                        title: Text(
                          name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          dateText.isNotEmpty
                              ? l10n.referralJoinedDate(dateText)
                              : l10n.referralJoinedRecently,
                          style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(statusIcon, size: 14, color: statusColor),
                              const SizedBox(width: 4),
                              Text(
                                statusText,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],

              // Empty state for no referrals
              if (referrals.isEmpty) ...[
                const SizedBox(height: 32),
                Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 64,
                        color: cs.onSurfaceVariant.withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.noReferralsYet,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.shareCodeForDiscounts,
                        style: TextStyle(
                          color: cs.onSurfaceVariant.withValues(alpha: 0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context, String number, String text,
      {bool isHighlight = false}) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: isHighlight ? Colors.green : cs.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isHighlight ? Colors.white : cs.onPrimaryContainer,
                  fontSize: number.length > 1 ? 12 : 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
                color: isHighlight ? Colors.green.shade700 : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: cs.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}