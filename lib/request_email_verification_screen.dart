// lib/request_email_verification_screen.dart

import 'package:flutter/material.dart';
import 'api_client.dart';
import 'email_verification_screen.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';

class RequestEmailVerificationScreen extends StatefulWidget {
  const RequestEmailVerificationScreen({super.key});

  @override
  State<RequestEmailVerificationScreen> createState() =>
      _RequestEmailVerificationScreenState();
}

class _RequestEmailVerificationScreenState
    extends State<RequestEmailVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();

  bool _sending = false;
  String? _error;
  String? _info;

  @override
  void dispose() {
    _identifierController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    if (!_formKey.currentState!.validate()) return;

    final identifier = _identifierController.text.trim();

    setState(() {
      _sending = true;
      _error = null;
      _info = null;
    });

    final ok = await ApiClient.sendEmailVerification(identifier);

    if (!mounted) return;

    setState(() {
      _sending = false;
      _info = ok ? l10n.ifAccountExistsCodeSent : null;
      _error = ok ? null : l10n.failedToSendVerificationCode;
    });

    if (!ok) return;

    final verified = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => EmailVerificationScreen(
          identifier: identifier,
          role: 'user', // not used here; keep any value
        ),
      ),
    );

    if (!mounted) return;

    if (verified == true) {
      // Back to login screen
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.requestVerificationCodeTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                l10n.requestVerificationInstructions,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _identifierController,
                decoration: InputDecoration(
                  labelText: l10n.emailOrUsername,
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return l10n.required;
                  return null;
                },
              ),
              const SizedBox(height: 12),
              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red)),
              if (_info != null)
                Text(_info!, style: const TextStyle(color: Colors.green)),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _sending ? null : _submit,
                child: _sending
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.sendCode),
              ),
            ],
          ),
        ),
      ),
    );
  }
}