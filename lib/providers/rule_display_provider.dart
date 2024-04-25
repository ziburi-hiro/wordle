import 'package:flutter/material.dart';

class RuleDisplayProvider extends ChangeNotifier {

  bool isDisplay = false;

  setRuleDisplay({required bool turnOn}){
    isDisplay = turnOn;
    notifyListeners();
  }
}