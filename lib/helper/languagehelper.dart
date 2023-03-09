class LanguageHelper {
  static Map<String, String> iso639_2Map = {
    'ara': 'Arabic',
    'ben': 'Bengali',
    'eng': 'English',
    'fra': 'French',
    'ind': 'Indonesian',
    'tam': 'Tamil',
    'tur': 'Turkish',
    'urd': 'Urdu',
  };

  static String getLanguageName(String iso639_2Code) {
    return iso639_2Map[iso639_2Code] ?? "eng";
  }
}
