import 'package:shared_preferences/shared_preferences.dart';

class RulePreferences{

  static saveRuleCheckBox({required bool checkBox}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('RuleCheckBox', checkBox);
  }

  static Future<bool> getRuleCheckBox() async {

    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('RuleCheckBox') ?? false;

  }

}