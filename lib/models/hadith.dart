import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class HadithBook {
  final Map<String, dynamic> metadata;
  final List<Map<String, dynamic>> hadiths;

  HadithBook({required this.metadata, required this.hadiths});

  factory HadithBook.fromJson(Map<String, dynamic> json) {
    return HadithBook(
      metadata: json['metadata'],
      hadiths: List<Map<String, dynamic>>.from(json['hadiths']),
    );
  }
}

class Metadata {
  final int bookId;
  final String name;
  final Map<String, String> sections;
  final Map<String, Map<String, num>> sectionDetails;

  Metadata({
    required this.bookId,
    required this.name,
    required this.sections,
    required this.sectionDetails,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    final Map<String, String> sections = {};
    for (final key in json['sections'].keys) {
      sections[key] = json['sections'][key];
    }

    final Map<String, Map<String, num>> sectionDetails = {};
    for (final key in json['section_details'].keys) {
      sectionDetails[key] = Map<String, num>.from(json['section_details'][key]);
    }

    return Metadata(
      bookId: json['book_id'],
      name: json['name'],
      sections: sections,
      sectionDetails: sectionDetails,
    );
  }
}

extension HadithNumberDifference on Map<String, num> {
  int getHadithNumberDifference() {
    final int first = this['hadithnumber_first']?.toInt() ?? 0;
    final int last = this['hadithnumber_last']?.toInt() ?? 0;
    return last - first;
  }
}

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
  final int bookReference;
  final int inBookReference;

  Reference({required this.bookReference, required this.inBookReference});

  factory Reference.fromJson(Map<String, dynamic> json) {
    return Reference(
      bookReference: json['book'],
      inBookReference: json['hadith'],
    );
  }
}

class HadithsList {
  final Metadata metadata;
  final List<Hadith> hadiths;

  HadithsList({required this.metadata, required this.hadiths});

  factory HadithsList.fromJson(Map<String, dynamic> json, int bookNumber) {
    final List<Hadith> hadiths = [];
    for (final hadithJson in json['hadiths']) {
      hadiths.add(Hadith.fromJson(hadithJson, bookNumber));
    }
    return HadithsList(
      metadata: Metadata.fromJson(json['metadata']),
      hadiths: hadiths,
    );
  }
}

// To load a JSON file:
Future<HadithsList> loadJson(String assetPath, int booknumber) async {
  final jsonString = await rootBundle.loadString(assetPath);
  return await compute(
      parseJson, {'jsonString': jsonString, 'bookNumber': booknumber});
}

// A function to parse the JSON string in a separate thread
HadithsList parseJson(Map<String, dynamic> data) {
  final jsonString = data['jsonString'];
  final bookNumber = data['bookNumber'];
  final jsonMap = json.decode(jsonString);
  return HadithsList.fromJson(jsonMap, bookNumber);
}
