import 'package:flutter/material.dart';
import 'package:hadithpro/helper/sharedpreferenceshelper.dart';
import 'chapters_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BooksScreen extends StatefulWidget {
  final List<String> fileNamesList = [
    "bukhari",
    "muslim",
    "nasai",
    "abudawud",
    "tirmidhi",
    "ibnmajah",
    "malik",
  ];
  final List<String> longNamesList = [
    "Sahih Bukhari",
    "Sahih Muslim",
    "Sunan an-Nasa'i",
    "Sunan Abi Dawud",
    "Jami` at-Tirmidhi",
    "Sunan Ibn Majah",
    "Muwatta Malik",
  ];

  final List<int> hadithNumberList = [
    7563,
    3033,
    5758,
    5274,
    3956,
    4341,
    1858,
  ];
  BooksScreen({Key? key}) : super(key: key);

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
    Map<String, List<String>> languageToFileNamesMap = {
      "ara": [
        "bukhari",
        "muslim",
        "nasai",
        "abudawud",
        "tirmidhi",
        "ibnmajah",
        "malik",
      ],
      "ben": [
        "bukhari",
        "muslim",
        "nasai",
        "abudawud",
        "tirmidhi",
        "ibnmajah",
        "malik",
      ],
      "eng": [
        "bukhari",
        "muslim",
        "nasai",
        "abudawud",
        "tirmidhi",
        "ibnmajah",
        "malik",
      ],
      "fra": [
        "muslim",
        "malik",
      ],
      "ind": [
        "bukhari",
        "muslim",
        "nasai",
        "abudawud",
        "tirmidhi",
        "ibnmajah",
        "malik",
      ],
      "tam": [
        "bukhari",
        "muslim",
      ],
      "tur": [
        "bukhari",
        "muslim",
        "nasai",
        "abudawud",
        "tirmidhi",
        "ibnmajah",
        "malik",
      ],
      "urd": [
        "bukhari",
        "muslim",
        "nasai",
        "abudawud",
        "tirmidhi",
        "ibnmajah",
        "malik",
      ],
      // add more language options and file names here
    };
    fileTranslatedNamesList = languageToFileNamesMap.containsKey(hadithLanguage)
        ? languageToFileNamesMap[hadithLanguage]!
        : languageToFileNamesMap["eng"]!;
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
        itemCount: BooksScreen()
            .fileNamesList
            .where((fileName) => fileTranslatedNamesList.contains(fileName))
            .length,
        itemBuilder: (context, index) {
          final fileName = fileTranslatedNamesList[index];
          final bookIndex = BooksScreen().fileNamesList.indexOf(fileName);
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
                  BooksScreen().longNamesList[bookIndex],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 19),
                ),
                subtitle:
                    Text("${BooksScreen().hadithNumberList[bookIndex]} Hadith"),
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
