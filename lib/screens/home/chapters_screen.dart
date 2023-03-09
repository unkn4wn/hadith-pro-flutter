import 'package:flutter/material.dart';
import 'package:hadithpro/helper/sharedpreferenceshelper.dart';
import 'package:hadithpro/models/hadith.dart';
import 'package:hadithpro/screens/home/hadiths_screen.dart';
import 'package:hadithpro/components/widget/roundedItem.dart';
import 'books_screen.dart';

class ChaptersScreen extends StatefulWidget {
  final int bookname;
  const ChaptersScreen({Key? key, required this.bookname}) : super(key: key);

  @override
  State<ChaptersScreen> createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {
  late Future<HadithsList> _hadithsList;
  late final int bookname;

  @override
  void initState() {
    super.initState();
    bookname = widget.bookname;
    _hadithsList = loadJson('assets/json/' +
        SharedPreferencesHelper.getString("hadithLanguage", "eng") +
        "-" +
        BooksScreen().fileNamesList[widget.bookname] +
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
                          size: 45,
                        ),
                        title: Text(sectionsMeta.values.elementAt(index)),
                        subtitle: Text("by Unknown"),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return HadithsScreen(
                                  booknumber: widget.bookname,
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
            return Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Center(
                child: Text('This book is not available in this language'),
              ),
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
