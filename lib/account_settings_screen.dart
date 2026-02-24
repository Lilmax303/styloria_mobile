// lib/account_settings_screen.dart

import 'package:flutter/material.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';
import 'about_screen.dart';
import 'main.dart'; // LoginScreen + StyloriaApp.of(context)
import 'support_chat_screen.dart';
import 'api_client.dart';
import 'onboarding_screen.dart'; // ✅ ADD THIS IMPORT
import 'app_tab_state.dart'; // ✅ for clearProfilePictureState

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  String? _selectedLanguageCode;

  static const List<Map<String, String>> _languages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'es', 'name': 'Spanish'},
    {'code': 'fr', 'name': 'French'},
    {'code': 'zh', 'name': 'Mandarin (Chinese)'},
    {'code': 'ru', 'name': 'Russian'},
    {'code': 'ko', 'name': 'Korean'},
    {'code': 'ja', 'name': 'Japanese'},
    {'code': 'ur', 'name': 'Urdu'},
    {'code': 'ar', 'name': 'Arabic'},
    {'code': 'he', 'name': 'Hebrew'},
    {'code': 'de', 'name': 'German'},
    {'code': 'it', 'name': 'Italian'},
    {'code': 'hi', 'name': 'Hindi'},
    {'code': 'sw', 'name': 'Swahili'},
    {'code': 'af', 'name': 'Afrikaans'},
    {'code': 'ha', 'name': 'Hausa'},
    {'code': 'am', 'name': 'Amharic'},
    {'code': 'ak', 'name': 'Twi (Akan)'}
  ];

  List<String> _deletionReasons(AppLocalizations l10n) => [
        l10n.deletionReason1,
        l10n.deletionReason2,
        l10n.deletionReason3,
        l10n.deletionReason4,
        l10n.deletionReason5,
        l10n.deletionReason6,
        l10n.deletionReason7,
        l10n.deletionReason8,
        l10n.deletionReason9,
        l10n.deletionReason10,
        l10n.deletionReason11,
        l10n.deletionReason12,
      ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appState = StyloriaApp.of(context);
    final code = appState?.locale?.languageCode;
    
    if (code != null && !_languages.any((l) => l['code'] == code)) {
      _selectedLanguageCode = null;
    } else {
      _selectedLanguageCode = code;
    }
  }

  // ✅ FIX: Preserve onboarding flag during logout
  Future<void> _logout(BuildContext context) async {
    await OnboardingScreen.logoutPreservingOnboarding(() async {
      await ApiClient.logout();
      clearProfilePictureState();
    });
    if (!context.mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  Future<void> _handleDeleteAccount(BuildContext context) async {
    final l10n = AppLocalizations.of(context);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteAccountTitle),
        content: Text(l10n.deleteAccountConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.no),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.yesDelete),
          ),
        ],
      ),
    );

    if (confirm != true) return;
    if (!context.mounted) return;

    final submitted = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        final selected = <String>{};
        final reasonController = TextEditingController();
        final suggestionsController = TextEditingController();

        bool submitting = false;
        String? error;

        final reasons = _deletionReasons(l10n);

        return StatefulBuilder(
          builder: (ctx, setState) {
            Future<void> submit() async {
              if (submitting) return;

              if (selected.isEmpty) {
                setState(() => error = l10n.deleteAccountSelectAtLeastOneReason);
                return;
              }

              setState(() {
                submitting = true;
                error = null;
              });

              final ok = await ApiClient.deleteMyAccount(
                reasons: selected.toList(),
                reasonText: reasonController.text.trim(),
                suggestions: suggestionsController.text.trim(),
              );

              if (!ctx.mounted) return;

              if (!ok) {
                setState(() {
                  submitting = false;
                  error = l10n.failedToDeleteAccount;
                });
                return;
              }

              Navigator.of(ctx).pop(true);
            }

            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      l10n.deleteAccountSheetTitle,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(l10n.deleteAccountSheetPrompt),
                    const SizedBox(height: 12),

                    ...reasons.map((r) {
                      final isChecked = selected.contains(r);
                      return CheckboxListTile(
                        value: isChecked,
                        title: Text(r),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: submitting
                            ? null
                            : (v) {
                                setState(() {
                                  if (v == true) {
                                    selected.add(r);
                                  } else {
                                    selected.remove(r);
                                  }
                                });
                              },
                      );
                    }),

                    const SizedBox(height: 8),
                    TextField(
                      controller: reasonController,
                      enabled: !submitting,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: l10n.tellUsMoreOptional,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: suggestionsController,
                      enabled: !submitting,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: l10n.suggestionsToImproveOptional,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),

                    if (error != null)
                      Text(
                        error!,
                        style: const TextStyle(color: Colors.red),
                      ),

                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: submitting ? null : submit,
                      child: submitting
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : Text(l10n.deleteMyAccount),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: submitting ? null : () => Navigator.of(ctx).pop(false),
                      child: Text(l10n.cancel),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    // ✅ FIX: Preserve onboarding flag even after account deletion
    // (User might create a new account on same device — no need to see onboarding again)
    if (submitted == true && context.mounted) {
      await OnboardingScreen.logoutPreservingOnboarding(() async {
        await ApiClient.logout();
        clearProfilePictureState();
      });
      if (!context.mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final appState = StyloriaApp.of(context);
    final isDark = appState?.isDarkMode ?? false;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(l10n.darkMode),
            value: isDark,
            onChanged: (_) {
              if (context.mounted) {
                appState?.toggleTheme();
              }
            },
          ),
          const Divider(height: 1),

          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.language),
            subtitle: Text(
              _selectedLanguageCode == null
                  ? l10n.systemDefault
                  : (_languages.firstWhere(
                        (l) => l['code'] == _selectedLanguageCode,
                        orElse: () => {'name': _selectedLanguageCode!},
                      )['name']!),
            ),
            trailing: DropdownButtonHideUnderline(
              child: DropdownButton<String?>(
                value: _selectedLanguageCode,
                items: [
                  DropdownMenuItem<String?>(
                    value: null,
                    child: Text(l10n.systemDefault),
                  ),
                  ..._languages.map(
                    (l) => DropdownMenuItem<String?>(
                      value: l['code'],
                      child: Text(l['name']!),
                    ),
                  ),
                ],
                onChanged: (value) async {
                  final appState = StyloriaApp.of(context);
                  setState(() => _selectedLanguageCode = value);

                  if (value == null) {
                    await appState?.clearLanguageToSystemDefault();
                  } else {
                    await appState?.setLanguage(value);
                  }

                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        value == null ? l10n.languageSetToSystemDefault : l10n.languageUpdated,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const Divider(height: 1),

          ListTile(
            leading: const Icon(Icons.help_outline),
            title: Text(l10n.helpAndSupport),
            subtitle: Text(l10n.chatWithCustomerService),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SupportChatScreen()),
              );
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(l10n.aboutAndPolicies),
            subtitle: Text(l10n.viewUserPoliciesAndAgreements),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AboutScreen()),
              );
            },
          ),
          const Divider(height: 1),

          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(l10n.logOut),
            onTap: () => _logout(context),
          ),

          const Divider(height: 1),

          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: Text(l10n.deleteAccount, style: const TextStyle(color: Colors.red)),
            subtitle: Text(l10n.deleteAccountSubtitle, style: const TextStyle(color: Colors.redAccent)),
            onTap: () => _handleDeleteAccount(context),
          ),
        ],
      ),
    );
  }
}