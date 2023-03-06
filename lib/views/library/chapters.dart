import 'package:flutter/material.dart';
import 'package:hadithpro/widgets/roundedItem.dart';

import '../../models/hadith.dart';
import 'books.dart';
import 'hadiths.dart';

class Chapters extends StatefulWidget {
  final int bookname;
  const Chapters({Key? key, required this.bookname}) : super(key: key);

  @override
  State<Chapters> createState() => _ChaptersState();
}

class _ChaptersState extends State<Chapters> {
  late Future<HadithsList> _hadithsList;
  late final int bookname;

  @override
  void initState() {
    super.initState();
    bookname = widget.bookname;
    _hadithsList = loadJson('assets/json/' "eng-" +
        Home().fileNamesList[widget.bookname] +
        ".min.json");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        elevation: 0,
        title: Text("Book ${widget.bookname}"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: FutureBuilder<HadithsList>(
        future: _hadithsList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final sectionsMeta = snapshot.data!.sections;
            return Container(
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
                  itemCount: sectionsMeta.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      elevation: 0,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        leading: RoundedItem(
                          textColor:
                              Theme.of(context).colorScheme.onSurfaceVariant,
                          itemColor:
                              Theme.of(context).colorScheme.surfaceVariant,
                          shortName: sectionsMeta.keys.elementAt(index),
                        ),
                        title: Text(sectionsMeta.values.elementAt(index)),
                        subtitle: Text("by Unknown"),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return Hadiths(
                                  bookname: widget.bookname,
                                  chapternumber: int.parse(
                                      sectionsMeta.keys.elementAt(index)),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: const ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(),
                    )));
          }
        },
      ),
    );
  }
}
