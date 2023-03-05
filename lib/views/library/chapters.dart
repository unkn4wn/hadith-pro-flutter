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
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        elevation: 0,
        title: Text("Book " + widget.booknumber.toString()),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: ListView.builder(
              itemCount: _hadithList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  elevation: 0,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    leading: RoundedItem(
                      textColor: Theme.of(context).colorScheme.onSurfaceVariant,
                      itemColor: Theme.of(context).colorScheme.surfaceVariant,
                      shortName: _hadithList[index].reference_book.toString(),
                    ),
                    title: Text("CHAPTER NAME COMING"),
                    subtitle: Text("by Unknown"),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Hadiths(
                                booknumber: widget.booknumber,
                                chapternumber:
                                    _hadithList[index].reference_book,
                              )));
                    },
                  ),
                );
              }),
        ),
      ),
    );
  }
}
