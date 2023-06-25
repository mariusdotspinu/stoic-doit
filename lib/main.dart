import 'package:ad_como/provider/dark_theme_provider.dart';
import 'package:ad_como/screens/main_screen.dart';
import 'package:ad_como/shared_preferences/preferences.dart';
import 'package:ad_como/utils/quote_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferencesUtils.prefs = await SharedPreferences.getInstance();
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
    quote = QuoteUtils.fetchRandomStoicQuote(context);
    themeProvider.darkTheme = SharedPreferencesUtils.getTheme();
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
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
            ),
            themeMode: ThemeMode.dark,
            home: Primary(quote: quote),
          );
        },
      ),
    );
  }
}
