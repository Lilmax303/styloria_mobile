// lib/referral_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';

import 'api_client.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  String _username = '';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final data = await ApiClient.getCurrentUser();
    if (!mounted) return;
    setState(() {
      _username = data?['username']?.toString() ?? '';
      _loading = false;
    });
  }

  Future<void> _copyCode() async {
    final code = 'STYLORIA-$_username';
    await Clipboard.setData(ClipboardData(text: code));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).referralCodeCopiedWithCode(code))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.referFriendsTitle)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final code = 'STYLORIA-$_username';

    return Scaffold(
      appBar: AppBar(title: Text(l10n.referFriendsTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.shareReferralCodeBody,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.yourReferralCodeLabel,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: SelectableText(
                    code,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _copyCode,
                  child: Text(l10n.copy),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}