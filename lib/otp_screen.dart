// lib/otp_screen.dart

import 'package:flutter/material.dart';
import 'api_client.dart';
import 'main.dart'; // for HomeScreen
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';


class OtpScreen extends StatefulWidget {
  final int userId;
  final String username;

  const OtpScreen({super.key, required this.userId, required this.username});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  bool _loading = false;
  String? _error;

  Future<void> _verify() async {
    final l10n = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    final ok =
        await ApiClient.verifyMfaCode(widget.userId, _codeController.text.trim());

    setState(() => _loading = false);

    if (!ok) {
      setState(() {
        _error = l10n.otpInvalidOrExpired;
      });
      return;
    }

    // Tokens are stored. Now fetch current user to get role.
    final userData = await ApiClient.getCurrentUser();
    if (!mounted) return;

    if (userData == null) {
      setState(() {
        _error = l10n.failedLoadUserInfoAfterVerification;
      });
      return;
    }

    final role = userData['role'] as String? ?? 'user';

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => HomeScreen(role: role)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.enterVerificationCodeTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: 420,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.otpSentToUsername(widget.username),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _codeController,
                    decoration: const InputDecoration(
                      labelText: l10n.sixDigitCodeLabel,
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        (value == null || value.length != 6)
                            ? l10n.enterSixDigitCodeValidation
                            : null,
                  ),
                  const SizedBox(height: 16),
                  if (_error != null)
                    Text(
                      _error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _loading ? null : _verify,
                    child: _loading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.verify),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}