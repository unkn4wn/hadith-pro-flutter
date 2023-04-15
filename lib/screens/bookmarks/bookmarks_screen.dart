import 'dart:math';

import 'package:flutter/material.dart';
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
          title: Text(AppLocalizations.of(context)!.library_title_main),
          bottom: TabBar(
            tabs: const [
              Tab(
                icon: Icon(Icons.bookmark),
              ),
              Tab(
                icon: Icon(Icons.question_mark),
              )
            ],
            onTap: (index) async {
              if (index == 0) {
                await _readHadithData();
                setState(() {});
              }
            },
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
                itemCount: hadithList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index >= hadithList.length) {
                    return null; // or any other default value you want to return
                  }
                  final hadith = hadithList[index];
                  List<Grade> grades = [];
                  List<String> specificGradeList =
                      hadith[MyDatabaseHelper.columnGrades]
                          .toString()
                          .split("&&");
                  for (var element in specificGradeList) {
                    List<String> parts = element.split("::");
                    if (parts.length >= 2) {
                      grades.add(Grade(name: parts[0], grade: parts[1]));
                    }
                  }

                  // Format 20.0 to 20 and 20.03 to 20.03
                  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
                  double arabicNumber =
                      hadith[MyDatabaseHelper.columnArabicNumber];
                  String arabicNumberString =
                      arabicNumber.toString().replaceAll(regex, '');

                  double hadithNumber =
                      hadith[MyDatabaseHelper.columnHadithNumber];
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
                            inBookReference: hadith[
                                MyDatabaseHelper.columnInBookReference])),
                    bookNumber: BookHelper.fileNamesList
                        .indexOf(hadith[MyDatabaseHelper.columnBookName]),
                    language: hadith[MyDatabaseHelper.columnLanguage],
                  );
                }),
            Scaffold(
              body: SingleChildScrollView(
                child: FutureBuilder<HadithsList>(
                  future: loadJson('assets/json/${fileName}', randomBookNumber),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    }
                    final hadithsOfSection = snapshot.data!.hadiths.toList();
                    var randomHadith = hadithsOfSection[
                        Random().nextInt(hadithsOfSection.length)];
                    while (randomHadith.text.isEmpty) {
                      randomHadith = hadithsOfSection[
                          Random().nextInt(hadithsOfSection.length)];
                    }
                    return HadithItem(
                      bookNumber: randomBookNumber,
                      hadithTranslation: randomHadith,
                      language: SharedPreferencesHelper.getString(
                          "hadithLanguage", "eng"),
                      showNumber: false,
                    );
                  },
                ),
              ),
              floatingActionButton: FloatingActionButton.small(
                  onPressed: () {
                    setState(() {
                      randomBookNumber =
                          Random().nextInt(BookHelper.fileNamesList.length);
                    });
                  },
                  child: const Icon(Icons.refresh)),
            ),
          ],
        ),
      ),
    );
  }
}
