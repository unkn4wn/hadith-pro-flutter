import 'package:flutter/material.dart';
import 'package:hadithpro/helper/bookhelper.dart';
import 'package:hadithpro/helper/sharedpreferenceshelper.dart';
import 'chapters_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  List<String> authorNamesList = [
    "Imam al-Bukhari",
    "Imam Muslim",
    "Imam  an-Nasa'i",
    "Imam Abu Dawud",
    "Imam at-Tirmidhi",
    "Imam Ibn Majah",
    "Imam Malik",
  ];
  List<String> shortNamesList = ["B", "M", "N", "D", "T", "M", "M"];
  List<Color> colorNamesList = [
    Colors.blue,
    Colors.yellow.shade700,
    Colors.deepPurple,
    Colors.lightGreen,
    Colors.green,
    Colors.pink,
    Colors.lightBlueAccent,
  ];

  List<String> fileTranslatedNamesList = [];

  @override
  void initState() {
    super.initState();
    _initHadithList();

    String hadithLanguage =
        SharedPreferencesHelper.getString("hadithLanguage", "eng");

    fileTranslatedNamesList =
        BookHelper.languageToFileNamesMap.containsKey(hadithLanguage)
            ? BookHelper.languageToFileNamesMap[hadithLanguage]!
            : BookHelper.languageToFileNamesMap["eng"]!;
  }

  Future<void> _initHadithList() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.books_title_main),
      ),
      body: ListView.builder(
        itemCount: BookHelper.fileNamesList
            .where((fileName) => fileTranslatedNamesList.contains(fileName))
            .length,
        itemBuilder: (context, index) {
          final fileName = fileTranslatedNamesList[index];
          final bookIndex = BookHelper.fileNamesList.indexOf(fileName);
          return Column(
            children: [
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                leading: Icon(
                  Icons.book,
                  size: 40,
                  color: colorNamesList[bookIndex],
                ),
                title: Text(
                  BookHelper.longNamesList(context)[bookIndex],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 19),
                ),
                subtitle: Text(
                    "${BookHelper.hadithNumberList[bookIndex]} ${AppLocalizations.of(context)!.books_count}"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ChaptersScreen(bookNumber: bookIndex)));
                },
              ),
              const Divider(
                indent: 20.0,
                endIndent: 20.0,
                height: 0,
              ),
            ],
          );
        },
      ),
    );
  }
}
