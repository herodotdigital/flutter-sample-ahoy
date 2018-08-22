import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart';

AhoyLocalizations l10n(BuildContext context) {
  return AhoyLocalizations.of(context);
}

class AhoyLocalizations {
  static Future<AhoyLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AhoyLocalizations();
    });
  }

  static AhoyLocalizations of(BuildContext context) {
    return Localizations.of<AhoyLocalizations>(context, AhoyLocalizations);
  }

  String get me => Intl.message('Me', desc: 'Button on segmented control');
  String get everyone => Intl.message('Everyone', desc: 'Button on segmented control');
}

class AhoyLocalizationsDelegate extends LocalizationsDelegate<AhoyLocalizations> {
  const AhoyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);

  @override
  Future<AhoyLocalizations> load(Locale locale) => AhoyLocalizations.load(locale);

  @override
  bool shouldReload(AhoyLocalizationsDelegate old) => false;
}