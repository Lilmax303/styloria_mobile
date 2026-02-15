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

class ProviderEarningsScreen extends StatefulWidget {
  const ProviderEarningsScreen({super.key});

  @override
  State<ProviderEarningsScreen> createState() => _ProviderEarningsScreenState();
}

class _ProviderEarningsScreenState extends State<ProviderEarningsScreen> {
  bool _loading = true;
  bool _savingPdf = false;
  String? _error;
  Map<String, dynamic>? _summary;

  // IMPORTANT: these must match what your backend expects.
  String _period = 'this_month';

  static const List<_PeriodOption> _periodOptions = [
    _PeriodOption('this_month'),
    _PeriodOption('last_month'),
    _PeriodOption('ytd'),
    _PeriodOption('all_time'),
  ];

  @override
  void initState() {
    super.initState();
    _loadSummary();
  }

  Future<void> _loadSummary() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final summary = await ApiClient.getProviderEarningsSummary();

    if (!mounted) return;

    if (summary == null) {
      setState(() {
        _loading = false;
        _error = AppLocalizations.of(context).couldNotLoadEarningsSummary;
        _summary = null;
      });
      return;
    }

    setState(() {
      _loading = false;
      _summary = summary;
    });
  }

  num _readNum(Map<String, dynamic> json, List<String> keys) {
    for (final k in keys) {
      final v = json[k];
      if (v is num) return v;
      if (v is String) {
        final parsed = num.tryParse(v);
        if (parsed != null) return parsed;
      }
    }
    return 0;
  }

  String _readString(
    Map<String, dynamic> json,
    List<String> keys, {
    String fallback = '',
  }) {
    for (final k in keys) {
      final v = json[k];
      if (v is String && v.isNotEmpty) return v;
    }
    return fallback;
  }

  Future<void> _openPdfReport() async {
    setState(() => _error = null);

    final Uint8List? bytes =
        await ApiClient.downloadProviderEarningsReportPdf(period: _period);

    if (!mounted) return;

    if (bytes == null || bytes.isEmpty) {
      setState(() => _error = AppLocalizations.of(context).couldNotDownloadPdfReport);
      return;
    }

    final filename = ApiClient.providerEarningsReportFilename(_period);

    try {
      await openPdfBytes(bytes, filename: filename);
    } catch (e) {
      setState(() => _error = AppLocalizations.of(context).couldNotOpenPdfWithValue(e.toString()));
    }
  }

  Future<Directory?> _getDownloadsDirectory() async {
    if (kIsWeb) return null;

    if (Platform.isAndroid) {
      // App-specific external storage (visible to user via Files app)
      // No extra plugin needed; works with scoped storage.
      final dir = await getExternalStorageDirectory();
      return dir ?? await getApplicationDocumentsDirectory();
    }

    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      // Desktop: real Downloads folder exists
      return await getDownloadsDirectory();
    }

    // iOS: no public Downloads; use Documents
    return await getApplicationDocumentsDirectory();
  }

  Future<void> _savePdfToDownloads() async {
    if (_savingPdf) return;

    setState(() {
      _savingPdf = true;
      _error = null;
    });

    try {
      final Uint8List? bytes =
          await ApiClient.downloadProviderEarningsReportPdf(period: _period);

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

      final filename = ApiClient.providerEarningsReportFilename(_period);
      final filePath = p.join(dir.path, filename);

      final file = File(filePath);
      await file.writeAsBytes(bytes, flush: true);

      if (!mounted) return;

      final l10n = AppLocalizations.of(context);
      final where = (Platform.isIOS)
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final summary = _summary;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.earningsTitle),
        actions: [
          IconButton(
            tooltip: 'Wallet',
            icon: const Icon(Icons.account_balance_wallet),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ProviderWalletScreen()),
              );
            },
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : summary == null
              ? _ErrorState(
                  message: _error ?? l10n.noData,
                  onRetry: _loadSummary,
                )
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    if (_error != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withAlpha(20),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    Text(
                      l10n.summaryTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    _MoneyRow(
                      label: l10n.totalLabel,
                      amount: _readNum(summary, const [
                        'total',
                        'total_earnings',
                        'total_amount',
                      ]),
                      currency: _readString(summary, const ['currency'],
                          fallback: ''),
                    ),
                    _MoneyRow(
                      label: l10n.pendingLabel,
                      amount: _readNum(summary, const [
                        'pending',
                        'pending_earnings',
                        'pending_amount',
                      ]),
                      currency: _readString(summary, const ['currency'],
                          fallback: ''),
                    ),
                    _MoneyRow(
                      label: l10n.paidLabel,
                      amount: _readNum(summary, const [
                        'paid',
                        'paid_earnings',
                        'paid_amount',
                      ]),
                      currency: _readString(summary, const ['currency'],
                          fallback: ''),
                    ),

                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.account_balance_wallet),
                        label: const Text('Open Wallet'),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const ProviderWalletScreen()),
                          );
                        },
                      ),
                    ),
                    const Divider(height: 32),
                    Text(
                      l10n.pdfReportTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),

                    DropdownMenu<String>(
                      initialSelection: _period,
                      label: Text(l10n.periodLabel),
                      dropdownMenuEntries: _periodOptions
                          .map(
                            (p) => DropdownMenuEntry<String>(
                              value: p.value,
                              label: p.localizedLabel(l10n),
                            ),
                          )
                          .toList(),
                      onSelected: (value) {
                        if (value == null) return;
                        setState(() => _period = value);
                      },
                    ),

                    const SizedBox(height: 12),

                    ElevatedButton(
                      onPressed: _openPdfReport,
                      child: Text(l10n.openPdfReport),
                    ),

                    const SizedBox(height: 8),

                    ElevatedButton.icon(
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

                    const SizedBox(height: 8),
                    Text(
                      l10n.reportWatermarkNote,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
    );
  }
}

class _PeriodOption {
  final String value;
  const _PeriodOption(this.value);

  String localizedLabel(AppLocalizations l10n) {
    switch (value) {
      case 'this_month':
        return l10n.periodThisMonth;
      case 'last_month':
        return l10n.periodLastMonth;
      case 'ytd':
        return l10n.periodYtd;
      case 'all_time':
        return l10n.periodAllTime;
      default:
        return value;    
    }
  }
}

class _MoneyRow extends StatelessWidget {
  final String label;
  final num amount;
  final String currency;

  const _MoneyRow({
    required this.label,
    required this.amount,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    // Show currency code and let the backend provide properly converted amounts
    final cur = currency.isEmpty ? '' : '$currency ';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            '$cur${amount.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ],
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