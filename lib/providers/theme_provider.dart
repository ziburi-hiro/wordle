import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {

  bool isDark = false;

  setTheme(){
    isDark = !isDark;
    notifyListeners();
  }
}