import 'package:hadithpro/models/hadith.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class MyDatabaseHelper {
  MyDatabaseHelper._privateConstructor();
  static final MyDatabaseHelper instance =
      MyDatabaseHelper._privateConstructor();
  static Database? _database;
  static const String databaseName = "Bookmark.db";
  static const int databaseVersion = 1;
  static const String tableNameHadiths = "hadiths";
  static const String columnId = "_id";
  static const String columnHadithNumber = "hadithnumber";
  static const String columnArabicNumber = "arabicnumber";
  static const String columnTextArabic = "text_ara";
  static const String columnTextTranslated = "text";
  static const String columnGrades = "grades";
  static const String columnBookName = "book_name";
  static const String columnBookReference = "book_reference";
  static const String columnInBookReference = "inbook_reference";
  static const String columnLanguage = "hadith_language";

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableNameHadiths (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnHadithNumber REAL,
      $columnArabicNumber REAL,
      $columnTextArabic TEXT,
      $columnTextTranslated TEXT,
      $columnGrades TEXT,
      $columnBookName TEXT,
      $columnBookReference INTEGER,
      $columnInBookReference INTEGER,
      $columnLanguage TEXT
    )
''');
  }

  Future<void> addHadith(
      String bookName,
      dynamic hadithNumber,
      dynamic arabicNumber,
      String arabicHadithText,
      String translatedHadithText,
      List<Grade> grades,
      int inBookReference,
      int bookReference,
      String language) async {
    String allGrades = "";
    for (var element in grades) {
      allGrades += "${element.name}::${element.grade}&&";
    }
    final db = await instance.database;
    await db!.insert(tableNameHadiths, {
      columnBookName: bookName,
      columnHadithNumber: hadithNumber,
      columnArabicNumber: arabicNumber,
      columnTextArabic: arabicHadithText,
      columnTextTranslated: translatedHadithText,
      columnGrades: allGrades,
      columnBookReference: bookReference,
      columnInBookReference: inBookReference,
      columnLanguage: language
    });
  }

  Future<List<Map<String, dynamic>>> readHadithData() async {
    final db = await instance.database;
    return await db!.query(tableNameHadiths);
  }

  Future<int> updateData(
      {required int rowId,
      required String bookName,
      required dynamic hadithNumber,
      required dynamic arabicNumber,
      required String arabicHadithText,
      required String translatedHadithText,
      required List<Grade> grades,
      required int bookReference,
      required int inBookReference,
      required String language,
      required String tableName}) async {
    String allGrades = "";
    for (var element in grades) {
      allGrades += "${element.name}::${element.grade}&&";
    }
    final db = await instance.database;
    return await db!.update(
        tableName,
        {
          columnBookName: bookName,
          columnHadithNumber: hadithNumber,
          columnArabicNumber: arabicNumber,
          columnTextArabic: arabicHadithText,
          columnTextTranslated: translatedHadithText,
          columnGrades: allGrades,
          columnBookReference: bookReference,
          columnInBookReference: inBookReference,
          columnLanguage: language
        },
        where: '_id=?',
        whereArgs: [rowId]);
  }

  Future<int> deleteOneRow(String tableName, int rowId) async {
    final db = await instance.database;
    return await db!.delete(tableName, where: '_id=?', whereArgs: [rowId]);
  }

  Future<int> removeHadith(
      String bookName, dynamic hadithNumber, String hadithLanguage) async {
    final db = await instance.database;
    return await db!.delete(tableNameHadiths,
        where: 'book_name=? AND hadithnumber=? AND hadith_language=?',
        whereArgs: [bookName, hadithNumber, hadithLanguage]);
  }

  Future<int?> countTotal(String tableName) async {
    final db = await instance.database;
    var result = await db!.rawQuery("SELECT COUNT(*) FROM $tableName");
    return Sqflite.firstIntValue(result);
  }

  Future<void> deleteAllData(String tableName) async {
    final db = await instance.database;
    await db!.delete(tableName);
  }
}
