import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hadithpro/components/widget/hadithitem.dart';
import 'package:hadithpro/helper/bookhelper.dart';
import 'package:hadithpro/helper/sharedpreferenceshelper.dart';
import 'package:hadithpro/models/hadith.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RandomScreen extends StatefulWidget {
  const RandomScreen({Key? key}) : super(key: key);

  @override
  State<RandomScreen> createState() => _RandomScreenState();
}

class _RandomScreenState extends State<RandomScreen> {
  late int randomBookNumber;
  late String fileName;

  List<Map<String, dynamic>> hadithList = [];
  late Future<HadithsList> hadithsListRandom;
  @override
  void initState() {
    super.initState();
    _readRandomNumber();
  }

  Future<void> _readRandomNumber() async {
    fileName = '${SharedPreferencesHelper.getString("hadithLanguage", "eng")}-'
        '${BookHelper.languageToFileNamesMap[SharedPreferencesHelper.getString("hadithLanguage", "eng")]![Random().nextInt(BookHelper.languageToFileNamesMap[SharedPreferencesHelper.getString("hadithLanguage", "eng")]!.length)]}.json';
    randomBookNumber = Random().nextInt(BookHelper
        .languageToFileNamesMap[
            SharedPreferencesHelper.getString("hadithLanguage", "eng")]!
        .length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.random_title_main),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<HadithsList>(
          future: loadJson('assets/json/${fileName}', randomBookNumber),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
            final hadithsOfSection = snapshot.data!.hadiths.toList();
            var randomHadith =
                hadithsOfSection[Random().nextInt(hadithsOfSection.length)];
            while (randomHadith.text.isEmpty) {
              randomHadith =
                  hadithsOfSection[Random().nextInt(hadithsOfSection.length)];
            }
            return HadithItem(
              bookNumber: randomBookNumber,
              hadithTranslation: randomHadith,
              language:
                  SharedPreferencesHelper.getString("hadithLanguage", "eng"),
              myNumbering: 1,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
          onPressed: () {
            setState(() {
              randomBookNumber =
                  Random().nextInt(BookHelper.fileNamesList.length);
            });
          },
          child: const Icon(Icons.refresh)),
    );
  }
}
