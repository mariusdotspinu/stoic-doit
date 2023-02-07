import 'package:ad_como/provider/dark_theme_provider.dart';
import 'package:ad_como/screens/main_screen.dart';
import 'package:ad_como/utils/quote_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatefulWidget {
  const MyApp({Key, key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Home();
}

class Home extends State<MyApp> {
  late Future<Quote> quote;
  DarkThemeProvider themeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    quote = QuoteUtils.fetchRandomStoicQuote();
    getAppTheme();
  }

  void getAppTheme() async {
    themeProvider.darkTheme =
        await themeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return MaterialApp(
            theme: ThemeData(
              brightness: Brightness.light,
              /* light theme settings */
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              /* dark theme settings */
            ),
            themeMode: ThemeMode.dark,
            /* ThemeMode.system to follow system theme,
         ThemeMode.light for light theme,
         ThemeMode.dark for dark theme
      */
            home: Primary(quote: quote),
          );
        },
      ),
    );
  }
}
