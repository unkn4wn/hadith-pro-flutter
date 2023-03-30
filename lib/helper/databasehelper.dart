import 'package:hadithpro/models/hadith.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class MyDatabaseHelper {
  MyDatabaseHelper._privateConstructor();
  static final MyDatabaseHelper instance =
      MyDatabaseHelper._privateConstructor();
  static Database? _database;
  static const String DATABASE_NAME = "Bookmark.db";
  static const int DATABASE_VERSION = 1;
  static const String TABLE_NAME_HADITHS = "hadiths";
  static const String COLUMN_ID = "_id";
  static const String COLUMN_HADITHNUMBER = "hadithnumber";
  static const String COLUMN_ARABICNUMBER = "arabicnumber";
  static const String COLUMN_TEXTARABIC = "text_ara";
  static const String COLUMN_TEXTTRANSLATED = "text";
  static const String COLUMN_GRADES = "grades";
  static const String COLUMN_BOOKID = "book_id";
  static const String COLUMN_BOOKREFERENCE = "book_reference";
  static const String COLUMN_INBOOKREFERENCE = "inbook_reference";
  static const String COLUMN_LANGUAGE = "hadith_language";
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), DATABASE_NAME);
    return await openDatabase(
      path,
      version: DATABASE_VERSION,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $TABLE_NAME_HADITHS (
      $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      $COLUMN_HADITHNUMBER REAL,
      $COLUMN_ARABICNUMBER REAL,
      $COLUMN_TEXTARABIC TEXT,
      $COLUMN_TEXTTRANSLATED TEXT,
      $COLUMN_GRADES TEXT,
      $COLUMN_BOOKID INTEGER,
      $COLUMN_BOOKREFERENCE INTEGER,
      $COLUMN_INBOOKREFERENCE INTEGER,
      $COLUMN_LANGUAGE TEXT
    )
''');
  }

  Future<void> addHadith(
      int bookId,
      dynamic hadithnumber,
      dynamic arabicnumber,
      String arabicHadithText,
      String translatedHadithText,
      List<Grade> grades,
      int inBookReference,
      int bookReference,
      String language) async {
    String allGrades = "";
    grades.forEach((element) {
      allGrades += element.name + "::" + element.grade + "&&";
    });
    final db = await instance.database;
    await db!.insert(TABLE_NAME_HADITHS, {
      COLUMN_BOOKID: bookId,
      COLUMN_HADITHNUMBER: hadithnumber,
      COLUMN_ARABICNUMBER: arabicnumber,
      COLUMN_TEXTARABIC: arabicHadithText,
      COLUMN_TEXTTRANSLATED: translatedHadithText,
      COLUMN_GRADES: allGrades,
      COLUMN_BOOKREFERENCE: bookReference,
      COLUMN_INBOOKREFERENCE: inBookReference,
      COLUMN_LANGUAGE: language
    });
  }

  Future<List<Map<String, dynamic>>> readHadithData() async {
    final db = await instance.database;
    return await db!.query(TABLE_NAME_HADITHS);
  }

  Future<int> updateData(
      {required int rowId,
      required int bookId,
      required num hadithNumber,
      required num arabicNumber,
      required String arabicHadithText,
      required String translatedHadithText,
      required String grades,
      required int bookReference,
      required int inBookReference,
      required String tableName}) async {
    final db = await instance.database;
    return await db!.update(
        tableName,
        {
          COLUMN_BOOKID: bookId,
          COLUMN_HADITHNUMBER: hadithNumber,
          COLUMN_ARABICNUMBER: arabicNumber,
          COLUMN_TEXTARABIC: arabicHadithText,
          COLUMN_TEXTTRANSLATED: translatedHadithText,
          COLUMN_GRADES: grades,
          COLUMN_BOOKREFERENCE: bookReference,
          COLUMN_INBOOKREFERENCE: inBookReference,
        },
        where: '_id=?',
        whereArgs: [rowId]);
  }

  Future<int> deleteOneRow(String tableName, int rowId) async {
    final db = await instance.database;
    return await db!.delete(tableName, where: '_id=?', whereArgs: [rowId]);
  }

  Future<int> removeHadith(
      int bookId, num hadithNumber, String hadithLanguage) async {
    final db = await instance.database;
    return await db!.delete(TABLE_NAME_HADITHS,
        where: 'book_id=? AND hadithnumber=? AND hadith_language=?',
        whereArgs: [bookId, hadithNumber, hadithLanguage]);
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
