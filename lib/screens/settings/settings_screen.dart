import 'package:flutter/material.dart';
import 'package:hadithpro/helper/languagehelper.dart';
import 'package:hadithpro/helper/sharedpreferenceshelper.dart';
import 'package:hadithpro/main.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsScreen extends StatefulWidget {
  List<String> longLanguageList = [
    "Arabic",
    "Bengali",
    "English",
    "French",
    "Indonesian",
    "Tamil",
    "Turkish",
    "Urdu"
  ];

  List<String> shortLanguageList = [
    "ara",
    "ben",
    "eng",
    "fra",
    "ind",
    "tam",
    "tur",
    "urd"
  ];

  List<Locale> shortestLanguageList = [
    Locale("ar"),
    Locale("bn"),
    Locale("en"),
    Locale("fr"),
    Locale("id"),
    Locale("ta"),
    Locale("tr"),
    Locale("ur"),
  ];

  List<String> longTranslatedLanguageList = [
    "العربية",
    "বাংলা",
    "English",
    "Français",
    "Bahasa Indonesia",
    "தமிழ்",
    "Türkçe",
    "اردو"
  ];

  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String hadithLanguage = LanguageHelper.getLanguageName(
      SharedPreferencesHelper.getString("hadithLanguage", "eng"));

  bool expandGrades = SharedPreferencesHelper.getBool("expandGrades", false);
  bool isCheckedArabic = SharedPreferencesHelper.getBool("displayArabic", true);
  bool isCheckedTranslation =
      SharedPreferencesHelper.getBool("displayTranslation", true);
  double sliderArabicSize =
      SharedPreferencesHelper.getDouble("textSizeArabic", 20);
  double sliderTranslationSize =
      SharedPreferencesHelper.getDouble("textSizeTranslation", 20);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings_title_main),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Text(
                AppLocalizations.of(context)!.settings_title_language,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: Text(
                  AppLocalizations.of(context)!
                      .settings_subtitle_hadithlanguage,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                subtitle: Text(hadithLanguage),
                onTap: () {
                  setState(() {
                    _showBottomSheetLanguage();
                  });
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Text(
                AppLocalizations.of(context)!.settings_title_appearance,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: SwitchListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  title: Text(
                    AppLocalizations.of(context)!
                        .settings_subtitle_expandgrades,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  value: SharedPreferencesHelper.getBool("expandGrades", false),
                  onChanged: (bool? value) {
                    setState(() {
                      SharedPreferencesHelper.setBool("expandGrades", value!);
                    });
                  }),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: SwitchListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  title: Text(
                    AppLocalizations.of(context)!
                        .settings_subtitle_displayarabictext,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  value: SharedPreferencesHelper.getBool("displayArabic", true),
                  onChanged: (bool? value) {
                    setState(() {
                      SharedPreferencesHelper.setBool("displayArabic", value!);
                    });
                  }),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: SwitchListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  value: SharedPreferencesHelper.getBool(
                      "displayTranslation", true),
                  title: Text(
                    AppLocalizations.of(context)!
                        .settings_subtitle_displaytranslationtext,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onChanged: (bool? value) {
                    setState(() {
                      SharedPreferencesHelper.setBool(
                          "displayTranslation", value!);
                    });
                  }),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: Text(
                  AppLocalizations.of(context)!
                      .settings_subtitle_displayarabictextsize,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                subtitle: Text(sliderArabicSize.toString()),
                onTap: () {
                  setState(() {
                    _showBottomSheetArabic();
                  });
                },
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: Text(
                  AppLocalizations.of(context)!
                      .settings_subtitle_displaytranslationtextsize,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                subtitle: Text(sliderTranslationSize.toString()),
                onTap: () {
                  setState(() {
                    _showBottomSheetTranslation();
                  });
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Text(
                AppLocalizations.of(context)!.settings_title_information,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: Text(
                  AppLocalizations.of(context)!.settings_subtitle_website,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.web),
                onTap: () async {
                  final uri = Uri.parse("https://www.hadithhub.com/");
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else {
                    throw 'Could not launch $uri';
                  }
                  setState(() {
                    // update the widget state here, if needed
                  });
                },
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: Text(
                  AppLocalizations.of(context)!.settings_subtitle_sourcecode,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.source),
                onTap: () async {
                  final uri = Uri.parse("https://www.example.com/");
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else {
                    throw 'Could not launch $uri';
                  }
                  setState(() {
                    // update the widget state here, if needed
                  });
                },
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: Text(
                  "Still in development!",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.warning),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          AppLocalizations.of(context)!
                              .settings_subtitle_development_dialog_title,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Text(AppLocalizations.of(context)!
                            .settings_subtitle_development_dialog),
                        actions: [
                          TextButton(
                            child: Center(
                                child: Text(AppLocalizations.of(context)!
                                    .settings_subtitle_development_dialog_accept)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheetLanguage() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!
                        .settings_subtitle_hadithlanguage,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.shortLanguageList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: widget.shortLanguageList[index].contains(
                                SharedPreferencesHelper.getString(
                                    "hadithLanguage", "eng"))
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.surface,
                        elevation: 0,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          trailing: Text(
                            widget.longTranslatedLanguageList[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: widget.shortLanguageList[index].contains(
                                      SharedPreferencesHelper.getString(
                                          "hadithLanguage", "eng"))
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          title: Text(
                            widget.longLanguageList[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: widget.shortLanguageList[index].contains(
                                      SharedPreferencesHelper.getString(
                                          "hadithLanguage", "eng"))
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              SharedPreferencesHelper.setString(
                                  "hadithLanguage",
                                  widget.shortLanguageList[index]);
                              MyApp.setLocale(
                                  context, widget.shortestLanguageList[index]);
                            });

                            updateSubtitleHadithLanguage(
                                widget.longTranslatedLanguageList[index]);
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            );
          },
        );
      },
    );
  }

  void _showBottomSheetArabic() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!
                          .settings_subtitle_displayarabictextsize,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'إِنَّ أَبْغَضَ الرِّجَالِ إِلَى اللَّهِ الأَلَدُّ الْخَصِمُ',
                      style: TextStyle(
                          fontSize: sliderArabicSize, fontFamily: 'Uthman'),
                    ),
                  ),
                  Spacer(),
                  Slider(
                    max: 30,
                    divisions: 15,
                    label: sliderArabicSize.round().toString(),
                    value: sliderArabicSize,
                    onChanged: (double value) {
                      setState(() {
                        updateSubtitleTextArabic(value);
                      });
                    },
                    onChangeEnd: (double value) {
                      SharedPreferencesHelper.setDouble(
                          "textSizeArabic", value);
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 16.0), // Add some spacing at the bottom
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showBottomSheetTranslation() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!
                          .settings_subtitle_displaytranslationtextsize,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'The most hated person in the sight of Allah is the most quarrelsome person.',
                      style: TextStyle(
                          fontSize: sliderTranslationSize,
                          fontFamily: 'Uthman'),
                    ),
                  ),
                  Spacer(),
                  Slider(
                    max: 30,
                    divisions: 15,
                    label: sliderTranslationSize.round().toString(),
                    value: sliderTranslationSize,
                    onChanged: (double value) {
                      setState(() {
                        updateSubtitleTextTranslation(value);
                      });
                    },
                    onChangeEnd: (double value) {
                      SharedPreferencesHelper.setDouble(
                          "textSizeTranslation", value);
                      Navigator.pop(context); // close the bottom sheet
                    },
                  ),
                  SizedBox(height: 16.0), // Add some spacing at the bottom
                ],
              ),
            );
          },
        );
      },
    );
  }

  void updateSubtitleHadithLanguage(String value) {
    setState(() {
      hadithLanguage = value;
    });
  }

  void updateSubtitleTextArabic(double value) {
    setState(() {
      sliderArabicSize = value.roundToDouble();
    });
  }

  void updateSubtitleTextTranslation(double value) {
    setState(() {
      sliderTranslationSize = value.roundToDouble();
    });
  }

  void updateSubtitleSizeTextTranslation(double value) {
    setState(() {
      sliderTranslationSize = value.roundToDouble();
    });
  }
}
