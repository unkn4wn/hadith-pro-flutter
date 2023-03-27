import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hadithpro/components/widget/roundedItem.dart';
import 'package:hadithpro/models/hadith.dart';
import 'chapters_screen.dart';

class BooksScreen extends StatefulWidget {
  List<String> fileNamesList = [
    "bukhari",
    "muslim",
    "nasai",
    "abudawud",
    "tirmidhi",
    "ibnmajah",
    "malik",
  ];
  List<String> longNamesList = [
    "Sahih Bukhari",
    "Sahih Muslim",
    "Sunan an-Nasa\'i",
    "Sunan Abi Dawud",
    "Jami` at-Tirmidhi",
    "Sunan Ibn Majah",
    "Muwatta Malik",
  ];

  List<int> hadithNumberList = [
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
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  List<String> authorNamesList = [
    "Imam al-Bukhari",
    "Imam Muslim",
    "Imam  an-Nasa\'i",
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

  @override
  void initState() {
    super.initState();
    _initHadithList();
  }

  Future<void> _initHadithList() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
      ),
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                leading: Container(
                  child: Icon(
                    Icons.book,
                    size: 40,
                    color: colorNamesList[index],
                  ),
                ),
                title: Text(
                  BooksScreen().longNamesList[index],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
                subtitle: Text(
                    BooksScreen().hadithNumberList[index].toString() +
                        " Hadtih"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChaptersScreen(bookNumber: index)));
                },
              ),
              Divider(
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
