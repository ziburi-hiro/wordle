import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle/components/reset_statistics_box.dart';
import 'package:wordle/providers/quiz_provider.dart';
import 'package:wordle/providers/theme_provider.dart';
import 'package:wordle/utils/quick_box.dart';
import 'package:wordle/utils/quiz_preferences.dart';
import 'package:wordle/utils/theme_preferences.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                title: const Text('Dark Theme',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
                value: isSwitched,
                onChanged: (value){
                  isSwitched = value;
                  ThemePreferences.saveTheme(isDark: isSwitched);
                  Provider.of<ThemeProvider>(context,listen: false).setTheme(turnOn: isSwitched);
                },
              );
            },
          ),

          Consumer<ThemeProvider>(
            builder: (_ , notifier ,__) {
              return ElevatedButton(
                onPressed: () async {
                  showDialog(context: context, builder: (_) => const ResetStatisticsBox());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  fixedSize: Size(size.width * 0.7, size.height * 0.06),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  side: BorderSide(
                    width: 5,
                    color: notifier.isDark ? Colors.white : Colors.grey,
                  )
                ),
                child: const Text('Reset Statistics',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              );
            },
          ),
        ],
      ),
    );
  }
}
