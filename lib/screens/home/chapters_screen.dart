import 'package:flutter/material.dart';
import 'package:hadithpro/helper/bookhelper.dart';
import 'package:hadithpro/helper/sharedpreferenceshelper.dart';
import 'package:hadithpro/models/hadith.dart';
import 'package:hadithpro/screens/home/hadiths_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final bookNumber = widget.bookNumber;
    final fileName =
        '${SharedPreferencesHelper.getString("hadithLanguage", "eng")}-'
        '${BookHelper.fileNamesList[bookNumber]}.json';
    bookname = bookNumber;
    _hadithsList = loadJson('assets/json/$fileName', bookNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(BookHelper.longNamesList(context)[widget.bookNumber]),
        ),
        body: FutureBuilder<HadithsList>(
          future: _hadithsList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final sectionsMeta = snapshot.data!.metadata.sections;
              final sectionDetails = snapshot.data!.metadata.sectionDetails;
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
                          leading: SizedBox(
                            height: 45,
                            width: 45,
                            child: Card(
                              child: Center(
                                child: Text(
                                  sectionsMeta.keys.elementAt(index),
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          title: Text(sectionsMeta.values.elementAt(index)),
                          subtitle: Text(
                              "${sectionDetails.values.elementAt(index).values.elementAt(2)} ${AppLocalizations.of(context)!.chapters_subtitle_number} ${sectionDetails.values.elementAt(index).values.elementAt(3)}"),
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
                        const Divider(
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
