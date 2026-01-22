import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// List of locales that are not supported by Flutter's built-in Material/Cupertino localizations
/// These will fall back to English
const List<String> _unsupportedLocales = [
  'ak', // Twi (Akan)
  'ha', // Hausa
];

/// Custom Material Localizations Delegate that provides fallback for unsupported locales
class FallbackMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return _unsupportedLocales.contains(locale.languageCode);
  }

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    return const DefaultMaterialLocalizations();
  }

  @override
  bool shouldReload(FallbackMaterialLocalizationsDelegate old) => false;
}

/// Custom Cupertino Localizations Delegate that provides fallback for unsupported locales
class FallbackCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return _unsupportedLocales.contains(locale.languageCode);
  }

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    return const DefaultCupertinoLocalizations();
  }

  @override
  bool shouldReload(FallbackCupertinoLocalizationsDelegate old) => false;
}

/// Custom Widgets Localizations Delegate that provides fallback for unsupported locales
class FallbackWidgetsLocalizationsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const FallbackWidgetsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return _unsupportedLocales.contains(locale.languageCode);
  }

  @override
  Future<WidgetsLocalizations> load(Locale locale) async {
    return const DefaultWidgetsLocalizations();
  }

  @override
  bool shouldReload(FallbackWidgetsLocalizationsDelegate old) => false;
}