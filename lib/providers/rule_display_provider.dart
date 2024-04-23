import 'package:flutter/material.dart';

class RuleDisplayProvider extends ChangeNotifier {

  bool isDisplay = true;

  setRuleDisplay({required bool turnOn}){
    isDisplay = turnOn;
    notifyListeners();
  }
}