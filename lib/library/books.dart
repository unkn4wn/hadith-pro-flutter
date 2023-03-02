import 'package:flutter/material.dart';
import 'package:hadithpro/database/hadith_database.dart';
import 'package:hadithpro/models/hadith.dart';
import 'package:hadithpro/theme/theme_constants.dart';
import 'package:hadithpro/widgets/bookitem.dart';
import 'package:hadithpro/widgets/roundedItem.dart';

import '../../database/hadith_database.dart';
import '../../models/hadith.dart';
import 'chapters.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Hadith> _hadithList = [];
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
    "Imam  Ibn Majah",
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
    final hadithList = await HadithDatabase.instance.getBookList();

    setState(() {
      _hadithList = hadithList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hadith List'),
      ),
      body: ListView.builder(
          itemCount: _hadithList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: RoundedItem(
                  color: colorNamesList[index],
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
                          Chapters(booknumber: _hadithList[index].booknumber)));
                },
              ),
            );
          }),
    );
  }
}
