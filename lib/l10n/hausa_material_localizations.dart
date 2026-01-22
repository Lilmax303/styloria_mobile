// lib/l10n/hausa_material_localizations.dart

import 'package:flutter/material.dart';

class HausaMaterialLocalizations extends DefaultMaterialLocalizations {
  const HausaMaterialLocalizations();

  @override
  String get okButtonLabel => 'To';

  @override
  String get cancelButtonLabel => 'Soke';

  @override
  String get closeButtonLabel => 'Rufe';

  @override
  String get continueButtonLabel => 'Ci gaba';

  @override
  String get copyButtonLabel => 'Kwafi';

  @override
  String get cutButtonLabel => 'Yanke';

  @override
  String get pasteButtonLabel => 'Liƙa';

  @override
  String get selectAllButtonLabel => 'Zaɓi duka';

  @override
  String get saveButtonLabel => 'Ajiye';

  @override
  String get deleteButtonLabel => 'Share';

  @override
  String get backButtonTooltip => 'Koma baya';

  @override
  String get closeButtonTooltip => 'Rufe';

  @override
  String get searchFieldLabel => 'Bincika';

  static const LocalizationsDelegate<MaterialLocalizations> delegate =
      _HausaMaterialLocalizationsDelegate();
}

class _HausaMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _HausaMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ha';

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    return const HausaMaterialLocalizations();
  }

  @override
  bool shouldReload(_HausaMaterialLocalizationsDelegate old) => false;
}