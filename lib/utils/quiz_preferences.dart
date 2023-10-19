import 'package:shared_preferences/shared_preferences.dart';

class QuizPreferences{

  static saveQuizMode({required bool isQuizMode}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('quizMode', isQuizMode);

  }

  static Future<bool> getQuizMode() async {

    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('quizMode') ?? false;

  }
}