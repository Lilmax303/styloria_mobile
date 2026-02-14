// lib/language_settings_screen.dart

import 'package:flutter/material.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';
import 'main.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  String? _selectedCode;

  static const _languages = <Map<String, String>>[
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
    {'code': 'ak', 'name': 'Twi (Akan)'},
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appState = StyloriaApp.of(context);
    _selectedCode = appState?.locale?.languageCode;
  }

  /// Show confirmation dialog before changing language.
  /// Returns true if user confirmed, false otherwise.
  Future<bool> _confirmLanguageChange(String languageName) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(
              Icons.language_rounded,
              color: Theme.of(context).primaryColor,
              size: 28,
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Change Language',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to change the app language to:',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.translate, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    languageName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'The app interface will update to reflect your selection.',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide(
                      color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                    ),
                  ),
                  child: Text(
                    'No, Keep Current',
                    style: TextStyle(
                      color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Yes, Change',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return result == true;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final appState = StyloriaApp.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.language)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            l10n.choosePreferredLanguage,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          Card(
            child: Column(
              children: [
                RadioListTile<String?>(
                  value: null,
                  groupValue: _selectedCode,
                  title: Text(l10n.systemDefault),
                  onChanged: (v) async {
                    // If already on system default, do nothing
                    if (_selectedCode == null) return;

                    final confirmed = await _confirmLanguageChange('System Default');
                    if (!confirmed) return;

                    setState(() => _selectedCode = null);
                    await appState?.clearLanguageToSystemDefault();
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.languageSetToSystemDefault)),
                    );
                  },
                ),
                const Divider(height: 1),
                ..._languages.map((lang) {
                  final code = lang['code']!;
                  final name = lang['name']!;
                  return RadioListTile<String?>(
                    value: code,
                    groupValue: _selectedCode,
                    title: Text(name),
                    subtitle: Text(code),
                    onChanged: (v) async {
                      // If already selected, do nothing
                      if (_selectedCode == code) return;

                      final confirmed = await _confirmLanguageChange(name);
                      if (!confirmed) return;

                      setState(() => _selectedCode = v);
                      await appState?.setLanguage(code);
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.languageSetToName(name))),
                      );
                    },
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 12),
          Text(
            l10n.noteSomeTextMayStillAppearInEnglish,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.grey.shade400 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}