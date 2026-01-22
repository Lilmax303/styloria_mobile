// lib/email_verification_screen.dart

import 'package:flutter/material.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';

import 'api_client.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String identifier; // email OR username
  final String role; // optional

  const EmailVerificationScreen({
    super.key,
    required this.identifier,
    required this.role,
  });

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _codeController = TextEditingController();
  bool _sending = false;
  bool _verifying = false;
  String? _error;
  String? _info;

  bool _didInitInfo = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // l10n isn't available in initState; initialize info here once.
    if (!_didInitInfo) {
      final l10n = AppLocalizations.of(context);
      _info = l10n.verificationCodeSentInfo;
      _didInitInfo = true;
    }
  }

  Future<void> _sendCode() async {
    final l10n = AppLocalizations.of(context);

    setState(() {
      _sending = true;
      _error = null;
      _info = null;
    });

    final ok = await ApiClient.sendEmailVerification(widget.identifier);

    if (!mounted) return;

    setState(() {
      _sending = false;
      _info = ok ? l10n.ifAccountExistsCodeSent : null;
      _error = ok ? null : l10n.failedToSendVerificationCode;
    });
  }

  Future<void> _verify() async {
    final l10n = AppLocalizations.of(context);

    final code = _codeController.text.trim();
    if (code.isEmpty) {
      setState(() => _error = l10n.enter6DigitCodeError);
      return;
    }

    setState(() {
      _verifying = true;
      _error = null;
      _info = null;
    });

    final ok = await ApiClient.confirmEmailVerification(
      identifier: widget.identifier,
      code: code,
    );

    if (!mounted) return;

    setState(() => _verifying = false);

    if (!ok) {
      setState(() => _error = l10n.invalidOrExpiredCodeTryResending);
      return;
    }

    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.verifyYourEmailTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              l10n.emailVerificationInstructions(widget.identifier),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: l10n.verificationCodeLabel,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            if (_info != null) Text(_info!, style: const TextStyle(color: Colors.green)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _sending ? null : _sendCode,
                    child: Text(_sending ? l10n.sendingEllipsis : l10n.resendCode),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _verifying ? null : _verify,
                    child: Text(_verifying ? l10n.verifyingEllipsis : l10n.verify),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}