import 'package:flutter/material.dart';
import 'package:hadithpro/components/bottomsheet/copysheet.dart';
import 'package:hadithpro/helper/bookhelper.dart';
import 'package:hadithpro/helper/databasehelper.dart';
import 'package:hadithpro/helper/sharedpreferenceshelper.dart';
import 'package:hadithpro/models/hadith.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HadithItem extends StatefulWidget {
  final String bookName;
  final Hadith hadithTranslation;
  final String language;
  final int myNumbering;
  const HadithItem({
    Key? key,
    required this.hadithTranslation,
    required this.bookName,
    required this.language,
    this.myNumbering = -1,
  }) : super(key: key);

  @override
  State<HadithItem> createState() => _HadithItemState();
}

class _HadithItemState extends State<HadithItem> {
  int bookNumber = -1;

  String isBookmarkedKey = "";
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookNumber = BookHelper.fileNamesList.indexOf(widget.bookName);

    isBookmarkedKey =
        "isBookmarked_${bookNumber}_${widget.hadithTranslation.hadithNumber}_${widget.language}";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // if you need this
        side: BorderSide(
          color: Theme.of(context).dividerColor,
          width: 2,
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
                  margin: const EdgeInsets.all(0),
                  height: 45,
                  width: 45,
                  child: Card(
                    child: Center(
                      child: Text(
                        widget.myNumbering == -1
                            ? widget.hadithTranslation.reference.inBookReference
                                .toString()
                            : widget.myNumbering.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      onTap: () {
                        if (SharedPreferencesHelper.getBool(
                            isBookmarkedKey, false)) {
                          try {
                            MyDatabaseHelper.instance.removeHadith(
                              BookHelper.fileNamesList[bookNumber],
                              widget.hadithTranslation.hadithNumber,
                              widget.language,
                            );
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(AppLocalizations.of(context)!
                                  .hadithitem_bookmarkremove_snackbar_success),
                              duration: const Duration(seconds: 1),
                            ));
                          } catch (e) {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(AppLocalizations.of(context)!
                                  .hadithitem_bookmarkremove_snackbar_error),
                              duration: const Duration(seconds: 1),
                            ));
                          }
                        } else {
                          try {
                            MyDatabaseHelper.instance.addHadith(
                                BookHelper.fileNamesList[bookNumber],
                                widget.hadithTranslation.hadithNumber,
                                widget.hadithTranslation.arabicNumber,
                                widget.hadithTranslation.textAra,
                                widget.hadithTranslation.text,
                                widget.hadithTranslation.grades,
                                widget.hadithTranslation.reference
                                    .inBookReference,
                                widget
                                    .hadithTranslation.reference.bookReference,
                                widget.language);
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(AppLocalizations.of(context)!
                                  .hadithitem_bookmarkadd_snackbar_success),
                              duration: const Duration(seconds: 1),
                            ));
                          } catch (e) {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(AppLocalizations.of(context)!
                                  .hadithitem_bookmarkadd_snackbar_error),
                              duration: const Duration(seconds: 1),
                            ));
                          }
                        }

                        SharedPreferencesHelper.setBool(
                            isBookmarkedKey,
                            !SharedPreferencesHelper.getBool(
                                isBookmarkedKey, false));
                        setState(() {});
                      },
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: SharedPreferencesHelper.getBool(
                                isBookmarkedKey, false)
                            ? Icon(
                                Icons.bookmark_outlined,
                                color: Colors.yellow.shade600,
                              )
                            : const Icon(Icons.bookmark_border),
                      ),
                    ),
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      onTap: () {
                        CopySheet.show(
                            context, widget.hadithTranslation, bookNumber);
                      },
                      child: const SizedBox(
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
                    widget.hadithTranslation.textAra,
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
                : const SizedBox.shrink(),
            const SizedBox(height: 8),
            SharedPreferencesHelper.getBool("displayTranslation", true)
                ? Text(
                    widget.hadithTranslation.text,
                    softWrap: true,
                    maxLines: null,
                    textDirection: languageDirectionMap[widget.language] ??
                        TextDirection.ltr,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SharedPreferencesHelper.getDouble(
                          "textSizeTranslation", 20.0),
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 4),
            const Divider(
              height: 0,
            ),
            _buildGradesCard(context, widget.hadithTranslation),
            const Divider(
              height: 0,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                      AppLocalizations.of(context)!.hadithitem_title_reference),
                ),
                const VerticalDivider(width: 1.0),
                Expanded(
                  child: Text(
                      "${BookHelper.longNamesList(context)[bookNumber]} ${widget.hadithTranslation.arabicNumber}"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(AppLocalizations.of(context)!
                      .hadithitem_title_inbookreference),
                ),
                const VerticalDivider(width: 1.0),
                Expanded(
                  child: Text(
                      "${AppLocalizations.of(context)!.hadithitem_inbookreference_book} ${widget.hadithTranslation.reference.bookReference}, ${AppLocalizations.of(context)!.hadithitem_inbookreference_hadith} ${widget.hadithTranslation.reference.inBookReference}"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildGradesCard(BuildContext context, Hadith hadith) {
  if (hadith.grades.isNotEmpty) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.only(bottom: 15.0),
      initiallyExpanded: SharedPreferencesHelper.getBool("expandGrades", false),
      title: Text(AppLocalizations.of(context)!.hadithitem_title_grades),
      textColor: Theme.of(context).colorScheme.onSurface,
      tilePadding: EdgeInsets.zero,
      children: List.generate(
        hadith.grades.length,
        (index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Column(
              children: [
                Center(
                  child: Text(hadith.grades[index].name),
                ),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: _getTileColor(hadith.grades[index].grade, context),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      hadith.grades[index].grade,
                      style: const TextStyle(color: Color(0xFF00390A)),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  } else {
    return Container();
  }
}

Color _getTileColor(String grade, BuildContext context) {
  if (grade.contains("Sahih") || grade.contains("Hasan")) {
    return Colors.green.shade700;
  } else {
    return Colors.red.shade700;
  }
}
