import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle/providers/theme_provider.dart';
import 'package:wordle/utils/quick_box.dart';
import 'package:wordle/utils/theme_preferences.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.maybePop(context);
              },
              icon: const Icon(Icons.clear)
          )
        ],
      ),
      body: Column(
        children: [
          Consumer<ThemeProvider>(
            builder: (_ , notifier, __){
              bool isSwitched = false;
              isSwitched = notifier.isDark;

              return SwitchListTile(
                title: const Text('Dark Theme'),
                value: isSwitched,
                onChanged: (value){
                  isSwitched = value;
                  ThemePreferences.saveTheme(isDark: isSwitched);
                  Provider.of<ThemeProvider>(context,listen: false).setTheme(turnOn: isSwitched);
                },
              );
            },
          ),
          ListTile(
            title: const Text('Reset Statistics'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.remove('stats');
              prefs.remove('chart');
              prefs.remove('row');
              prefs.remove('stats_five_words');
              prefs.remove('chart_five_words');
              prefs.remove('row_five_words');
              runQuickBox(context: context, message: 'Statistics Reset');
            },
          )
        ],
      ),
    );
  }
}
