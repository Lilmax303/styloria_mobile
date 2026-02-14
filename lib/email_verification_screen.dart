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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.verifyYourEmailTitle),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              // ── Mail Icon ──
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withOpacity(0.25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.mark_email_unread_outlined,
                  size: 44,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 20),

              // ── Heading ──
              Text(
                l10n.verifyYourEmailTitle,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // ── Sub-heading / instructions ──
              Text(
                l10n.emailVerificationInstructions(widget.identifier),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.45,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // ── Spam / Junk Notice Card ──
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: colorScheme.secondaryContainer,
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 22,
                      color: colorScheme.secondary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.cantFindEmailTitle,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSecondaryContainer,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.checkSpamJunkNotice,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSecondaryContainer
                                  .withOpacity(0.85),
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // ── Code Input Field ──
              TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  letterSpacing: 8,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  labelText: l10n.verificationCodeLabel,
                  hintText: '• • • • • •',
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colorScheme.outline.withOpacity(0.5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // ── Error / Info Messages ──
              if (_error != null)
                _buildStatusBanner(
                  icon: Icons.error_outline_rounded,
                  text: _error!,
                  color: colorScheme.error,
                  background: colorScheme.errorContainer.withOpacity(0.3),
                ),
              if (_info != null)
                _buildStatusBanner(
                  icon: Icons.check_circle_outline_rounded,
                  text: _info!,
                  color: Colors.green.shade700,
                  background: Colors.green.shade50,
                ),
              const SizedBox(height: 24),

              // ── Action Buttons ──
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _verifying ? null : _verify,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: _verifying
                      ? SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: colorScheme.onPrimary,
                          ),
                        )
                      : Text(l10n.verify),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: _sending ? null : _sendCode,
                  icon: _sending
                      ? SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: colorScheme.primary,
                          ),
                        )
                      : const Icon(Icons.refresh_rounded, size: 20),
                  label: Text(
                    _sending ? l10n.sendingEllipsis : l10n.resendCode,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Reusable status banner widget ───
  Widget _buildStatusBanner({
    required IconData icon,
    required String text,
    required Color color,
    required Color background,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}