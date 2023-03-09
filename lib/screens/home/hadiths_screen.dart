import 'package:flutter/material.dart';
import 'package:hadithpro/helper/sharedpreferenceshelper.dart';
import 'package:hadithpro/models/hadith.dart';
import 'package:hadithpro/screens/home/books_screen.dart';
import 'package:hadithpro/components/widget/hadithitem.dart';
import 'package:hadithpro/components/widget/roundedItem.dart';

class HadithsScreen extends StatefulWidget {
  final int booknumber;
  final int chapternumber;

  @override
  State<HadithsScreen> createState() => _HadithsScreenState();

  HadithsScreen(
      {Key? key, required this.booknumber, required this.chapternumber})
      : super(key: key);
}

class _HadithsScreenState extends State<HadithsScreen> {
  late Future<HadithsList> _hadithsList;
  late Future<HadithsList> _hadithsListArabic;

  @override
  void initState() {
    super.initState();
    _hadithsListArabic = loadJson('assets/json/' +
        "ara-" +
        BooksScreen().fileNamesList[widget.booknumber] +
        ".min.json");
    _hadithsList = loadJson('assets/json/' +
        SharedPreferencesHelper.getString("hadithLanguage", "eng") +
        "-" +
        BooksScreen().fileNamesList[widget.booknumber] +
        ".min.json");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        elevation: 0,
        title: Text(BooksScreen().longNamesList[widget.booknumber]),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: FutureBuilder<List<HadithsList>>(
        future: Future.wait([_hadithsList, _hadithsListArabic]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final hadithsOfSection = snapshot.data![0].hadiths.where((hadith) {
              return hadith.reference.book == widget.chapternumber;
            }).toList();
            final hadithsOfSectionArabic = snapshot.data![1].hadiths
                .where(
                    (hadith) => hadith.reference.book == widget.chapternumber)
                .toList();
            return Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 0,
                    color: Theme.of(context).colorScheme.tertiary,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: ListTile(
                      leading: RoundedItem(
                        shortName: "${widget.chapternumber}/1",
                        textColor: Theme.of(context).colorScheme.onPrimary,
                        itemColor: Theme.of(context).colorScheme.primary,
                        size: 50,
                      ),
                      title: Text(
                        "Chapter ${widget.chapternumber}",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onTertiary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "by Unknown",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onTertiary,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: hadithsOfSection.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HadithItem(
                            bookNumber: widget.booknumber,
                            hadithArabic: hadithsOfSectionArabic[index],
                            hadithTranslation: hadithsOfSection[index]);
                      },
                    ),
                  ),
                ],
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
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
