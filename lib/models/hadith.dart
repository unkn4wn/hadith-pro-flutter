import 'dart:convert';

import 'package:flutter/services.dart';

class Hadith {
  final dynamic hadithNumber;
  final dynamic arabicNumber;
  final String text;
  final List<Grade> grades;
  final Reference reference;

  Hadith({
    required this.hadithNumber,
    required this.arabicNumber,
    required this.text,
    required this.grades,
    required this.reference,
  });

  factory Hadith.fromJson(Map<String, dynamic> json) {
    final List<Grade> grades = [];
    for (final gradeJson in json['grades']) {
      grades.add(Grade.fromJson(gradeJson));
    }
    return Hadith(
      hadithNumber: json['hadithnumber'],
      arabicNumber: json['arabicnumber'],
      text: json['text'],
      grades: grades,
      reference: Reference.fromJson(json['reference']),
    );
  }
}

class Grade {
  final String name;
  final String grade;

  Grade({required this.name, required this.grade});

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      name: json['name'],
      grade: json['grade'],
    );
  }
}

class Reference {
  final int book;
  final int hadith;

  Reference({required this.book, required this.hadith});

  factory Reference.fromJson(Map<String, dynamic> json) {
    return Reference(
      book: json['book'],
      hadith: json['hadith'],
    );
  }
}

class HadithsList {
  final Map<String, String> sections;
  final List<Hadith> hadiths;

  HadithsList({required this.sections, required this.hadiths});

  factory HadithsList.fromJson(Map<String, dynamic> json) {
    final Map<String, String> sections =
        Map<String, String>.from(json['metadata']['sections']);
    final List<Hadith> hadiths = [];
    for (final hadithJson in json['hadiths']) {
      hadiths.add(Hadith.fromJson(hadithJson));
    }
    return HadithsList(
      sections: sections,
      hadiths: hadiths,
    );
  }
}

// To load a JSON file:
Future<HadithsList> loadJson(String assetPath) async {
  final jsonString = await rootBundle.loadString(assetPath);
  final jsonMap = json.decode(jsonString);
  return HadithsList.fromJson(jsonMap);
}

Future<HadithsList> loadCombinedJson(List<String> assetPaths) async {
  final combinedSections = <String, String>{};
  final combinedList = <Hadith>[];
  for (final assetPath in assetPaths) {
    final hadithsList = await loadJson(assetPath);
    combinedList.addAll(hadithsList.hadiths);
  }
  return HadithsList(sections: combinedSections, hadiths: combinedList);
}
