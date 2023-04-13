import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hadithpro/components/widget/hadithitem.dart';
import 'package:hadithpro/helper/sharedpreferenceshelper.dart';
import 'package:hadithpro/models/hadith.dart';
import 'package:hadithpro/screens/home/books_screen.dart';
import 'package:dartarabic/dartarabic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  bool searchTranslation = true;

  Future<List<HadithsList>>? _hadithsListsFuture;
  final fileNamesList = BooksScreen().fileNamesList;
  final hadithLanguage =
      SharedPreferencesHelper.getString("hadithLanguage", "eng");

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            title: TextField(
              controller: searchController,
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.search_title_main,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.filter_alt),
                    onPressed: () {
                      setState(() {
                        _showBottomSheetFilter();
                      });
                    },
                  ),
                  icon: Icon(Icons.search)),
              onSubmitted: (query) {
                setState(() {
                  _isFiltering = true;
                  _filteredHadiths.clear();
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
                            sectionDetails: {},
                          ),
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
                    if (isNumeric(query)) {
                      final queryAsInt = int.tryParse(query);
                      _filteredHadiths = _allHadiths.where((hadith) {
                        final arabicNumber = hadith.arabicNumber;
                        if (arabicNumber is num) {
                          final arabicNumberAsInt = arabicNumber is int
                              ? arabicNumber
                              : arabicNumber.toDouble().toInt();
                          return arabicNumberAsInt == queryAsInt;
                        } else {
                          return false;
                        }
                      }).toList();
                    } else if (searchTranslation) {
                      _filteredHadiths = _allHadiths.where((hadith) {
                        return hadith.text
                            .toLowerCase()
                            .contains(query.toLowerCase());
                      }).toList();
                    } else {
                      _filteredHadiths = _allHadiths.where((hadith) {
                        return removeArabicHarakat(hadith.text_ara)
                            .toLowerCase()
                            .contains(removeArabicHarakat(query.toLowerCase()));
                      }).toList();
                    }
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final hadith = _filteredHadiths[index];
                final bookNumber = _filteredHadiths[index].bookNumber;
                return HadithItem(
                  bookNumber: bookNumber,
                  hadithTranslation: hadith,
                  language: SharedPreferencesHelper.getString(
                      "hadithLanguage", "eng"),
                );
              },
              childCount: _filteredHadiths.length,
            ),
          ),
          if (_isFiltering)
            SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
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

  void _showBottomSheetFilter() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.search_filter_title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: searchTranslation
                        ? Theme.of(context).colorScheme.surface
                        : Theme.of(context).colorScheme.primary,
                    elevation: 0,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      title: Text(
                        AppLocalizations.of(context)!
                            .search_filter_searcharabic,
                        style: TextStyle(
                            color: searchTranslation
                                ? Theme.of(context).colorScheme.onSurface
                                : Theme.of(context).colorScheme.onPrimary),
                      ),
                      onTap: () {
                        searchTranslation = false;
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: searchTranslation
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surface,
                    elevation: 0,
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 15,
                      top: 10,
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      title: Text(
                          AppLocalizations.of(context)!
                              .search_filter_searchtranslation,
                          style: TextStyle(
                              color: searchTranslation
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.onSurface)),
                      onTap: () {
                        searchTranslation = true;
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  String removeArabicHarakat(String str) {
    RegExp exp = RegExp(r'[\u064b-\u065f]');
    return str.replaceAll(exp, '');
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
