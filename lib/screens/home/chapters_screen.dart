import 'package:flutter/material.dart';
import 'package:hadithpro/helper/sharedpreferenceshelper.dart';
import 'package:hadithpro/models/hadith.dart';
import 'package:hadithpro/screens/home/hadiths_screen.dart';
import 'package:hadithpro/components/widget/roundedItem.dart';
import 'books_screen.dart';

class ChaptersScreen extends StatefulWidget {
  final int bookNumber;
  const ChaptersScreen({Key? key, required this.bookNumber}) : super(key: key);

  @override
  State<ChaptersScreen> createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {
  late Future<HadithsList> _hadithsList;
  late final int bookname;

  @override
  void initState() {
    super.initState();
    bookname = widget.bookNumber;
    _hadithsList = loadJson('assets/json/' +
        SharedPreferencesHelper.getString("hadithLanguage", "eng") +
        "-" +
        BooksScreen().fileNamesList[widget.bookNumber] +
        ".min.json");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(BooksScreen().longNamesList[widget.bookNumber]),
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
                    return Column(
                      children: [
                        ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          leading: Container(
                            height: 45,
                            width: 45,
                            child: Card(
                              child: Center(
                                child: Text(
                                  sectionsMeta.keys.elementAt(index),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          title: Text(sectionsMeta.values.elementAt(index)),
                          subtitle: Text("by Unknown"),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return HadithsScreen(
                                    bookNumber: widget.bookNumber,
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
                        Divider(
                          indent: 20.0,
                          endIndent: 20.0,
                          height: 0,
                        ),
                      ],
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
