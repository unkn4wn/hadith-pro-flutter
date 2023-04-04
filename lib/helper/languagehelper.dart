import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageHelper {
  static Map<String, String> iso639_2Map = {
    'ara': 'العربية',
    'ben': 'বাংলা',
    'eng': 'English',
    'fra': 'Français',
    'ind': 'Bahasa Indonesia',
    'tam': 'தமிழ்',
    'tur': 'Türkçe',
    'urd': 'اردو',
  };

  static String getLanguageName(String iso639_2Code) {
    return iso639_2Map[iso639_2Code] ?? "English";
  }
}
