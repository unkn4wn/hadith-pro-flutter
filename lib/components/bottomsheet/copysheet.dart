import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hadithpro/models/hadith.dart';
import 'package:hadithpro/screens/home/books_screen.dart';

class CopySheet {
  static void show(
      BuildContext context, Hadith hadithArabic, Hadith hadithTranslation) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
          side: BorderSide(
              color: Theme.of(context).colorScheme.surface,
              strokeAlign: BorderSide.strokeAlignOutside,
              width: 3.0)),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  alignment: Alignment.center,
                  child: Text(
                    "Copy Options",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Theme.of(context).colorScheme.surface,
                  elevation: 0,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    title: Text("Copy Only Translation"),
                    onTap: () async {
                      String grades = "";
                      hadithTranslation.grades.forEach((element) {
                        grades += element.name + ": " + element.grade;
                        if (hadithTranslation.grades.last != element) {
                          grades +=
                              "\n"; // Add new line except for the last element
                        }
                      });
                      String reference = BooksScreen()
                              .longNamesList[hadithTranslation.reference.book] +
                          " " +
                          hadithTranslation.arabicNumber.toString();
                      String inBookReference = "Book " +
                          hadithTranslation.reference.book.toString() +
                          ", " +
                          "Hadith " +
                          hadithTranslation.reference.hadith.toString();
                      String playStoreLink =
                          "https://play.google.com/store/apps/details?id=com.islamicproapps.hadithpro";

                      await Clipboard.setData(ClipboardData(
                          text: hadithTranslation.text +
                              "\n\n" +
                              "Grades:" +
                              "\n" +
                              grades +
                              "\n" +
                              "Reference: " +
                              reference +
                              "\n" +
                              "In-book reference: " +
                              inBookReference +
                              "\n\n" +
                              playStoreLink));
                      Navigator.pop(context);
                    },
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Theme.of(context).colorScheme.surface,
                  elevation: 0,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    title: Text("Copy Both"),
                    onTap: () async {
                      String grades = "";
                      hadithTranslation.grades.forEach((element) {
                        grades += element.name + ": " + element.grade;
                        if (hadithTranslation.grades.last != element) {
                          grades +=
                              "\n"; // Add new line except for the last element
                        }
                      });
                      String reference = BooksScreen()
                              .longNamesList[hadithTranslation.reference.book] +
                          " " +
                          hadithTranslation.arabicNumber.toString();
                      String inBookReference = "Book " +
                          hadithTranslation.reference.book.toString() +
                          ", " +
                          "Hadith " +
                          hadithTranslation.reference.hadith.toString();
                      String playStoreLink =
                          "https://play.google.com/store/apps/details?id=com.islamicproapps.hadithpro";

                      await Clipboard.setData(ClipboardData(
                          text: hadithTranslation.text +
                              "\n\n" +
                              hadithArabic.text +
                              "\n\n" +
                              "Grades:" +
                              "\n" +
                              grades +
                              "\n" +
                              "Reference: " +
                              reference +
                              "\n" +
                              "In-book reference: " +
                              inBookReference +
                              "\n\n" +
                              playStoreLink));

                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
