// lib/provider_earnings_screen.dart


import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';

import 'provider_wallet_screen.dart';
import 'api_client.dart';
import 'utils/pdf_opener.dart';
import 'utils/datetime_helper.dart';

class ProviderEarningsScreen extends StatefulWidget {
  const ProviderEarningsScreen({super.key});

  @override
  State<ProviderEarningsScreen> createState() => _ProviderEarningsScreenState();
}

class _ProviderEarningsScreenState extends State<ProviderEarningsScreen> {
  bool _summaryLoading = true;
  bool _txLoading = false;
  bool _savingPdf = false;
  String? _error;

  Map<String, dynamic>? _summary;
  List<dynamic> _transactions = [];
  int _totalTxCount = 0;
  int _currentPage = 1;
  bool _hasMore = false;

  // Filter state
  String _period = 'all_time';
  String _category = 'all';

  static const List<_PeriodOption> _periodOptions = [
    _PeriodOption('daily', 'periodDaily'),
    _PeriodOption('weekly', 'periodWeekly'),
    _PeriodOption('monthly', 'periodMonthly'),
    _PeriodOption('yearly', 'periodYearly'),
    _PeriodOption('all_time', 'periodAllTime'),
  ];

  static const List<_CategoryOption> _categoryOptions = [
    _CategoryOption('all', 'earningsCategoryAll'),
    _CategoryOption('completed_services', 'earningsCategoryCompletedServices'),
    _CategoryOption('tips', 'earningsCategoryTips'),
    _CategoryOption('cancellation_penalty', 'earningsCategoryCancellationPenalty'),
    _CategoryOption('pending', 'earningsCategoryPending'),
    _CategoryOption('instant_cashouts', 'earningsCategoryInstantCashouts'),
    _CategoryOption('scheduled_payouts', 'earningsCategoryScheduledPayouts'),
    _CategoryOption('refunds', 'earningsCategoryRefunds'),
    _CategoryOption('adjustments', 'earningsCategoryAdjustments'),
  ];

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  Future<void> _loadAll() async {
    await Future.wait([_loadSummary(), _loadTransactions(reset: true)]);
  }

  Future<void> _loadSummary() async {
    setState(() {
      _summaryLoading = true;
      _error = null;
    });

    final summary = await ApiClient.getProviderEarningsSummary(
      period: _period,
      category: _category,
    );

    if (!mounted) return;

    if (summary == null) {
      setState(() {
        _summaryLoading = false;
        _error = AppLocalizations.of(context).couldNotLoadEarningsSummary;
        _summary = null;
      });
      return;
    }

    setState(() {
      _summaryLoading = false;
      _summary = summary;
    });
  }

  Future<void> _loadTransactions({bool reset = false}) async {
    if (reset) {
      _currentPage = 1;
      _transactions = [];
      _hasMore = false;
    }

    setState(() => _txLoading = true);

    final result = await ApiClient.getProviderEarningsTransactions(
      period: _period,
      category: _category,
      page: _currentPage,
    );

    if (!mounted) return;

    if (result == null) {
      setState(() => _txLoading = false);
      return;
    }

    final newTx = (result['transactions'] as List<dynamic>?) ?? [];

    setState(() {
      if (reset) {
        _transactions = newTx;
      } else {
        _transactions.addAll(newTx);
      }
      _totalTxCount = result['total_count'] ?? _transactions.length;
      _hasMore = result['has_more'] == true;
      _txLoading = false;
    });
  }

  void _onPeriodChanged(String? value) {
    if (value == null || value == _period) return;
    setState(() => _period = value);
    _loadAll();
  }

  void _onCategoryChanged(String? value) {
    if (value == null || value == _category) return;
    setState(() => _category = value);
    _loadAll();
  }

  void _loadMore() {
    if (!_hasMore || _txLoading) return;
    _currentPage++;
    _loadTransactions();
  }

  num _readNum(Map<String, dynamic> json, String key) {
    final v = json[key];
    if (v is num) return v;
    if (v is String) return num.tryParse(v) ?? 0;
    return 0;
  }

  String _readStr(Map<String, dynamic> json, String key, {String fallback = ''}) {
    final v = json[key];
    if (v is String && v.isNotEmpty) return v;
    return fallback;
  }

  // ── PDF actions ──

  Future<void> _openPdfReport() async {
    setState(() => _error = null);

    final bytes = await ApiClient.downloadProviderEarningsReportPdf(
      period: _period,
      category: _category,
    );

    if (!mounted) return;

    if (bytes == null || bytes.isEmpty) {
      setState(() => _error = AppLocalizations.of(context).couldNotDownloadPdfReport);
      return;
    }

    final filename = ApiClient.providerEarningsReportFilename(_period, category: _category);

    try {
      await openPdfBytes(bytes, filename: filename);
    } catch (e) {
      setState(() => _error = AppLocalizations.of(context).couldNotOpenPdfWithValue(e.toString()));
    }
  }

  Future<Directory?> _getDownloadsDirectory() async {
    if (kIsWeb) return null;
    if (Platform.isAndroid) {
      final dir = await getExternalStorageDirectory();
      return dir ?? await getApplicationDocumentsDirectory();
    }
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      return await getDownloadsDirectory();
    }
    return await getApplicationDocumentsDirectory();
  }

  Future<void> _savePdfToDownloads() async {
    if (_savingPdf) return;

    setState(() {
      _savingPdf = true;
      _error = null;
    });

    try {
      final bytes = await ApiClient.downloadProviderEarningsReportPdf(
        period: _period,
        category: _category,
      );

      if (!mounted) return;

      if (bytes == null || bytes.isEmpty) {
        setState(() => _error = AppLocalizations.of(context).couldNotDownloadPdfReport);
        return;
      }

      final dir = await _getDownloadsDirectory();
      if (dir == null) {
        setState(() => _error = AppLocalizations.of(context).savingFilesNotSupportedWeb);
        return;
      }

      final filename = ApiClient.providerEarningsReportFilename(_period, category: _category);
      final filePath = p.join(dir.path, filename);
      final file = File(filePath);
      await file.writeAsBytes(bytes, flush: true);

      if (!mounted) return;

      final l10n = AppLocalizations.of(context);
      final where = Platform.isIOS
          ? l10n.savedToDocumentsIosWithPath(filePath)
          : l10n.savedToFilesWithPath(filePath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(where),
          duration: const Duration(seconds: 6),
          action: SnackBarAction(
            label: l10n.open,
            onPressed: () async {
              try {
                await openPdfBytes(bytes, filename: filename);
              } catch (_) {}
            },
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = AppLocalizations.of(context).failedToSavePdfWithValue(e.toString()));
    } finally {
      if (mounted) setState(() => _savingPdf = false);
    }
  }

  // ── Build ──

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final summary = _summary;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.earningsTitle),
        actions: [
          IconButton(
            tooltip: l10n.walletTooltip,
            icon: const Icon(Icons.account_balance_wallet),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ProviderWalletScreen()),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadAll,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ── Error banner ──
            if (_error != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(_error!, style: const TextStyle(color: Colors.red)),
              ),
              const SizedBox(height: 12),
            ],

            // ── Balance Card ──
            if (summary != null) _buildBalanceCard(summary, l10n, theme),
            const SizedBox(height: 16),

            // ── Time Period Filter Chips ──
            Text(l10n.earningsTimeFilter,
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _periodOptions.map((opt) {
                  final isSelected = opt.value == _period;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(opt.localizedLabel(l10n)),
                      selected: isSelected,
                      onSelected: (_) => _onPeriodChanged(opt.value),
                      selectedColor: theme.colorScheme.primary.withOpacity(0.15),
                      labelStyle: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? theme.colorScheme.primary : null,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // ── Category Dropdown ──
            DropdownButtonFormField<String>(
              value: _category,
              decoration: InputDecoration(
                labelText: l10n.earningsCategoryFilter,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              items: _categoryOptions.map((opt) {
                return DropdownMenuItem<String>(
                  value: opt.value,
                  child: Text(opt.localizedLabel(l10n), style: const TextStyle(fontSize: 14)),
                );
              }).toList(),
              onChanged: _onCategoryChanged,
            ),
            const SizedBox(height: 16),

            // ── Filtered Summary Card ──
            if (summary != null && !_summaryLoading) _buildFilteredSummaryCard(summary, l10n, theme),
            if (_summaryLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(child: CircularProgressIndicator()),
              ),

            const SizedBox(height: 16),

            // ── Transactions List ──
            Text(
              '${_readStr(summary ?? {}, 'category_label', fallback: l10n.earningsCategoryAll)} '
              '(${_totalTxCount})',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            if (_txLoading && _transactions.isEmpty)
              const Center(child: Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(),
              ))
            else if (_transactions.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(l10n.earningsNoTransactions,
                      style: TextStyle(color: Colors.grey.shade600)),
                ),
              )
            else ...[
              ..._transactions.map((tx) => _TransactionTile(
                tx: tx is Map<String, dynamic> ? tx : Map<String, dynamic>.from(tx as Map),
              )),
              if (_hasMore)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: _txLoading
                        ? const CircularProgressIndicator()
                        : TextButton.icon(
                            icon: const Icon(Icons.expand_more),
                            label: Text(l10n.earningsLoadMore),
                            onPressed: _loadMore,
                          ),
                  ),
                ),
            ],

            const Divider(height: 32),

            // ── PDF Report Section ──
            Text(l10n.earningsReportSection,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(l10n.earningsReportDescription,
                style: theme.textTheme.bodySmall),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _openPdfReport,
                    icon: const Icon(Icons.visibility),
                    label: Text(l10n.openPdfReport),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _savingPdf ? null : _savePdfToDownloads,
                    icon: _savingPdf
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.download),
                    label: Text(l10n.savePdfToDownloads),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l10n.reportWatermarkNote,
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),

            // ── Open Wallet button ──
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.account_balance_wallet),
                label: Text(l10n.walletTitle),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ProviderWalletScreen()),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════════
  // Balance Card (always visible, unfiltered)
  // ══════════════════════════════════════════
  Widget _buildBalanceCard(Map<String, dynamic> summary, AppLocalizations l10n, ThemeData theme) {
    final currencySymbol = _readStr(summary, 'currency_symbol', fallback: '\$');
    final currency = _readStr(summary, 'currency', fallback: 'usd').toUpperCase();
    final available = _readNum(summary, 'available_balance');
    final pending = _readNum(summary, 'pending_balance');
    final totalBalance = _readNum(summary, 'total_balance');

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primary.withOpacity(0.75),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.earningsTotalBalance,
              style: TextStyle(
                color: Colors.white.withOpacity(0.85),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$currencySymbol${totalBalance.toStringAsFixed(2)} $currency',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _BalancePill(
                  label: l10n.earningsAvailableBalance,
                  value: '$currencySymbol${available.toStringAsFixed(2)}',
                  icon: Icons.check_circle_outline,
                  color: Colors.greenAccent,
                ),
                const SizedBox(width: 16),
                _BalancePill(
                  label: l10n.earningsPendingBalance,
                  value: '$currencySymbol${pending.toStringAsFixed(2)}',
                  icon: Icons.schedule,
                  color: Colors.orangeAccent,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _MiniStat(
                    label: l10n.earningsLifetimeEarnings,
                    value: '$currencySymbol${_readNum(summary, 'lifetime_earnings').toStringAsFixed(2)}',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MiniStat(
                    label: l10n.earningsLifetimePayouts,
                    value: '$currencySymbol${_readNum(summary, 'lifetime_payouts').toStringAsFixed(2)}',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════════
  // Filtered Summary Card (changes with filters)
  // ══════════════════════════════════════════
  Widget _buildFilteredSummaryCard(
      Map<String, dynamic> summary, AppLocalizations l10n, ThemeData theme) {
    final currencySymbol = _readStr(summary, 'currency_symbol', fallback: '\$');
    final totalCredits = _readNum(summary, 'total_credits');
    final totalDebits = _readNum(summary, 'total_debits');
    final netAmount = _readNum(summary, 'net_amount');
    final txCount = _readNum(summary, 'transaction_count').toInt();
    final periodLabel = _readStr(summary, 'period_label', fallback: _period);
    final categoryLabel = _readStr(summary, 'category_label', fallback: _category);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.filter_list, size: 18, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '$periodLabel · $categoryLabel',
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            _SummaryRow(
              label: l10n.earningsTotalCredits,
              value: '$currencySymbol${totalCredits.toStringAsFixed(2)}',
              valueColor: Colors.green.shade700,
            ),
            _SummaryRow(
              label: l10n.earningsTotalDebits,
              value: '-$currencySymbol${totalDebits.toStringAsFixed(2)}',
              valueColor: Colors.red.shade700,
            ),
            const Divider(height: 12),
            _SummaryRow(
              label: l10n.earningsNetAmount,
              value: '${netAmount >= 0 ? '' : '-'}$currencySymbol${netAmount.abs().toStringAsFixed(2)}',
              valueColor: netAmount >= 0 ? Colors.green.shade700 : Colors.red.shade700,
              isBold: true,
            ),
            const SizedBox(height: 6),
            Text(
              l10n.earningsTransactionCount(txCount.toString()),
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════
// Helper Widgets
// ══════════════════════════════════════════

class _BalancePill extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _BalancePill({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 14, color: color),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 11,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;

  const _MiniStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 10,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: isBold ? 15 : 13,
              )),
          Text(value,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
                fontSize: isBold ? 15 : 13,
                color: valueColor,
              )),
        ],
      ),
    );
  }
}

class _PeriodOption {
  final String value;
  final String l10nKey;
  const _PeriodOption(this.value, this.l10nKey);

  String localizedLabel(AppLocalizations l10n) {
    switch (l10nKey) {
      case 'periodDaily':
        return l10n.periodDaily;
      case 'periodWeekly':
        return l10n.periodWeekly;
      case 'periodMonthly':
        return l10n.periodMonthly;
      case 'periodYearly':
        return l10n.periodYearly;
      case 'periodAllTime':
        return l10n.periodAllTime;
      default:
        return value;
    }
  }
}

class _CategoryOption {
  final String value;
  final String l10nKey;
  const _CategoryOption(this.value, this.l10nKey);

  String localizedLabel(AppLocalizations l10n) {
    switch (l10nKey) {
      case 'earningsCategoryAll':
        return l10n.earningsCategoryAll;
      case 'earningsCategoryCompletedServices':
        return l10n.earningsCategoryCompletedServices;
      case 'earningsCategoryTips':
        return l10n.earningsCategoryTips;
      case 'earningsCategoryCancellationPenalty':
        return l10n.earningsCategoryCancellationPenalty;
      case 'earningsCategoryPending':
        return l10n.earningsCategoryPending;
      case 'earningsCategoryInstantCashouts':
        return l10n.earningsCategoryInstantCashouts;
      case 'earningsCategoryScheduledPayouts':
        return l10n.earningsCategoryScheduledPayouts;
      case 'earningsCategoryRefunds':
        return l10n.earningsCategoryRefunds;
      case 'earningsCategoryAdjustments':
        return l10n.earningsCategoryAdjustments;
      default:
        return value;
    }
  }
}

// ══════════════════════════════════════════
// Transaction Tile
// ══════════════════════════════════════════

class _TransactionTile extends StatelessWidget {
  final Map<String, dynamic> tx;

  const _TransactionTile({required this.tx});

  @override
  Widget build(BuildContext context) {
    final direction = tx['direction']?.toString() ?? '';
    final amount = tx['amount']?.toString() ?? '0.00';
    final status = tx['status']?.toString() ?? '';
    final description = tx['description']?.toString() ?? '';
    final detail = tx['detail']?.toString() ?? '';
    final when = tx['created_at']?.toString() ?? '';
    final entryCategory = tx['entry_category']?.toString() ?? '';
    final currency = (tx['currency']?.toString() ?? 'USD').toUpperCase();
    final payoutMethod = tx['payout_method']?.toString() ?? '';

    final isCredit = direction == 'credit';

    // Icon & color per category
    IconData icon;
    Color iconColor;

    switch (entryCategory) {
      case 'tip':
        icon = Icons.volunteer_activism;
        iconColor = Colors.purple;
        break;
      case 'cancellation_penalty':
        icon = Icons.gavel;
        iconColor = Colors.orange.shade700;
        break;
      case 'completed_service':
        icon = Icons.check_circle;
        iconColor = Colors.green;
        break;
      case 'payout':
        icon = Icons.send;
        iconColor = Colors.blue.shade700;
        break;
      case 'refund':
        icon = Icons.replay;
        iconColor = Colors.teal;
        break;
      case 'adjustment':
        icon = Icons.tune;
        iconColor = Colors.grey.shade700;
        break;
      default:
        icon = isCredit ? Icons.arrow_downward : Icons.arrow_upward;
        iconColor = isCredit ? Colors.green : Colors.red;
    }

    // Amount color
    final amountColor = isCredit ? Colors.green.shade700 : Colors.red.shade700;

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

    // Category label
    String categoryLabel;
    switch (entryCategory) {
      case 'tip':
        categoryLabel = '💰 Tip';
        break;
      case 'cancellation_penalty':
        categoryLabel = '⚠️ Penalty';
        break;
      case 'completed_service':
        categoryLabel = '✅ Service';
        break;
      case 'payout':
        categoryLabel = '📤 Payout';
        break;
      case 'refund':
        categoryLabel = '🔄 Refund';
        break;
      case 'adjustment':
        categoryLabel = '🔧 Adjustment';
        break;
      default:
        categoryLabel = isCredit ? '📥 Credit' : '📤 Debit';
    }

    final formattedDate = when.isNotEmpty ? DateTimeHelper.formatMetadataTime(when) : '';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            CircleAvatar(
              radius: 20,
              backgroundColor: iconColor.withOpacity(0.1),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date & status row
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 11, color: Colors.grey.shade500),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          formattedDate,
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: statusColor.withOpacity(0.4)),
                        ),
                        child: Text(
                          status.toUpperCase(),
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Description
                  Text(
                    description.isNotEmpty ? description : categoryLabel,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Detail line (booking info, client, etc.)
                  if (detail.isNotEmpty && detail != description) ...[
                    const SizedBox(height: 2),
                    Text(
                      detail,
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  // Category tag + payout method
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: iconColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          categoryLabel,
                          style: TextStyle(fontSize: 10, color: iconColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                      if (payoutMethod.isNotEmpty) ...[
                        const SizedBox(width: 6),
                        Text(
                          '• ${payoutMethod.toUpperCase()}',
                          style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Amount
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 14),
                Text(
                  '${isCredit ? '+' : '-'} $amount',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: amountColor,
                  ),
                ),
                Text(
                  currency,
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: onRetry, child: Text(l10n.retry)),
          ],
        ),
      ),
    );
  }
}