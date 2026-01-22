// lib/about_screen.dart

import 'package:flutter/material.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';


class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // You can customize this text with your real policies/agreements.
    const String policies = '''
Styloria - User Policies & Agreements

1. Overview
Styloria connects customers with service providers (barbers, braiders, and other grooming professionals).

2. Booking & Payments
- Users pay for services through the Styloria platform.
- Funds are held until both user and provider confirm service completion.
- Cancellation, penalties, and refunds are governed by Styloria's terms (to be finalized).

3. Communication
- Users and providers may communicate via in-app chat and calls once a booking is active.
- Sharing personal contact information (phone numbers, emails) inside chat is restricted.

4. Provider Responsibilities
- Providers must maintain accurate profile and availability information.
- Providers agree to deliver services as described and on time.

5. User Responsibilities
- Users agree to provide accurate booking details (location, time, notes).
- Users agree to treat providers respectfully and abide by the platform's rules.

6. Data & Privacy
- Styloria stores necessary account and booking information.
- Sensitive payment data is handled by secure payment processors (e.g., Stripe).

7. Changes to Terms
- Styloria may update these terms and policies.
- Continued use of the app means you accept the latest version.

This text is a placeholder. Replace it with your real legal terms and privacy policy.
''';

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.aboutPoliciesTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            policies,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}