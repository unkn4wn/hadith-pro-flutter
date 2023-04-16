import 'package:flutter/material.dart';
import 'package:hadithpro/helper/languagehelper.dart';
import 'package:hadithpro/helper/sharedpreferenceshelper.dart';
import 'package:hadithpro/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  final List<String> longLanguageList = [
    "Arabic",
    "Bengali",
    "English",
    "French",
    "Indonesian",
    "Tamil",
    "Turkish",
    "Urdu"
  ];

  final List<String> shortLanguageList = [
    "ara",
    "ben",
    "eng",
    "fra",
    "ind",
    "tam",
    "tur",
    "urd"
  ];

  final List<Locale> shortestLanguageList = [
    const Locale("ar"),
    const Locale("bn"),
    const Locale("en"),
    const Locale("fr"),
    const Locale("id"),
    const Locale("ta"),
    const Locale("tr"),
    const Locale("ur"),
  ];

  final List<String> longTranslatedLanguageList = [
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
      SharedPreferencesHelper.getDouble("textSizeArabic", 18);
  double sliderTranslationSize =
      SharedPreferencesHelper.getDouble("textSizeTranslation", 18);

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
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Text(
                AppLocalizations.of(context)!.settings_title_language,
                style: const TextStyle(
                    fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: Text(
                  AppLocalizations.of(context)!
                      .settings_subtitle_hadithlanguage,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                subtitle: Text(hadithLanguage),
                onTap: () {
                  setState(() {
                    _showBottomSheetLanguage();
                  });
                },
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Text(
                AppLocalizations.of(context)!.settings_title_appearance,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: SwitchListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  title: Text(
                    AppLocalizations.of(context)!
                        .settings_subtitle_expandgrades,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  value: SharedPreferencesHelper.getBool("expandGrades", false),
                  onChanged: (bool? value) {
                    setState(() {
                      SharedPreferencesHelper.setBool("expandGrades", value!);
                    });
                  }),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: SwitchListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  title: Text(
                    AppLocalizations.of(context)!
                        .settings_subtitle_displayarabictext,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  value: SharedPreferencesHelper.getBool("displayArabic", true),
                  onChanged: (bool? value) {
                    setState(() {
                      SharedPreferencesHelper.setBool("displayArabic", value!);
                    });
                  }),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: SwitchListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  value: SharedPreferencesHelper.getBool(
                      "displayTranslation", true),
                  title: Text(
                    AppLocalizations.of(context)!
                        .settings_subtitle_displaytranslationtext,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onChanged: (bool? value) {
                    setState(() {
                      SharedPreferencesHelper.setBool(
                          "displayTranslation", value!);
                    });
                  }),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: Text(
                  AppLocalizations.of(context)!
                      .settings_subtitle_displayarabictextsize,
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: Text(
                  AppLocalizations.of(context)!
                      .settings_subtitle_displaytranslationtextsize,
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Text(
                AppLocalizations.of(context)!.settings_title_information,
                style: const TextStyle(
                    fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: Text(
                  AppLocalizations.of(context)!.settings_subtitle_website,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.web),
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
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: Text(
                  AppLocalizations.of(context)!.settings_subtitle_sourcecode,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.source),
                onTap: () async {
                  final uri = Uri.parse("https://www.example.com/");
                  //TODO ADD GITHUB SOURCE
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
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: const Text(
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
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheetLanguage() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!
                        .settings_subtitle_hadithlanguage,
                    style: const TextStyle(
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
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
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
                const SizedBox(
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
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!
                          .settings_subtitle_displayarabictextsize,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'إِنَّ أَبْغَضَ الرِّجَالِ إِلَى اللَّهِ الأَلَدُّ الْخَصِمُ',
                      style: TextStyle(
                          fontSize: sliderArabicSize, fontFamily: 'Uthman'),
                    ),
                  ),
                  const Spacer(),
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
                  const SizedBox(
                      height: 16.0), // Add some spacing at the bottom
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
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!
                          .settings_subtitle_displaytranslationtextsize,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'The most hated person in the sight of Allah is the most quarrelsome person.',
                      style: TextStyle(
                          fontSize: sliderTranslationSize,
                          fontFamily: 'Uthman'),
                    ),
                  ),
                  const Spacer(),
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
                  const SizedBox(
                      height: 16.0), // Add some spacing at the bottom
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
