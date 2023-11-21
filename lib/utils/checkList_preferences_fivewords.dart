import 'package:shared_preferences/shared_preferences.dart';

class CheckListPreferencesFiveWords{

  static saveCheckListFiveWords({required List<String> list}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('CheckListFiveWords', list);
  }

  static Future<List<String>?> getCheckListFiveWords() async {

    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('CheckListFiveWords');

  }

}