import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hadithpro/models/hadith.dart';
import 'package:hadithpro/theme/theme_constants.dart';
import 'package:hadithpro/widgets/bookitem.dart';
import 'package:hadithpro/widgets/roundedItem.dart';
import '../../models/hadith.dart';
import 'chapters.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        elevation: 0,
        title: Text('Hadith List'),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: ListView.builder(
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
                  ),
                  title: Text(
                    longNamesList[index],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                  subtitle: Text("by " + authorNamesList[index]),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            Chapters(bookname: fileNamesList[index])));
                  },
                ),
              );
            }),
      ),
    );
  }
}
