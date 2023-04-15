import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:hadithpro/helper/sharedpreferenceshelper.dart';
import 'package:hadithpro/screens/bookmarks/bookmarks_screen.dart';
import 'package:hadithpro/screens/home/books_screen.dart';
import 'package:hadithpro/screens/intro/onboarding_screen.dart';
import 'package:hadithpro/screens/random/random_screen.dart';
import 'package:hadithpro/screens/search/search_screen.dart';
import 'package:hadithpro/screens/settings/settings_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  final isFirstStart = SharedPreferencesHelper.getBool('isFirstStart', true);
  if (isFirstStart) {
    SharedPreferencesHelper.resetSharedPreferences();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  setLocale(Locale locale) {
    setState(() {});
  }

  final Map<String, Locale> localeMap = {
    "ara": const Locale("ar"),
    "ben": const Locale("bn"),
    "eng": const Locale("en"),
    "fra": const Locale("fr"),
    "ind": const Locale("id"),
    "tam": const Locale("ta"),
    "tur": const Locale("tr"),
    "urd": const Locale("ur")
  };

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightColorScheme = lightDynamic.harmonized();

          darkColorScheme = darkDynamic.harmonized();
        } else {
          lightColorScheme = const ColorScheme(
            primary: Color(0xFF50A89B),
            secondary: Color(0xFF50A89B),
            background: Color(0xFFFFFFFF),
            surface: Color(0xFFf5f6f8),
            tertiary: Color(0xfff1ebe1),
            error: Colors.red,
            onBackground: Color(0xFF48454f),
            onSurface: Color(0xFF48454f),
            onTertiary: Color(0xFF48454f),
            onError: Colors.white,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            brightness: Brightness.light,
          );

          darkColorScheme = const ColorScheme(
            primary: Color(0xFF3a7b6d),
            secondary: Color(0xFF3a7b6d),
            background: Color(0xFF000000),
            surface: Color(0xFF1C1B1F),
            tertiary: Color(0xfff1ebe1),
            error: Colors.red,
            onBackground: Color(0xFFCCD1E6),
            onSurface: Color(0xFFCCD1E6),
            onTertiary: Color(0xFF49454F),
            onError: Colors.white,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hadith Pro',
          themeMode: ThemeMode.system,
          theme: ThemeData(
              dividerColor:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
              colorScheme: lightColorScheme,
              useMaterial3: true,
              dividerTheme: DividerThemeData(
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
              )),
          darkTheme:
              ThemeData.from(colorScheme: darkColorScheme, useMaterial3: true)
                  .copyWith(
            dividerColor:
                Theme.of(context).colorScheme.outlineVariant.withOpacity(0.12),
            brightness: Brightness.dark,
            dividerTheme: DividerThemeData(
              color: Theme.of(context)
                  .colorScheme
                  .outlineVariant
                  .withOpacity(0.12),
            ),
          ),
          home: SharedPreferencesHelper.getBool('isFirstStart', true)
              ? const OnBoardingScreen()
              : const MainPage(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeMap[
                  SharedPreferencesHelper.getString("hadithLanguage", "eng")] ??
              const Locale("en"),
        );
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const BooksScreen(),
    const SearchScreen(),
    const BookmarksScreen(),
    const RandomScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(currentPageIndex),
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: const Icon(Icons.home),
            icon: const Icon(Icons.home_outlined),
            label: AppLocalizations.of(context)!.bottomnavigation_title_home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.search),
            label: AppLocalizations.of(context)!.bottomnavigation_title_search,
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.bookmark),
            icon: const Icon(Icons.bookmark_border),
            label:
                AppLocalizations.of(context)!.bottomnavigation_title_bookmarks,
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.question_mark),
            icon: const Icon(Icons.question_mark_outlined),
            label: AppLocalizations.of(context)!.bottomnavigation_title_random,
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.settings),
            icon: const Icon(Icons.settings_outlined),
            label:
                AppLocalizations.of(context)!.bottomnavigation_title_settings,
          ),
        ],
      ),
    );
  }
}
