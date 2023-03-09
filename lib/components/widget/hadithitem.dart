import 'package:flutter/material.dart';
import 'package:hadithpro/components/widget/hadithtext.dart';
import 'package:hadithpro/helper/sharedpreferenceshelper.dart';
import 'package:hadithpro/models/hadith.dart';
import 'package:hadithpro/screens/home/books_screen.dart';
import 'package:hadithpro/components/bottomsheet/copysheet.dart';
import 'package:hadithpro/components/widget/roundedItem.dart';

class HadithItem extends StatelessWidget {
  final int bookNumber;
  final Hadith hadithArabic;
  final Hadith hadithTranslation;
  const HadithItem(
      {Key? key,
      required this.hadithArabic,
      required this.hadithTranslation,
      required this.bookNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                RoundedItem(
                  shortName: hadithTranslation.reference.hadith.toString(),
                  textColor: Theme.of(context).colorScheme.onSurfaceVariant,
                  itemColor: Theme.of(context).colorScheme.surfaceVariant,
                  size: 40,
                ),
                Spacer(),
                Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      onTap: () {
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
            HadithText(
              hadithText: hadithArabic,
              TextDirection: TextDirection.rtl,
              TextStyle: TextStyle(
                fontFamily: 'Uthman',
                fontWeight: FontWeight.normal,
                fontSize:
                    SharedPreferencesHelper.getDouble("textSizeArabic", 20.0),
              ),
            ),
            const SizedBox(height: 8),
            HadithText(
              hadithText: hadithTranslation,
              TextDirection: TextDirection.ltr,
              TextStyle: TextStyle(
                fontFamily: SharedPreferencesHelper.getString(
                            "hadithLanguage", "eng") ==
                        ("eng")
                    ? "Uthman"
                    : 'poppins-bold',
                fontWeight: FontWeight.bold,
                fontSize: SharedPreferencesHelper.getDouble(
                    "textSizeTranslation", 20.0),
              ),
            ),
            const SizedBox(height: 4),
            const Divider(
              color: Colors.black,
              height: 0,
            ),
            _buildGradesCard(context, hadithTranslation),
            const Divider(
              color: Colors.black,
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
                tileColor: hadith.grades[index].grade.contains("Sahih") ||
                        hadith.grades[index].grade.contains("Hassan")
                    ? Colors.green
                    : Colors.red,
                visualDensity: VisualDensity(vertical: -4),
                title: Text(hadith.grades[index].name),
              ),
            );
          })),
    );
  }
}
