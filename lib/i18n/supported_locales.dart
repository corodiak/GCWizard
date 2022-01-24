import 'package:flutter/material.dart';

final Map<Locale, Map<String, dynamic>> SUPPORTED_LOCALES = {
  Locale('cz'): {'name_native': '🇨🇿 Čeština', 'percent_translated': 5},
  Locale('da'): {'name_native': '🇩🇰 Dansk', 'percent_translated': 2},
  Locale('de'): {'name_native': '🇩🇪 Deutsch', 'percent_translated': 100},
  Locale('el'): {'name_native': '🇬🇷 Ελληνικά', 'percent_translated': 5},
  Locale('en'): {'name_native': '🇬🇧🇺🇸 English', 'percent_translated': 100},
  Locale('es'): {'name_native': '🇪🇸 Español', 'percent_translated': 4},
  Locale('fi'): {'name_native': '🇫🇮 Suomi', 'percent_translated': 21},
  Locale('fr'): {'name_native': '🇫🇷 Français', 'percent_translated': 79},
  Locale('it'): {'name_native': '🇮🇹 Italiano', 'percent_translated': 10},
  Locale('ko'): {'name_native': '🇰🇷 한국어', 'percent_translated': 79},
  Locale('nl'): {'name_native': '🇳🇱 Nederlands', 'percent_translated': 100},
  Locale('pl'): {'name_native': '🇵🇱 Polski', 'percent_translated': 45},
  Locale('pt'): {'name_native': '🇵🇹 Português', 'percent_translated': 13},
  Locale('ru'): {'name_native': '🇷🇺 Ру́сский', 'percent_translated': 7},
  Locale('sk'): {'name_native': '🇸🇰 Slovenský', 'percent_translated': 1},
  Locale('sv'): {'name_native': '🇸🇪 Svenska', 'percent_translated': 34},
  Locale('tr'): {'name_native': '🇹🇷 Türkçe', 'percent_translated': 14},
};

const Locale DEFAULT_LOCALE = Locale('en');

final SUPPORTED_HELPLOCALES = ['en', 'de', 'fr'];

///
///  Control if locale is supported
///
bool isLocaleSupported(Locale locale) {
  // Include all of your supported language codes here
  return SUPPORTED_LOCALES.containsKey(locale);
}
