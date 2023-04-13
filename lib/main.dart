import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hadithpro/helper/sharedpreferenceshelper.dart';
import 'package:hadithpro/l10n/l10n.dart';
import 'package:hadithpro/screens/bookmarks/bookmarks_screen.dart';
import 'package:hadithpro/screens/home/books_screen.dart';
import 'package:hadithpro/screens/intro/onboarding_screen.dart';
import 'package:hadithpro/screens/search/search_screen.dart';
import 'package:hadithpro/screens/settings/settings_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  final isFirstStart = SharedPreferencesHelper.getBool('isFirstStart', true);
  if (isFirstStart) {
    SharedPreferencesHelper.resetSharedPreferences();
    print("RESET SHARE");
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

        AppBarTheme? lightAppBarTheme;
        AppBarTheme? darkAppBarTheme;

        BottomNavigationBarTheme? lightBottomNavigationBarTheme;
        BottomNavigationBarTheme? darkBottomNavigationBarTheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightColorScheme = lightDynamic.harmonized();
          lightAppBarTheme = null;

          darkColorScheme = darkDynamic.harmonized();
          darkAppBarTheme = null;
        } else {
          lightColorScheme = ColorScheme(
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
          lightAppBarTheme = AppBarTheme(
            backgroundColor: Color(0xFF50A89B),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            toolbarTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          );

          darkColorScheme = ColorScheme(
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
          darkAppBarTheme = AppBarTheme(
            backgroundColor: Color(0xFF3a7b6d),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            toolbarTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
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
              ? OnBoardingScreen()
              : MainPage(),
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
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: AppLocalizations.of(context)!.bottomnavigation_title_home,
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: AppLocalizations.of(context)!.bottomnavigation_title_search,
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label:
                AppLocalizations.of(context)!.bottomnavigation_title_bookmarks,
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label:
                AppLocalizations.of(context)!.bottomnavigation_title_settings,
          ),
        ],
      ),
    );
  }
}
