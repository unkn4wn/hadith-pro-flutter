import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hadithpro/helper/sharedpreferenceshelper.dart';
import 'package:hadithpro/l10n/l10n.dart';
import 'package:hadithpro/screens/bookmarks/bookmarks_screen.dart';
import 'package:hadithpro/screens/home/books_screen.dart';
import 'package:hadithpro/screens/search/search_screen.dart';
import 'package:hadithpro/screens/settings/settings_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  final isFirstStart = SharedPreferencesHelper.getBool('isFirstStart', true);
  if (isFirstStart) {
    await SharedPreferencesHelper.setFirstStart();
    print("FIRST START");
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  final Map<String, Locale> localeMap = {
    "ara": Locale("ar"),
    "ben": Locale("bn"),
    "eng": Locale("en"),
    "fra": Locale("fr"),
    "ind": Locale("id"),
    "tam": Locale("ta"),
    "tur": Locale("tr"),
    "urd": Locale("ur")
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
          lightColorScheme = ColorScheme.fromSeed(
            seedColor: Color(0xFF609D92),
          );
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: Color(0xFF609D92),
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bottom Nac',
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
                      dividerColor: Theme.of(context)
                          .colorScheme
                          .outlineVariant
                          .withOpacity(0.12),
                      brightness: Brightness.dark,
                      dividerTheme: DividerThemeData(
                        color: Theme.of(context)
                            .colorScheme
                            .outlineVariant
                            .withOpacity(0.12),
                      )),
          home: MainPage(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeMap[
                  SharedPreferencesHelper.getString("hadithLanguage", "eng")] ??
              Locale("en"),
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
    BooksScreen(),
    SearchScreen(),
    BookmarksScreen(),
    SettingsScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

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
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: 'Saved',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
