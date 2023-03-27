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
  final Hadith hadithTranslation;
  HadithItem(
      {Key? key, required this.hadithTranslation, required this.bookNumber})
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
                            hadithTranslation.text_ara,
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
                        CopySheet.show(context, hadithTranslation, bookNumber);
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
                ? Text(
                    hadithTranslation.text_ara,
                    softWrap: true,
                    maxLines: null,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Uthman',
                      fontWeight: FontWeight.normal,
                      fontSize: SharedPreferencesHelper.getDouble(
                          "textSizeArabic", 20.0),
                    ),
                  )
                : SizedBox.shrink(),
            const SizedBox(height: 8),
            SharedPreferencesHelper.getBool("displayTranslation", true)
                ? Text(
                    hadithTranslation.text,
                    softWrap: true,
                    maxLines: null,
                    textDirection: languageDirectionMap[
                            SharedPreferencesHelper.getString(
                                "hadithLanguage", "eng")] ??
                        TextDirection.ltr,
                    textAlign: TextAlign.start,
                    style: TextStyle(
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
        initiallyExpanded:
            SharedPreferencesHelper.getBool("expandGrades", false),
        title: Text("Grades"),
        tilePadding: EdgeInsets.zero,
        children: List.generate(
          hadith.grades.length,
          (index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                children: [
                  Center(
                    child: Text(hadith.grades[index].name),
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: _getTileColor(hadith.grades[index].grade, context),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        hadith.grades[index].grade,
                        style: TextStyle(color: Color(0xFF00390A)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getTileColor(String grade, BuildContext context) {
    if (grade.contains("Sahih") || grade.contains("Hasan")) {
      return Colors.green.shade700;
    } else {
      return Colors.red.shade700;
    }
  }
}
