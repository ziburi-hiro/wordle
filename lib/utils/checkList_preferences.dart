import 'package:shared_preferences/shared_preferences.dart';

class CheckListPreferences{

  static saveCheckList({required List<String> list}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('CheckList', list);
  }

  static Future<List<String>?> getCheckList() async {

    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('CheckList');

  }

}