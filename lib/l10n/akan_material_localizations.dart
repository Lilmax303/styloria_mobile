// lib/l10n/akan_material_localizations.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class AkanMaterialLocalizations extends DefaultMaterialLocalizations {
  const AkanMaterialLocalizations();

  @override
  String get okButtonLabel => 'Yiw';

  @override
  String get cancelButtonLabel => 'Gyae';

  @override
  String get closeButtonLabel => 'To mu';

  @override
  String get continueButtonLabel => 'Toa so';

  @override
  String get copyButtonLabel => 'Fa bi';

  @override
  String get cutButtonLabel => 'Twa';

  @override
  String get pasteButtonLabel => 'Fa to hɔ';

  @override
  String get selectAllButtonLabel => 'Yi nyinaa';

  @override
  String get saveButtonLabel => 'Sie';

  @override
  String get deleteButtonLabel => 'Popa';

  @override
  String get backButtonTooltip => 'San kɔ';

  @override
  String get closeButtonTooltip => 'To mu';

  @override
  String get nextPageTooltip => 'Krataafa a edi hɔ';

  @override
  String get previousPageTooltip => 'Krataafa a atwam';

  @override
  String get firstPageTooltip => 'Krataafa a edi kan';

  @override
  String get lastPageTooltip => 'Krataafa a etwa to';

  @override
  String get searchFieldLabel => 'Hwehwɛ';

  @override
  String get noSpellCheckReplacementsLabel => 'Nsakrae biara nni hɔ';

  @override
  String get menuBarMenuLabel => 'Menu';

  static const LocalizationsDelegate<MaterialLocalizations> delegate =
      _AkanMaterialLocalizationsDelegate();
}

class _AkanMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _AkanMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ak';

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    return const AkanMaterialLocalizations();
  }

  @override
  bool shouldReload(_AkanMaterialLocalizationsDelegate old) => false;
}