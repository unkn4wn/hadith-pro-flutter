import 'package:flutter/material.dart';
import 'package:hadithpro/components/widget/hadithitem.dart';
import 'package:hadithpro/helper/sharedpreferenceshelper.dart';
import 'package:hadithpro/models/hadith.dart';
import 'package:hadithpro/screens/home/books_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  late Future<List<HadithsList>> _hadithsLists;

  @override
  void initState() {
    super.initState();
    final fileNamesList = BooksScreen().fileNamesList;
    final hadithLanguage =
        SharedPreferencesHelper.getString("hadithLanguage", "eng");

    final hadithArabicLanguage = "ara";

    _hadithsLists = Future.wait(
      List.generate(
        fileNamesList.length * 2,
        (index) {
          if (index < fileNamesList.length) {
            return loadJson(
                'assets/json/$hadithLanguage-${fileNamesList[index]}.min.json');
          } else {
            return loadJson(
                'assets/json/ara-${fileNamesList[index % fileNamesList.length]}1.min.json');
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<HadithsList>>(
        future: _hadithsLists,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final allHadiths = <Hadith>[];
            snapshot.data!.forEach((hadithsList) {
              allHadiths.addAll(hadithsList.hadiths);
            });
            final filteredHadiths = allHadiths.where((hadith) {
              final query = searchController.text.toLowerCase();
              final hadithString = hadith.text.toLowerCase();
              return hadithString.contains(query);
            }).toList();
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar.large(
                  title: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Hadith',
                      suffixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (_) {
                      setState(() {});
                    },
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final hadith = filteredHadiths[index];
                      final bookNumber = snapshot.data!.indexWhere(
                          (hadithsList) =>
                              hadithsList.hadiths.contains(hadith));
                      if (bookNumber <= 6) {
                        return HadithItem(
                          bookNumber: bookNumber,
                          hadithArabic: Hadith(
                            arabicNumber: hadith.arabicNumber,
                            text_ara: "ok_ara",
                            text: "ok",
                            grades: [Grade(name: "ok", grade: "te")],
                            reference: Reference(book: 2, hadith: 2),
                            hadithNumber: null,
                          ),
                          hadithTranslation: hadith,
                        );
                      }
                    },
                    childCount: filteredHadiths.length,
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("d");
          } else {
            return Text("d");
          }
        },
      ),
    );
  }
}
