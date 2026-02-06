import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BizzieLocalizations {
  BizzieLocalizations(this.locale);

  final Locale locale;

  static const supportedLocales = [Locale('en', 'US')];

  static BizzieLocalizations of(BuildContext context) {
    return Localizations.of<BizzieLocalizations>(context, BizzieLocalizations)!;
  }

  String getString({required String en}) {
    return en;
  }
}

class BizzieLocalizationsDelegate
    extends LocalizationsDelegate<BizzieLocalizations> {
  const BizzieLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => BizzieLocalizations.supportedLocales
      .map((e) => e.languageCode)
      .contains(locale.languageCode);

  @override
  Future<BizzieLocalizations> load(Locale locale) {
    return SynchronousFuture<BizzieLocalizations>(BizzieLocalizations(locale));
  }

  @override
  bool shouldReload(BizzieLocalizationsDelegate old) => false;
}
