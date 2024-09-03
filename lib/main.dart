import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/providers/quiz_provider.dart';
import 'package:wordle/providers/rule_display_provider.dart';
import 'package:wordle/providers/theme_provider.dart';
import 'package:wordle/screen/game_page.dart';
import 'package:wordle/screen/home_page.dart';
import 'package:wordle/utils/rule_preferences.dart';
import 'package:wordle/utils/theme_preferences.dart';
import 'package:wordle/constants/themes.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Controller()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => RuleDisplayProvider()),
      ],
      child: FutureBuilder(
        initialData: false,
        future: ThemePreferences.getTheme(),
        builder:(context,snapshot) {
          if(snapshot.hasData){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Provider.of<ThemeProvider>(context, listen: false).setTheme(turnOn: snapshot.data as bool);
            });
          }
          return Consumer<ThemeProvider>(
            builder: (_, notifier, __) => MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorObservers: [routeObserver],
              title: 'Wordle demo',
              theme: notifier.isDark ? darkTheme : lightTheme,
              home: const HomePage(),
            ),
          );
        },
      ),
    );
  }
}
