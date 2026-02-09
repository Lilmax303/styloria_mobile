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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final appState = StyloriaApp.of(context);

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
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}