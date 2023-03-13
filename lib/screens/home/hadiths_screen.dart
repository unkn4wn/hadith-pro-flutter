import 'package:flutter/material.dart';
import 'package:hadithpro/helper/sharedpreferenceshelper.dart';
import 'package:hadithpro/models/hadith.dart';
import 'package:hadithpro/screens/home/books_screen.dart';
import 'package:hadithpro/components/widget/hadithitem.dart';
import 'package:hadithpro/components/widget/roundedItem.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

class HadithsScreen extends StatefulWidget {
  final int bookNumber;
  final int chapterNumber;
  final String chapterName;
  final int chapterLength;

  @override
  State<HadithsScreen> createState() => _HadithsScreenState();

  HadithsScreen(
      {Key? key,
      required this.bookNumber,
      required this.chapterNumber,
      required this.chapterName,
      required this.chapterLength})
      : super(key: key);
}

class _HadithsScreenState extends State<HadithsScreen> {
  ScrollController controller = ScrollController();
  late Future<HadithsList> _hadithsList;
  late Future<HadithsList> _hadithsListArabic;

  @override
  void initState() {
    super.initState();
    _hadithsListArabic = loadJson('assets/json/' +
        "ara-" +
        BooksScreen().fileNamesList[widget.bookNumber] +
        ".min.json");
    _hadithsList = loadJson('assets/json/' +
        SharedPreferencesHelper.getString("hadithLanguage", "eng") +
        "-" +
        BooksScreen().fileNamesList[widget.bookNumber] +
        ".min.json");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<HadithsList>>(
        future: Future.wait([_hadithsList, _hadithsListArabic]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final hadithsOfSection = snapshot.data![0].hadiths.where((hadith) {
              return hadith.reference.book == widget.chapterNumber;
            }).toList();
            final hadithsOfSectionArabic = snapshot.data![1].hadiths
                .where(
                    (hadith) => hadith.reference.book == widget.chapterNumber)
                .toList();
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar.medium(
                  title: Text("Chapter " + widget.chapterNumber.toString()),
                ),
                SliverToBoxAdapter(
                  child: Card(
                    elevation: 4,
                    color: Theme.of(context).colorScheme.tertiary,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        widget.chapterName,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onTertiary),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return HadithItem(
                        bookNumber: widget.bookNumber,
                        hadithArabic: hadithsOfSectionArabic[index],
                        hadithTranslation: hadithsOfSection[index],
                      );
                    },
                    childCount: hadithsOfSection.length,
                  ),
                ),
              ],
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
