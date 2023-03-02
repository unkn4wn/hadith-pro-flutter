import 'package:flutter/material.dart';
import 'package:hadithpro/widgets/roundedItem.dart';

import '../../database/hadith_database.dart';
import '../../models/hadith.dart';
import 'hadiths.dart';

class Chapters extends StatefulWidget {
  final int? booknumber;
  const Chapters({Key? key, required this.booknumber}) : super(key: key);

  @override
  State<Chapters> createState() => _ChaptersState();
}

class _ChaptersState extends State<Chapters> {
  List<Hadith> _hadithList = [];

  @override
  void initState() {
    super.initState();
    _initHadithList();
  }

  Future<void> _initHadithList() async {
    final hadithList =
        await HadithDatabase.instance.getChapterList(widget.booknumber);

    setState(() {
      _hadithList = hadithList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book " + widget.booknumber.toString()),
      ),
      body: ListView.builder(
          itemCount: _hadithList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: RoundedItem(
                  color: Colors.grey,
                  shortName: _hadithList[index].reference_book.toString(),
                ),
                title: Text("CHAPTER NAME COMING"),
                subtitle: Text("by Unknown"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Hadiths(
                            booknumber: widget.booknumber,
                            chapternumber: _hadithList[index].reference_book,
                          )));
                },
              ),
            );
          }),
    );
  }
}
