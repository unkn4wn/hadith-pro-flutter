import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hadithpro/components/widget/roundedItem.dart';
import 'chapters_screen.dart';

class BooksScreen extends StatefulWidget {
  List<String> fileNamesList = [
    "bukhari",
    "muslim",
    "nasai",
    "abudawud",
    "tirmidhi",
    "ibnmajah",
    "malik"
  ];
  List<String> longNamesList = [
    "Sahih Bukhari",
    "Sahih Muslim",
    "Sunan an-Nasa\'i",
    "Sunan Abi Dawud",
    "Jami` at-Tirmidhi",
    "Sunan Ibn Majah",
    "Muwatta Malik"
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
    "Imam Malik"
  ];
  List<String> shortNamesList = ["B", "M", "N", "D", "T", "M", "M"];
  List<Color> colorNamesList = [
    Colors.blue,
    Colors.yellow.shade700,
    Colors.deepPurple,
    Colors.lightGreen,
    Colors.green,
    Colors.pink,
    Colors.lightBlueAccent
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
        title: Text('Hadith List'),
      ),
      body: ListView.builder(
          itemCount: 7,
          itemBuilder: (context, index) {
            return Card(
              color: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                leading: RoundedItem(
                  textColor: Theme.of(context).colorScheme.onPrimary,
                  itemColor: colorNamesList[index],
                  shortName: shortNamesList[index],
                  size: 45,
                ),
                title: Text(
                  BooksScreen().longNamesList[index],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
                subtitle: Text("by " + authorNamesList[index]),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChaptersScreen(bookname: index)));
                },
              ),
            );
          }),
    );
  }
}
