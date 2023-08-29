import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/colors.dart';
import 'package:wordle/controller.dart';
import 'package:wordle/providers/theme_provider.dart';
import 'package:wordle/screen/home_page.dart';
import 'package:wordle/themes/themes.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Controller()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, notifier, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wordle demo',
        theme: notifier.isDark ? darkTheme : lightTheme,
        home: const HomePage(),
      ),
    );
  }
}
