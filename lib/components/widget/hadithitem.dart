import 'package:flutter/material.dart';
import 'package:hadithpro/components/widget/hadithtext.dart';
import 'package:hadithpro/helper/databasehelper.dart';
import 'package:hadithpro/helper/sharedpreferenceshelper.dart';
import 'package:hadithpro/models/hadith.dart';
import 'package:hadithpro/screens/home/books_screen.dart';
import 'package:hadithpro/components/bottomsheet/copysheet.dart';

class HadithItem extends StatelessWidget {
  Map<String, TextDirection> languageDirectionMap = {
    "ara": TextDirection.rtl,
    "ben": TextDirection.ltr,
    "eng": TextDirection.ltr,
    "fra": TextDirection.ltr,
    "ind": TextDirection.ltr,
    "tam": TextDirection.ltr,
    "tur": TextDirection.ltr,
    "urd": TextDirection.rtl,
  };

  final int bookNumber;
  final Hadith hadithArabic;
  final Hadith hadithTranslation;
  HadithItem(
      {Key? key,
      required this.hadithArabic,
      required this.hadithTranslation,
      required this.bookNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // if you need this
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(0),
                  height: 45,
                  width: 45,
                  child: Card(
                    child: Center(
                      child: Text(
                        hadithTranslation.reference.hadith.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      onTap: () {
                        final MyDatabaseHelper _databaseHelper =
                            MyDatabaseHelper(context: context);
                        _databaseHelper.addHadith(
                            hadithArabic.text,
                            hadithTranslation.text,
                            hadithTranslation.arabicNumber,
                            hadithTranslation.reference.book.toString(),
                            SharedPreferencesHelper.getString(
                                "hadithLanguage", "eng"));
                        print("HELLo");
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        child: Icon(Icons.bookmark_border),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      onTap: () {
                        CopySheet.show(
                            context, hadithArabic, hadithTranslation);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        child: Icon(Icons.copy),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            SharedPreferencesHelper.getBool("displayArabic", true)
                ? HadithText(
                    hadithText: hadithArabic,
                    TextDirection: TextDirection.rtl,
                    TextStyle: TextStyle(
                      fontFamily: 'Uthman',
                      fontWeight: FontWeight.normal,
                      fontSize: SharedPreferencesHelper.getDouble(
                          "textSizeArabic", 20.0),
                    ),
                  )
                : SizedBox.shrink(),
            const SizedBox(height: 8),
            SharedPreferencesHelper.getBool("displayTranslation", true)
                ? HadithText(
                    hadithText: hadithTranslation,
                    TextDirection: languageDirectionMap[
                            SharedPreferencesHelper.getString(
                                "hadithLanguage", "eng")] ??
                        TextDirection.ltr,
                    TextStyle: TextStyle(
                      fontFamily: SharedPreferencesHelper.getString(
                                  "hadithLanguage", "eng") ==
                              ("eng")
                          ? "Roboto-Bold"
                          : 'Roboto-Bold',
                      fontWeight: FontWeight.bold,
                      fontSize: SharedPreferencesHelper.getDouble(
                          "textSizeTranslation", 20.0),
                    ),
                  )
                : SizedBox.shrink(),
            const SizedBox(height: 4),
            const Divider(
              height: 0,
            ),
            _buildGradesCard(context, hadithTranslation),
            const Divider(
              height: 0,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: Text("Reference"),
                ),
                const VerticalDivider(width: 1.0),
                Expanded(
                  child: Text(
                      "${BooksScreen().longNamesList[bookNumber]} ${hadithTranslation.arabicNumber}"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: Text("In-book reference"),
                ),
                const VerticalDivider(width: 1.0),
                Expanded(
                  child: Text(
                      "Book ${hadithTranslation.reference.book}, Hadith ${hadithTranslation.reference.hadith}"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradesCard(BuildContext context, Hadith hadith) {
    return Container(
      child: ExpansionTile(
          title: Text("Grades"),
          tilePadding: EdgeInsets.zero,
          children: List.generate(hadith.grades.length, (index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                trailing: Text(hadith.grades[index].grade),
                tileColor: _getTileColor(hadith.grades[index].grade),
                visualDensity: VisualDensity(vertical: -4),
                title: Text(hadith.grades[index].name),
              ),
            );
          })),
    );
  }

  Color _getTileColor(String grade) {
    if (grade.contains("Hasan")) {
      return Colors.green.shade400;
    } else if (grade.contains("Sahih")) {
      return Colors.green.shade700;
    } else {
      return Colors.red.shade400;
    }
  }
}
