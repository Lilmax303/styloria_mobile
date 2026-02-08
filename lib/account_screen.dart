// lib/account_screen.dart

import 'package:flutter/material.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';

import 'profile_screen.dart';
import 'payment_methods_screen.dart';
import 'referral_screen.dart';
import 'account_settings_screen.dart';
import 'provider_earnings_screen.dart';
import 'open_jobs_screen.dart';
import 'bookings_screen.dart';
import 'provider_wallet_screen.dart';
import 'language_settings_screen.dart';
import 'my_reputation_screen.dart';

import 'widgets/background_layer.dart';

class AccountScreen extends StatelessWidget {
  final String role; // "user" or "provider"

  const AccountScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isProvider = role.toLowerCase() == 'provider';
    final cs = Theme.of(context).colorScheme;

    Widget tile({
      required IconData icon,
      required String title,
      required VoidCallback onTap,
    }) {
      return Card(
        color: cs.surface.withOpacity(0.90),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: cs.outline.withOpacity(0.6)),
        ),
        child: ListTile(
          leading: Icon(icon, color: cs.onSurface),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
          onTap: onTap,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.account),
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: BackgroundLayer(
        imageAsset: 'assets/backgrounds/bg_account_champagne_silk.jpg',
        overlayColor: Colors.white,
        overlayOpacity: 0.22,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: ListView(
              children: [
                tile(
                  icon: Icons.person,
                  title: l10n.profile,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
                    );
                  },
                ),

                if (!isProvider)
                  tile(
                    icon: Icons.book_online,
                    title: l10n.myBookings,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const BookingsScreen(role: 'user')),
                      );
                    },
                  ),

                if (!isProvider)
                  tile(
                    icon: Icons.star_outline,
                    title: l10n.mainMyReputation,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => MyReputationScreen()),
                      );
                    },
                  ),

                if (isProvider) ...[
                  tile(
                    icon: Icons.work_outline,
                    title: l10n.openJobs,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const OpenJobsScreen()),
                      );
                    },
                  ),
                  tile(
                    icon: Icons.attach_money,
                    title: l10n.earnings,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ProviderEarningsScreen()),
                      );
                    },
                  ),
                  tile(
                    icon: Icons.account_balance_wallet,
                    title: l10n.walletTitle,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ProviderWalletScreen()),
                      );
                    },
                  ),
                ],

                tile(
                  icon: Icons.payment,
                  title: l10n.paymentMethods,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const PaymentMethodsScreen()),
                    );
                  },
                ),

                tile(
                  icon: Icons.group_add,
                  title: l10n.referFriends,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ReferralScreen()),
                    );
                  },
                ),

                tile(
                  icon: Icons.language,
                  title: l10n.language,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LanguageSettingsScreen()),
                    );
                  },
                ),

                tile(
                  icon: Icons.settings,
                  title: l10n.settings,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AccountSettingsScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}