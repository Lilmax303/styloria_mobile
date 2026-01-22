// lib/provider_check_service.dart

import 'package:flutter/material.dart';
import 'api_client.dart';
import 'provider_profile_screen.dart';
import 'provider_kyc_screen.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';

class ProviderCheckService {
  static bool _redirecting = false;

  static Future<void> checkAndRedirectIfNeeded(BuildContext context) async {
    if (_redirecting) return;

    try {
      // 1. Check if user is logged in
      final hasToken = await ApiClient.hasAccessToken();
      if (!hasToken) return;

      // 2. Check if user is a provider
      final role = await ApiClient.getCachedUserRole();
      if (role != 'provider') return;

      // 3. Fetch provider profile (decode JSON even on non-200 so we can read verification_status)
      final data = await ApiClient.getMyProviderProfileAnyStatus();
      if (!context.mounted || data == null) return;

      final verificationStatus = data['verification_status']?.toString();

      // A) Force KYC before provider access
      if (verificationStatus != null && verificationStatus != 'approved') {
        _redirecting = true;
        if (!context.mounted) return;

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => ProviderKycScreen(
              verificationStatus: verificationStatus,
            ),
          ),
        );
        return;
      }

      // B) If KYC is approved, then ensure provider profile exists (your original behavior)
      // If backend returns a "detail" instead of provider profile, treat as missing profile.
      final looksLikeProfile = data.containsKey('id') || data.containsKey('bio');
      if (!looksLikeProfile) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showProfileSetupPrompt(context);
        });
      }
    } catch (e) {
      print('Provider check error: $e');
    }
  }

  static void _showProfileSetupPrompt(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.person_add, size: 64, color: Colors.blue),
              const SizedBox(height: 16),
              Text(
                l10n.completeYourProviderProfile,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.completeProviderProfileBody,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProviderProfileScreen(),
                      ),
                    );
                  },
                  child: const Text('Setup Profile Now'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.doItLater),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}