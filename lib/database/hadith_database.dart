import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path/path.dart';
import '../models/hadith.dart';

class HadithDatabase {
  static final HadithDatabase instance = HadithDatabase._init();

  static Database? _database;

  HadithDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("hadithfull.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // Check if the database file already exists
    if (await databaseExists(path)) {
      print('Database file already exists');
    } else {
      print('Database doesnt exists');
      // Copy the database file from the assets directory to the device's file system
      ByteData data = await rootBundle.load(join('assets', filePath));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await new File(path).writeAsBytes(bytes);
    }

    return await openDatabase(path);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<List<Hadith>> getBookList() async {
    final Database db = await HadithDatabase.instance.database;
    final List<Map<String, dynamic>> bookList =
        await db.query('hadiths', columns: ['DISTINCT booknumber']);

    return bookList.map((map) => Hadith.fromMap(map)).toList();
  }

  Future<List<Hadith>> getChapterList(int? booknumber) async {
    final Database db = await HadithDatabase.instance.database;
    final List<Map<String, dynamic>> bookList = await db.query('hadiths',
        where: 'booknumber = ' + booknumber.toString(),
        columns: ['DISTINCT reference_book']);

    return bookList.map((map) => Hadith.fromMap(map)).toList();
  }

  Future<List<Hadith>> getHadithList(
      int? booknumber, int? chapternumber) async {
    final Database db = await HadithDatabase.instance.database;
    final List<Map<String, dynamic>> hadithList = await db.query('hadiths',
        where: 'booknumber = $booknumber AND reference_book = $chapternumber');

    return hadithList.map((map) => Hadith.fromMap(map)).toList();
  }
}
