import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabaseHelper {
  final BuildContext context;
  static final String DATABASE_NAME = "Bookmark.db";
  static final int DATABASE_VERSION = 1;

  static final String TABLE_NAME_HADITHS = "hadiths";
  static final String TABLE_NAME_HADITHSGRADES = "hadithsgrades";

  static final String COLUMN_ID = "_id";
  static final String COLUMN_ARABIC = "hadith_arabic";
  static final String COLUMN_TRANSLATED = "hadith_translated";
  static final String COLUMN_REFERENCE = "hadith_reference";
  static final String COLUMN_BOOKREFERENCE = "hadith_bookreference";
  static final String COLUMN_LANGUAGE = "hadith_language";

  static final String COLUMN_GRADESCHOLARS = "hadith_scholars";
  static final String COLUMN_GRADES = "hadith_grades";

  late final Database _db;

  MyDatabaseHelper({required this.context}) {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      version: DATABASE_VERSION,
      onCreate: _createDatabase,
      onUpgrade: _onUpgradeDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    String queryHadiths = "CREATE TABLE " +
        TABLE_NAME_HADITHS +
        " (" +
        COLUMN_ID +
        " INTEGER PRIMARY KEY AUTOINCREMENT, " +
        COLUMN_ARABIC +
        " TEXT, " +
        COLUMN_TRANSLATED +
        " TEXT, " +
        COLUMN_REFERENCE +
        " TEXT, " +
        COLUMN_BOOKREFERENCE +
        " TEXT, " +
        COLUMN_LANGUAGE +
        " TEXT);";

    String queryHadithsGrades = "CREATE TABLE " +
        TABLE_NAME_HADITHSGRADES +
        " (" +
        COLUMN_REFERENCE +
        " TEXT REFERENCES " +
        TABLE_NAME_HADITHS +
        "(" +
        COLUMN_REFERENCE +
        ")" +
        ", " +
        COLUMN_GRADESCHOLARS +
        " TEXT, " +
        COLUMN_GRADES +
        " TEXT, " +
        COLUMN_LANGUAGE +
        " TEXT);";

    await db.execute(queryHadiths);
    await db.execute(queryHadithsGrades);
  }

  Future<void> _onUpgradeDatabase(
      Database db, int oldVersion, int newVersion) async {
    await db.execute("DROP TABLE IF EXISTS " + TABLE_NAME_HADITHS);
    await db.execute("DROP TABLE IF EXISTS " + TABLE_NAME_HADITHSGRADES);
    _createDatabase(db, newVersion);
  }

  Future<void> addHadith(String arabicHadithText, String translatedHadithText,
      String reference, String bookreference, String language) async {
    final db = await _db;
    final cv = <String, dynamic>{
      COLUMN_ARABIC: arabicHadithText,
      COLUMN_TRANSLATED: translatedHadithText,
      COLUMN_REFERENCE: reference,
      COLUMN_BOOKREFERENCE: bookreference,
      COLUMN_LANGUAGE: language,
    };
    print(cv[COLUMN_TRANSLATED]);
    final result = await db.insert(TABLE_NAME_HADITHS, cv);
    if (result == -1) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Add")));
    }
  }

  Future<void> addHadithGrades(String reference, String gradeScholars,
      String grades, String language) async {
    Database db = await _db;
    Map<String, dynamic> cv = {
      COLUMN_REFERENCE: reference,
      COLUMN_GRADESCHOLARS: gradeScholars,
      COLUMN_GRADES: grades,
      COLUMN_LANGUAGE: language
    };
    int result = await db.insert(TABLE_NAME_HADITHSGRADES, cv);
    if (result == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("AddErrot"), duration: Duration(seconds: 2)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Add"), duration: Duration(seconds: 2)));
    }
  }

  Future<List<Map<String, dynamic>>> readHadithData() async {
    String query = "SELECT * FROM $TABLE_NAME_HADITHS";
    Database db = await _db;
    List<Map<String, dynamic>> result = await db.rawQuery(query);
    return result;
  }

  Future<List<Map<String, dynamic>>> readHadithGradesData(
      String reference, String language) async {
    String query =
        "SELECT * FROM $TABLE_NAME_HADITHSGRADES WHERE hadith_reference = ? AND hadith_language = ?";
    List<dynamic> args = [reference, language];
    Database db = await _db;
    List<Map<String, dynamic>> result = await db.rawQuery(query, args);
    return result;
  }

  Future<void> updateData(
      String rowId,
      String arabicHadithText,
      String translatedHadithText,
      String gradeScholars,
      String grades,
      String reference,
      String bookReference,
      String tableName) async {
    final db = await _db;
    final cv = <String, dynamic>{
      COLUMN_ARABIC: arabicHadithText,
      COLUMN_TRANSLATED: translatedHadithText,
      COLUMN_GRADESCHOLARS: gradeScholars,
      COLUMN_GRADES: grades,
      COLUMN_REFERENCE: reference,
      COLUMN_BOOKREFERENCE: bookReference
    };

    final result = await db.update(
      tableName,
      cv,
      where: '_id=?',
      whereArgs: [rowId],
    );

    if (result == -1) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to Update"), duration: Duration(seconds: 2)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Updated succesfully!"),
          duration: Duration(seconds: 2)));
    }
  }

  Future<void> deleteOneRow(String tableName, String row_id) async {
    final db = await _db;
    final result =
        await db.delete(tableName, where: "_id=?", whereArgs: [row_id]);
    if (result == -1) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to remove')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Removed successfully!')));
    }
  }

  Future<void> deleteOneRowReference(
      String tableName, String reference, String language) async {
    final db = await _db;
    final result = await db.delete(tableName,
        where: "hadith_reference=? and hadith_language=?",
        whereArgs: [reference, language]);
    if (result == -1) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to remove')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Removed successfully!')));
    }
  }

  Future<List<Map<String, dynamic>>> getIdOfLastRow(String tableName) async {
    String query = "SELECT SUM(\"_id\") FROM $tableName";
    Database db = await _db;
    List<Map<String, dynamic>> result = await db.rawQuery(query);
    return result;
  }

  void deleteAllData(String tableName) async {
    Database db = await _db;
    await db.delete(tableName);
  }
}
