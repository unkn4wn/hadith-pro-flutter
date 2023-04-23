import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hadithpro/components/widget/hadithitem.dart';
import 'package:hadithpro/helper/bookhelper.dart';
import 'package:hadithpro/helper/databasehelper.dart';
import 'package:hadithpro/helper/sharedpreferenceshelper.dart';
import 'package:hadithpro/models/hadith.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  late int randomBookNumber;
  late String fileName;

  List<Map<String, dynamic>> hadithList = [];
  late Future<HadithsList> hadithsListRandom;
  @override
  void initState() {
    super.initState();
    _readHadithData();
    _readRandomNumber();
  }

  Future<void> _readHadithData() async {
    await MyDatabaseHelper.instance.database;
    final data = await MyDatabaseHelper.instance.readHadithData();
    setState(() {
      hadithList = List<Map<String, dynamic>>.from(data);
    });
  }

  Future<void> _readRandomNumber() async {
    fileName = '${SharedPreferencesHelper.getString("hadithLanguage", "eng")}-'
        '${BookHelper.languageToFileNamesMap[SharedPreferencesHelper.getString("hadithLanguage", "eng")]![Random().nextInt(BookHelper.languageToFileNamesMap[SharedPreferencesHelper.getString("hadithLanguage", "eng")]!.length)]}.json';
    randomBookNumber = Random().nextInt(BookHelper
        .languageToFileNamesMap[
            SharedPreferencesHelper.getString("hadithLanguage", "eng")]!
        .length);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.bookmarks_title_main),
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
            statusBarColor: Colors.transparent,
            systemNavigationBarIconBrightness:
                Theme.of(context).brightness == Brightness.light
                    ? Brightness.dark
                    : Brightness.light,
            statusBarIconBrightness:
                Theme.of(context).brightness == Brightness.light
                    ? Brightness.dark
                    : Brightness.light,
          ),
        ),
        body: ListView.builder(
            itemCount: hadithList.length,
            itemBuilder: (BuildContext context, int index) {
              if (index >= hadithList.length) {
                return null; // or any other default value you want to return
              }
              final hadith = hadithList[index];
              List<Grade> grades = [];
              List<String> specificGradeList =
                  hadith[MyDatabaseHelper.columnGrades].toString().split("&&");
              for (var element in specificGradeList) {
                List<String> parts = element.split("::");
                if (parts.length >= 2) {
                  grades.add(Grade(name: parts[0], grade: parts[1]));
                }
              }

              // Format 20.0 to 20 and 20.03 to 20.03
              RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
              double arabicNumber = hadith[MyDatabaseHelper.columnArabicNumber];
              String arabicNumberString =
                  arabicNumber.toString().replaceAll(regex, '');

              double hadithNumber = hadith[MyDatabaseHelper.columnHadithNumber];
              String hadithNumberString =
                  hadithNumber.toString().replaceAll(regex, '');
              return HadithItem(
                hadithTranslation: Hadith(
                    bookNumber: BookHelper.fileNamesList
                        .indexOf(hadith[MyDatabaseHelper.columnBookName]),
                    hadithNumber: hadithNumberString,
                    arabicNumber: arabicNumberString,
                    textAra: hadith[MyDatabaseHelper.columnTextArabic],
                    text: hadith[MyDatabaseHelper.columnTextTranslated],
                    grades: grades,
                    reference: Reference(
                        bookReference:
                            hadith[MyDatabaseHelper.columnBookReference],
                        inBookReference:
                            hadith[MyDatabaseHelper.columnInBookReference])),
                bookName: hadith[MyDatabaseHelper.columnBookName],
                language: hadith[MyDatabaseHelper.columnLanguage],
                myNumbering: ++index,
              );
            }),
      ),
    );
  }
}
