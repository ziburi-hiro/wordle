import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier{

  bool quizMode = false;

  setQuizMode({required bool turnOn}){
    quizMode = turnOn;
    notifyListeners();
  }
}