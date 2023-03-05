import 'dart:convert';

class JsonHelper {
  static Map<String, dynamic> parseJson(String jsonString) {
    return json.decode(jsonString);
  }

  static String encodeToJson(Map<String, dynamic> jsonMap) {
    return json.encode(jsonMap);
  }

  static String getMetadataName(Map<String, dynamic> jsonMap) {
    return jsonMap['metadata']['name'];
  }

  static Map<String, dynamic> getMetadataSections(
      Map<String, dynamic> jsonMap) {
    return jsonMap['metadata']['sections'];
  }

  static List<dynamic> getHadiths(Map<String, dynamic> jsonMap) {
    return jsonMap['hadiths'];
  }

  static int getHadithNumber(Map<String, dynamic> hadithMap) {
    return hadithMap['hadithnumber'];
  }

  static int getArabicNumber(Map<String, dynamic> hadithMap) {
    return hadithMap['arabicnumber'];
  }

  static String getHadithText(Map<String, dynamic> hadithMap) {
    return hadithMap['text'];
  }

  static List<dynamic> getHadithGrades(Map<String, dynamic> hadithMap) {
    return hadithMap['grades'];
  }

  static Map<String, dynamic> getReference(Map<String, dynamic> hadithMap) {
    return hadithMap['reference'];
  }

  static int getReferenceBook(Map<String, dynamic> referenceMap) {
    return referenceMap['book'];
  }

  static int getReferenceHadith(Map<String, dynamic> referenceMap) {
    return referenceMap['hadith'];
  }
}
