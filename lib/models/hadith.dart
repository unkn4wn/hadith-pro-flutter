import 'dart:convert';

import 'package:flutter/services.dart';

class Hadith {
  final int bookNumber;
  final dynamic hadithNumber;
  final dynamic arabicNumber;
  final String text_ara;
  final String text;
  final List<Grade> grades;
  final Reference reference;

  Hadith({
    required this.bookNumber,
    required this.hadithNumber,
    required this.arabicNumber,
    required this.text_ara,
    required this.text,
    required this.grades,
    required this.reference,
  });

  factory Hadith.fromJson(Map<String, dynamic> json, int booknumber2) {
    final List<Grade> grades = [];
    for (final gradeJson in json['grades']) {
      grades.add(Grade.fromJson(gradeJson));
    }
    int bookNumber = booknumber2;
    return Hadith(
      bookNumber: bookNumber,
      hadithNumber: json['hadithnumber'],
      arabicNumber: json['arabicnumber'],
      text_ara: json['text_ara'],
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

  factory HadithsList.fromJson(Map<String, dynamic> json, int bookNumber) {
    final Map<String, String> sections =
        Map<String, String>.from(json['metadata']['sections']);
    final List<Hadith> hadiths = [];
    for (final hadithJson in json['hadiths']) {
      hadiths.add(Hadith.fromJson(hadithJson, bookNumber));
    }
    return HadithsList(
      sections: sections,
      hadiths: hadiths,
    );
  }
}

// To load a JSON file:
Future<HadithsList> loadJson(String assetPath, int booknumber) async {
  final jsonString = await rootBundle.loadString(assetPath);
  final jsonMap = json.decode(jsonString);
  return HadithsList.fromJson(jsonMap, booknumber);
}
