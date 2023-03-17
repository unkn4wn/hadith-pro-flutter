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
  late List<Future<HadithsList>> _hadithsLists = [];
  List<Hadith> _filteredHadiths = [];
  final List<Hadith> _allHadiths = [];

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
            if (_hadithsListsFuture == null) {
              _hadithsLists = List.generate(fileNamesList.length, (index) {
                return loadJson(
                    'assets/json/$hadithLanguage-${fileNamesList[index]}.json',
                    index);
              });
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
                        hadith.text.toLowerCase().contains(query.toLowerCase()))
                    .toList();
              });
            }).catchError((error) {
              setState(() {
                _filteredHadiths.clear();
              });
            });
          },
        ),
      ),
      body: ListView.builder(
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
    );
  }
}
