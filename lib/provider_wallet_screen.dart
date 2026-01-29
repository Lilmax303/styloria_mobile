// lib/provider_wallet_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'api_client.dart';
import 'provider_payout_settings_screen.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';
import 'utils/datetime_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'africa_countries.dart';

class ProviderWalletScreen extends StatefulWidget {
  const ProviderWalletScreen({super.key});

  @override
  State<ProviderWalletScreen> createState() => _ProviderWalletScreenState();
}

class _ProviderWalletScreenState extends State<ProviderWalletScreen> {
  bool _loading = true;
  List<dynamic> _wallets = [];
  List<dynamic> _transactions = [];
  String? _selectedCurrency;
  bool _txLoading = false;
  Map<String, dynamic>? _stripeStatus;
  bool _stripeLoading = false;
  bool _stripeCompleteNotified = false;
  bool _isAfricaProvider = false;
  bool _isPaystackProvider = false;

  // Instant cashout state
  final _cashoutAmountCtrl = TextEditingController();
  Map<String, dynamic>? _instantCashoutInfo;
  bool _cashoutLoading = false;

  @override
  void initState() {
    super.initState();
    _loadWallets();
    _loadStripeStatus();
    _loadRegion();
    _loadInstantCashoutInfo();
  }

  @override
  void dispose() {
    _cashoutAmountCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadRegion() async {
    final me = await ApiClient.getCurrentUser();
    if (!mounted) return;
    final country = me?['country_name']?.toString();
    setState(() => _isAfricaProvider = isAfricanCountryName(country));
    setState(() => _isPaystackProvider = ApiClient.isPaystackCountry(country));
  }

  Future<void> _loadInstantCashoutInfo() async {
    final info = await ApiClient.getInstantCashoutInfo();
    if (!mounted) return;
    setState(() => _instantCashoutInfo = info);
  }

  Future<void> _loadStripeStatus() async {
    setState(() => _stripeLoading = true);
    final s = await ApiClient.getProviderStripeStatus();
    if (!mounted) return;
    final wasEnabled = (_stripeStatus?['payouts_enabled'] == true);
    setState(() {
      _stripeStatus = s;
      _stripeLoading = false;
    });
    final nowEnabled = (_stripeStatus?['payouts_enabled'] == true);
    if (!wasEnabled && nowEnabled && !_stripeCompleteNotified) {
      _stripeCompleteNotified = true;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Stripe setup is complete.')),
      );
    }
  }

  Future<void> _openStripeOnboarding() async {
    final l10n = AppLocalizations.of(context);
    setState(() => _stripeLoading = true);
    final res = await ApiClient.createProviderStripeAccountLink();
    if (!mounted) return;
    setState(() => _stripeLoading = false);

    final url = (res?['url'] ?? '').toString();
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.walletCashOutFailed)),
      );
      return;
    }

    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _openStripeDashboard() async {
    setState(() => _stripeLoading = true);
    final res = await ApiClient.createProviderStripeLoginLink();
    if (!mounted) return;
    setState(() => _stripeLoading = false);

    final url = (res?['url'] ?? '').toString();
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _loadWallets() async {
    setState(() => _loading = true);
    final wallets = await ApiClient.getProviderWalletSummary();
    if (!mounted) return;

    _wallets = wallets ?? [];
    _selectedCurrency = _wallets.isNotEmpty ? (_wallets.first['currency']?.toString()) : null;
    setState(() => _loading = false);

    if (_selectedCurrency != null) {
      await _loadTransactions(_selectedCurrency!);
      _updateCashoutAmountHint();
    }
  }

  Future<void> _loadTransactions(String currency) async {
    setState(() => _txLoading = true);
    final tx = await ApiClient.getProviderWalletTransactions(currency: currency);
    if (!mounted) return;
    setState(() {
      _transactions = tx ?? [];
      _txLoading = false;
    });
  }

  void _updateCashoutAmountHint() {
    // Pre-fill with max available if empty
    if (_cashoutAmountCtrl.text.isEmpty && _selectedCurrency != null) {
      final wallet = _getSelectedWallet();
      if (wallet != null) {
        final available = double.tryParse(wallet['available_balance']?.toString() ?? '0') ?? 0;
        if (available > 0) {
          _cashoutAmountCtrl.text = available.toStringAsFixed(2);
        }
      }
    }
  }

  Map<String, dynamic>? _getSelectedWallet() {
    if (_selectedCurrency == null) return null;
    return _wallets.firstWhere(
      (x) => (x['currency']?.toString() ?? '') == _selectedCurrency,
      orElse: () => null,
    );
  }

  Map<String, dynamic> _getButtonState() {
    final wallet = _getSelectedWallet();
    if (wallet == null) {
      return {
        'enabled': false,
        'reason': 'no_wallet',
        'message': 'No wallet selected.',
      };
    }

    // Check wallet-level button state from API
    final walletButtonState = wallet['instant_cashout_button_state'];
    if (walletButtonState is Map) {
      return Map<String, dynamic>.from(walletButtonState);
    }

    // Fallback: compute locally
    final available = double.tryParse(wallet['available_balance']?.toString() ?? '0') ?? 0;
    final minAmount = double.tryParse(wallet['minimum_cashout_amount']?.toString() ?? '5') ?? 5;
    final currency = _selectedCurrency ?? 'USD';

    if (available <= 0) {
      return {
        'enabled': false,
        'reason': 'no_balance',
        'message': 'No available balance to cash out.',
      };
    }

    if (available < minAmount) {
      return {
        'enabled': false,
        'reason': 'below_minimum',
        'message': 'Minimum cashout is ${minAmount.toStringAsFixed(2)} $currency. Your available balance is ${available.toStringAsFixed(2)} $currency.',
      };
    }

    // Check payout settings from instant cashout info
    final settings = _instantCashoutInfo?['payout_settings'];
    if (settings != null) {
      final instantEnabled = settings['instant_payout_enabled'] == true;
      if (!instantEnabled) {
        return {
          'enabled': false,
          'reason': 'disabled',
          'message': 'Instant cashout is disabled in your settings.',
        };
      }

      // Extract remaining uses and period from settings or instant cashout info
      final remaining = _instantCashoutInfo?['remaining_uses'] ?? 
                        settings['instant_payout_limit'] ?? 
                        'unlimited';
      final periodText = _instantCashoutInfo?['period'] ?? 
                         settings['instant_payout_period'] ?? 
                         'this period';

      return {
        'enabled': true,
        'reason': 'available',
        'message': 'Instant cashout available ($remaining remaining $periodText). 5% fee applies.',
        'remaining_uses': remaining,
        'max_amount': available.toStringAsFixed(2),
        'min_amount': minAmount.toStringAsFixed(2),
        'fee_percent': 5,
      };
    }

    // Default: allow if balance is sufficient
    return {
      'enabled': true,
      'reason': 'available',
      'message': 'Instant cashout available anytime. 5% fee applies.',
      'unlimited': true,
      'max_amount': available.toStringAsFixed(2),
      'min_amount': minAmount.toStringAsFixed(2),
      'fee_percent': 5,
    };
  }

  Future<void> _cashOut() async {
    final l10n = AppLocalizations.of(context);
    final currency = _selectedCurrency;
    if (currency == null) return;

    final amountText = _cashoutAmountCtrl.text.trim();
    if (amountText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an amount to cash out.')),
      );
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount.')),
      );
      return;
    }

    setState(() => _cashoutLoading = true);

    final res = await ApiClient.providerCashOut(currency: currency, amount: amount);
    if (!mounted) return;

    setState(() => _cashoutLoading = false);

    if (res['success'] != true) {
      final detail = res['detail']?.toString() ?? l10n.walletCashOutFailed;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(detail),
          backgroundColor: Colors.red.shade700,
        ),
      );
      return;
    }

    // Check if the payout actually succeeded (not just the API call)
    final payout = res['payout'] as Map<String, dynamic>?;
    if (payout != null) {
      final payoutStatus = payout['status']?.toString()?.toLowerCase();
      if (payoutStatus == 'failed' || payoutStatus == 'reversed') {
        final failureReason = payout['failure_reason']?.toString() ?? 
            'Transfer could not be completed. Please check your payout settings.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payout failed: $failureReason'),
            backgroundColor: Colors.red.shade700,
            duration: const Duration(seconds: 5),
          ),
        );
        _cashoutAmountCtrl.clear();
        await _loadWallets();
        await _loadInstantCashoutInfo();
        return;
      }
    }
	

    final message = res['message']?.toString() ?? 'Cashout initiated successfully!';

    // UPDATE WALLET IMMEDIATELY FROM RESPONSE
    final updatedWallet = res['wallet'];
    if (updatedWallet != null && _selectedCurrency != null) {
      setState(() {
        // Find and update the wallet in the list
        final index = _wallets.indexWhere(
          (w) => w['currency']?.toString() == _selectedCurrency,
        );
        if (index != -1) {
          _wallets[index] = updatedWallet;
        }
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green.shade700,
        duration: const Duration(seconds: 4),
      ),
    );

    // Clear amount field
    _cashoutAmountCtrl.clear();

    // Also refresh from server to ensure consistency
    await _loadWallets();
    await _loadInstantCashoutInfo();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final stripeStatus = _stripeStatus ?? {};
    final hasAcct = stripeStatus['has_account'] == true;
    final payoutsEnabled = stripeStatus['payouts_enabled'] == true;
    final detailsSubmitted = stripeStatus['details_submitted'] == true;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.walletTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: l10n.payoutSettingsTooltip,
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ProviderPayoutSettingsScreen()),
              );
              if (!mounted) return;
              // Refresh after settings change
              await _loadWallets();
              await _loadStripeStatus();
              await _loadInstantCashoutInfo();
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _loadWallets();
          await _loadStripeStatus();
          await _loadInstantCashoutInfo();
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Paystack providers (Ghana, Nigeria, South Africa, Kenya, Côte d'Ivoire)
            if (_isPaystackProvider) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.verified, color: Colors.green.shade700, size: 20),
                          const SizedBox(width: 8),
                          const Text('Paystack Payouts', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text('Add your bank account details in Payout Settings to receive payouts via Paystack.'),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const ProviderPayoutSettingsScreen()),
                            );
                            if (!mounted) return;
                            await _loadWallets();
                            await _loadInstantCashoutInfo();
                          },
                          child: const Text('Open Payout Settings'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ] else if (_isAfricaProvider) ...[
              // Other African providers (Flutterwave)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Flutterwave Payouts', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      const Text('Add your bank/mobile money details in Payout Settings to receive payouts.'),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const ProviderPayoutSettingsScreen()),
                            );
                            if (!mounted) return;
                            await _loadWallets();
                            await _loadInstantCashoutInfo();
                          },
                          child: const Text('Open Payout Settings'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              // Stripe providers (rest of world)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Stripe Connect', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      if (_stripeLoading) const LinearProgressIndicator() else ...[
                        Text(hasAcct ? 'Account: connected' : 'Account: not connected'),
                        Text('Details submitted: ${detailsSubmitted ? "yes" : "no"}'),
                        Text('Payouts enabled: ${payoutsEnabled ? "yes" : "no"}'),
                      ],
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          if (!payoutsEnabled)
                            ElevatedButton(
                              onPressed: _stripeLoading ? null : _openStripeOnboarding,
                              child: Text(hasAcct ? 'Finish Stripe Setup' : 'Connect Stripe'),
                            ),
                          OutlinedButton(
                            onPressed: (!hasAcct || _stripeLoading) ? null : _openStripeDashboard,
                            child: const Text('Open Stripe Dashboard'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text('You must finish Stripe setup before you can cash out.', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              )
            ],
            const SizedBox(height: 12),
            if (_wallets.isEmpty) ...[
              Text(l10n.walletNoWalletYet),
              const SizedBox(height: 12),
            ] else ...[
              DropdownButtonFormField<String>(
                value: _selectedCurrency,
                decoration: InputDecoration(
                  labelText: l10n.walletCurrencyFieldLabel,
                  border: const OutlineInputBorder(),
                ),
                items: _wallets.map((w) {
                  final c = w['currency']?.toString() ?? 'USD';
                  return DropdownMenuItem(value: c, child: Text(c));
                }).toList(),
                onChanged: (val) async {
                  if (val == null) return;
                  setState(() => _selectedCurrency = val);
                  await _loadTransactions(val);
                  _updateCashoutAmountHint();
                },
              ),
              const SizedBox(height: 12),
              _walletCardForCurrency(_selectedCurrency),
              const SizedBox(height: 12),
              _buildInstantCashoutSection(),
              const SizedBox(height: 18),
              Text(l10n.walletTransactionsTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              if (_txLoading)
                const Center(child: CircularProgressIndicator())
              else if (_transactions.isEmpty)
                Text(l10n.walletNoTransactionsYet)
              else
                ..._transactions.map(_txTile),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInstantCashoutSection() {
    final l10n = AppLocalizations.of(context);
    final buttonState = _getButtonState();
    final isEnabled = buttonState['enabled'] == true && !_cashoutLoading;
    final message = buttonState['message']?.toString() ?? '';
    final reason = buttonState['reason']?.toString() ?? '';
    final currency = _selectedCurrency ?? 'USD';
    final wallet = _getSelectedWallet();
    final available = double.tryParse(wallet?['available_balance']?.toString() ?? '0') ?? 0;
    final minAmount = buttonState['min_amount']?.toString() ?? '5.00';
    final maxAmount = buttonState['max_amount']?.toString() ?? available.toStringAsFixed(2);

    // Determine notice color based on state
    Color noticeColor;
    Color noticeBgColor;
    IconData noticeIcon;

    if (isEnabled) {
      noticeColor = Colors.green.shade700;
      noticeBgColor = Colors.green.shade50;
      noticeIcon = Icons.info_outline;
    } else {
      noticeColor = Colors.grey.shade600;
      noticeBgColor = Colors.grey.shade100;
      noticeIcon = Icons.warning_amber_rounded;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Instant Cashout',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Spacer(),
                if (isEnabled)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Unlimited',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // Amount input field
            TextField(
              controller: _cashoutAmountCtrl,
              enabled: isEnabled,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              decoration: InputDecoration(
                labelText: 'Amount to cash out',
                prefixText: '$currency ',
                border: const OutlineInputBorder(),
                helperText: isEnabled ? 'Min: $minAmount - Max: $maxAmount' : null,
                suffixIcon: isEnabled
                    ? TextButton(
                        onPressed: () {
                          _cashoutAmountCtrl.text = maxAmount;
                        },
                        child: const Text('MAX'),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 12),

            // Cashout button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isEnabled ? _cashOut : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isEnabled ? Colors.green : Colors.grey.shade400,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: _cashoutLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(l10n.walletCashOutInstant),
              ),
            ),
            const SizedBox(height: 12),

            // Notice message
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: noticeBgColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: noticeColor.withOpacity(0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(noticeIcon, color: noticeColor, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 13,
                        color: noticeColor,
                        height: 1.4,
                      ),
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

  Widget _walletCardForCurrency(String? currency) {
    final l10n = AppLocalizations.of(context);
    if (currency == null) return const SizedBox.shrink();
    final w = _getSelectedWallet();
    if (w == null) return const SizedBox.shrink();

    final available = double.tryParse(w['available_balance']?.toString() ?? '0') ?? 0;
    final pending = double.tryParse(w['pending_balance']?.toString() ?? '0') ?? 0;
    final lifetimeEarnings = double.tryParse(w['lifetime_earnings']?.toString() ?? '0') ?? 0;
    final lifetimePayouts = double.tryParse(w['lifetime_payouts']?.toString() ?? '0') ?? 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Available Balance (main display)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Available Balance',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh, size: 20),
                  onPressed: _loadWallets,
                  tooltip: 'Refresh',
                ),
              ],
            ),
            Text(
              '${available.toStringAsFixed(2)} $currency',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),

            // Pending Balance
            Row(
              children: [
                Icon(Icons.schedule, size: 16, color: Colors.orange.shade700),
                const SizedBox(width: 8),
                Text(
                  'Pending: ${pending.toStringAsFixed(2)} $currency',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.orange.shade700,
                  ),
                ),
              ],
            ),
            if (pending > 0) ...[
              const SizedBox(height: 4),
              Text(
                'Pending funds will be available after the hold period',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],

            const Divider(height: 24),

            // Lifetime stats
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lifetime Earnings',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        '${lifetimeEarnings.toStringAsFixed(2)} $currency',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Cashed Out',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        '${lifetimePayouts.toStringAsFixed(2)} $currency',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _txTile(dynamic tx) {
    final map = (tx is Map) ? Map<String, dynamic>.from(tx as Map) : <String, dynamic>{};
    final kind = map['kind']?.toString() ?? '';
    final direction = map['direction']?.toString() ?? '';
    final amount = map['amount']?.toString() ?? '';
    final status = map['status']?.toString() ?? '';
    final desc = map['description']?.toString() ?? '';
    final when = map['created_at']?.toString() ?? '';
    final payoutStatus = map['payout_status']?.toString() ?? '';
    final payoutMethod = map['payout_method']?.toString() ?? '';

    // Determine icon and color based on direction and status
    IconData icon;
    Color iconColor;

    if (direction == 'credit') {
      icon = Icons.arrow_downward;
      iconColor = Colors.green;
    } else {
      icon = Icons.arrow_upward;
      iconColor = Colors.red;
    }

    // Status badge color
    Color statusColor;
    switch (status) {
      case 'paid':
        statusColor = Colors.green;
        break;
      case 'pending':
        statusColor = Colors.orange;
        break;
      case 'available':
        statusColor = Colors.blue;
        break;
      case 'reversed':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    // ✅ IMPROVED: Format date with timezone awareness
    String formattedDate = when.isNotEmpty
        ? DateTimeHelper.formatMetadataTime(when)
        : '';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.1),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                '${direction == 'credit' ? '+' : '-'} $amount',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: statusColor.withOpacity(0.5)),
              ),
              child: Text(
                status.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              desc.isNotEmpty ? desc : kind,
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                // ✅ IMPROVED: Add clock icon
                Icon(
                  Icons.access_time,
                  size: 11,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 4),
                Text(
                  formattedDate,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
                if (payoutMethod.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Text(
                    '• $payoutMethod',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
                if (payoutStatus.isNotEmpty && payoutStatus != status) ...[
                  const SizedBox(width: 8),
                  Text(
                    '• Payout: $payoutStatus',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ],
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}