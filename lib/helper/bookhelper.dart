import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookHelper {
  static const List<String> fileNamesList = [
    "bukhari",
    "muslim",
    "nasai",
    "abudawud",
    "tirmidhi",
    "ibnmajah",
    "malik",
  ];

  static List<String> longNamesList(BuildContext context) {
    return [
      AppLocalizations.of(context)!.books_name_bukhari,
      AppLocalizations.of(context)!.books_name_muslim,
      AppLocalizations.of(context)!.books_name_nasai,
      AppLocalizations.of(context)!.books_name_abudawud,
      AppLocalizations.of(context)!.books_name_tirmidhi,
      AppLocalizations.of(context)!.books_name_ibnmajah,
      AppLocalizations.of(context)!.books_name_malik,
    ];
  }

  static const List<int> hadithNumberList = [
    7563,
    3033,
    5758,
    5274,
    3956,
    4341,
    1858,
  ];
}
