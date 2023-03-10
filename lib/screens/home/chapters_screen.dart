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
        appBar: AppBar(
          title: Text("Book ${widget.bookname}"),
        ),
        body: FutureBuilder<HadithsList>(
          future: _hadithsList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final sectionsMeta = snapshot.data!.sections;
              return ListView.builder(
                itemCount: sectionsMeta.length,
                itemBuilder: (context, index) {
                  if (sectionsMeta.values.elementAt(index).isNotEmpty) {
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
                                  bookNumber: widget.bookname,
                                  chapterNumber: int.parse(
                                      sectionsMeta.keys.elementAt(index)),
                                  chapterName: sectionsMeta.values
                                      .elementAt(index)
                                      .toString(),
                                  chapterLength: sectionsMeta.length - 1,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('This book is not available in this language'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
