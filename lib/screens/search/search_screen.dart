import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hadithpro/components/widget/hadithitem.dart';
import 'package:hadithpro/helper/sharedpreferenceshelper.dart';
import 'package:hadithpro/models/hadith.dart';
import 'package:hadithpro/screens/home/books_screen.dart';
import 'package:dartarabic/dartarabic.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  late List<Future<HadithsList>> _hadithsLists = [];
  List<Hadith> _filteredHadiths = [];
  final List<Hadith> _allHadiths = [];
  bool _isFiltering = false;

  Future<List<HadithsList>>? _hadithsListsFuture;
  final fileNamesList = BooksScreen().fileNamesList;
  final hadithLanguage =
      SharedPreferencesHelper.getString("hadithLanguage", "eng");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Search Hadith',
            suffixIcon: Icon(Icons.search),
          ),
          onSubmitted: (query) {
            setState(() {
              _isFiltering = true;
            });
            if (_hadithsListsFuture == null) {
              _hadithsLists = List.generate(
                fileNamesList.length,
                (index) async {
                  String assetName =
                      'assets/json/$hadithLanguage-${fileNamesList[index]}.json';
                  bool exists = await assetExists(assetName);
                  if (exists) {
                    return loadJson(assetName, index);
                  } else {
                    // handle file not found error
                    print("File not found: $assetName");
                    return HadithsList(
                      metadata: Metadata(
                          bookId: 0,
                          name: "",
                          sections: {},
                          sectionDetails: {}),
                      hadiths: [],
                    );
                  }
                },
              );

              _hadithsListsFuture = Future.wait(_hadithsLists);
            }

            _hadithsListsFuture!.then((snapshot) {
              _allHadiths.clear();
              snapshot.forEach((hadithsList) {
                _allHadiths.addAll(hadithsList.hadiths);
              });
              setState(() {
                _filteredHadiths = _allHadiths
                    .where((hadith) =>
                        hadith.text
                            .toLowerCase()
                            .contains(query.toLowerCase()) ||
                        DartArabic.stripTashkeel(hadith.text_ara)
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                    .toList();
                _isFiltering = false;
              });
            }).catchError((error) {
              print("ERRORSAS " + error.toString());
              setState(() {
                _filteredHadiths.clear();
                _isFiltering = false;
              });
            }).whenComplete(() => _hadithsListsFuture = null);
          },
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: _filteredHadiths.length,
            itemBuilder: (BuildContext context, int index) {
              final hadith = _filteredHadiths[index];
              final bookNumber = _filteredHadiths[index].bookNumber;
              return HadithItem(
                bookNumber: bookNumber,
                hadithTranslation: hadith,
              );
            },
          ),
          if (_isFiltering)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Future<bool> assetExists(String assetName) async {
    try {
      await rootBundle.load(assetName);
      return true;
    } catch (e) {
      return false;
    }
  }
}
