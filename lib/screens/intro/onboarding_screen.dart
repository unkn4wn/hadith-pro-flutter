import 'package:flutter/material.dart';
import 'package:hadithpro/helper/bookhelper.dart';
import 'package:hadithpro/helper/sharedpreferenceshelper.dart';
import 'package:hadithpro/main.dart';
import 'package:hadithpro/screens/settings/settings_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;

  int _pageIndex = 0;
  List<Onboard> demoData = [];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    demoData = [
      Onboard(
        image: "assets/onboarding/language.json",
        title: AppLocalizations.of(context)!.intro_first_title,
        description: SettingsScreen().longLanguageList,
        description2: SettingsScreen().longTranslatedLanguageList,
      ),
      Onboard(
        image: "assets/onboarding/books.json",
        title: AppLocalizations.of(context)!.intro_second_title,
        description: BookHelper.longNamesList(context),
        description2: [],
      ),
      Onboard(
        image: "assets/onboarding/grades.json",
        title: AppLocalizations.of(context)!.intro_third_title,
        description: [
          "Abu Ghuddah",
          "Al-Albani",
          "Muhammad Fouad Abd al-Baqi",
          "Muhammad Muhyi Al-Din Abdul Hamid",
          "Salim al-Hilali",
          "Shuaib Al Arnaut",
          "Zubair Ali Zai"
        ],
        description2: [],
      ),
      Onboard(
        image: "assets/onboarding/issues.json",
        title: AppLocalizations.of(context)!.intro_fourth_title,
        description: [
          AppLocalizations.of(context)!.intro_fourth_hadith,
          AppLocalizations.of(context)!.intro_fourth_grades
        ],
        description2: [],
      ),
    ];
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: demoData.length,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                itemBuilder: (context, index) => OnboardContent(
                  image: demoData[index].image,
                  title: demoData[index].title,
                  description: demoData[index].description,
                  description2: demoData[index].description2,
                  isLanguageScreen: index == 0 ? true : false,
                ),
              ),
            ),
            Row(
              children: [
                ...List.generate(
                    demoData.length,
                    (index) => Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: DotIndicator(
                            isActive: index == _pageIndex,
                          ),
                        )),
                const Spacer(),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_pageController.page!.round() != 3) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      } else {
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
                                    SharedPreferencesHelper.setBool(
                                        "isFirstStart", false);
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst);
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MainPage()));
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Icon(Icons.arrow_forward),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    this.isActive = false,
    super.key,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.primary.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class Onboard {
  final String image, title;
  final List<String> description;
  final List<String> description2;

  Onboard({
    required this.image,
    required this.title,
    required this.description,
    required this.description2,
  });
}

class OnboardContent extends StatefulWidget {
  const OnboardContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.description2,
    required this.isLanguageScreen,
  });

  final bool isLanguageScreen;
  final String image, title;
  final List<String> description;
  final List<String> description2;

  @override
  State<OnboardContent> createState() => _OnboardContentState();
}

class _OnboardContentState extends State<OnboardContent> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return Column(
        children: [
          Lottie.asset(
            widget.image,
            height: 200,
            repeat: false,
          ),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
              child: ListView.builder(
                  shrinkWrap: false,
                  itemCount: widget.description.length,
                  itemBuilder: (context, index) {
                    if (widget.isLanguageScreen) {
                      return Card(
                        color: SettingsScreen()
                                .shortLanguageList[index]
                                .contains(SharedPreferencesHelper.getString(
                                    "hadithLanguage", "eng"))
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.surface,
                        child: ListTile(
                          title: Text(
                            widget.description[index],
                            style: TextStyle(
                              color: SettingsScreen()
                                      .shortLanguageList[index]
                                      .contains(
                                          SharedPreferencesHelper.getString(
                                              "hadithLanguage", "eng"))
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          trailing: Text(
                            widget.description2[index],
                            style: TextStyle(
                              color: SettingsScreen()
                                      .shortLanguageList[index]
                                      .contains(
                                          SharedPreferencesHelper.getString(
                                              "hadithLanguage", "eng"))
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          onTap: () {
                            print(index);
                            SharedPreferencesHelper.setString("hadithLanguage",
                                SettingsScreen().shortLanguageList[index]);
                            MyApp.setLocale(context,
                                SettingsScreen().shortestLanguageList[index]);
                            print(SharedPreferencesHelper.getString(
                                "hadithLanguage", "eng"));
                            setState(() {});
                          },
                        ),
                      );
                    } else {
                      return Card(
                        child: ListTile(
                          title: Text(
                            widget.description[index],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                  })),
        ],
      );
    });
  }
}
