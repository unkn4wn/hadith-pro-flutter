import 'package:flutter/material.dart';
import 'package:hadithpro/components/widget/hadithitem.dart';
import 'package:hadithpro/helper/bookhelper.dart';
import 'package:hadithpro/helper/databasehelper.dart';
import 'package:hadithpro/models/hadith.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  List<Map<String, dynamic>> hadithList = [];
  @override
  void initState() {
    super.initState();
    _readHadithData();
  }

  Future<void> _readHadithData() async {
    final data = await MyDatabaseHelper.instance.readHadithData();
    setState(() {
      hadithList = List<Map<String, dynamic>>.from(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.bookmark_title_main),
      ),
      body: ListView.builder(
        itemCount: hadithList.length,
        itemBuilder: (BuildContext context, int index) {
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
                    bookReference: hadith[MyDatabaseHelper.columnBookReference],
                    inBookReference:
                        hadith[MyDatabaseHelper.columnInBookReference])),
            bookNumber: BookHelper.fileNamesList
                .indexOf(hadith[MyDatabaseHelper.columnBookName]),
            language: hadith[MyDatabaseHelper.columnLanguage],
          );
        },
      ),
    );
  }
}
