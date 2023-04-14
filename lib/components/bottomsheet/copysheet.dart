import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hadithpro/models/hadith.dart';
import 'package:hadithpro/screens/home/books_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CopySheet {
  static void show(
      BuildContext context, Hadith hadithTranslation, int booknumber) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.hadithitem_copy_title,
                    style: const TextStyle(
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    title: Text(AppLocalizations.of(context)!
                        .hadithitem_copy_copyonlytranslation),
                    onTap: () async {
                      String grades = "";
                      for (var element in hadithTranslation.grades) {
                        grades += "${element.name}: ${element.grade}";
                        if (hadithTranslation.grades.last != element) {
                          grades +=
                              "\n"; // Add new line except for the last element
                        }
                      }
                      String reference =
                          "${BooksScreen().longNamesList[booknumber]} ${hadithTranslation.arabicNumber}";
                      String inBookReference =
                          "${AppLocalizations.of(context)!.hadithitem_inbookreference_book} ${hadithTranslation.reference.bookReference}, ${AppLocalizations.of(context)!.hadithitem_inbookreference_hadith} ${hadithTranslation.reference.inBookReference}";
                      String playStoreLink =
                          "https://play.google.com/store/apps/details?id=com.islamicproapps.hadithpro";

                      Clipboard.setData(ClipboardData(
                          text:
                              "${hadithTranslation.text}\n\nGrades:\n$grades\nReference: $reference\nIn-book reference: $inBookReference\n\n$playStoreLink"));
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    title: Text(
                        AppLocalizations.of(context)!.hadithitem_copy_copyboth),
                    onTap: () async {
                      String grades = "";
                      for (var element in hadithTranslation.grades) {
                        grades += "${element.name}: ${element.grade}";
                        if (hadithTranslation.grades.last != element) {
                          grades +=
                              "\n"; // Add new line except for the last element
                        }
                      }
                      String reference =
                          "${BooksScreen().longNamesList[booknumber]} ${hadithTranslation.arabicNumber}";
                      String inBookReference =
                          "${AppLocalizations.of(context)!.hadithitem_inbookreference_book} ${hadithTranslation.reference.bookReference}, ${AppLocalizations.of(context)!.hadithitem_inbookreference_hadith} ${hadithTranslation.reference.inBookReference}";
                      String playStoreLink =
                          "https://play.google.com/store/apps/details?id=com.islamicproapps.hadithpro";

                      Clipboard.setData(ClipboardData(
                          text:
                              "${hadithTranslation.textAra}\n\n${hadithTranslation.text}\n\nGrades:\n$grades\nReference: $reference\nIn-book reference: $inBookReference\n\n$playStoreLink"));

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
