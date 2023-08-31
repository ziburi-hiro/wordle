import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/providers/theme_provider.dart';
import 'package:wordle/themes/theme_preferences.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.maybePop(context);
              },
              icon: Icon(Icons.clear)
          )
        ],
      ),
      body: Column(
        children: [
          Consumer<ThemeProvider>(
            builder: (_ , notifier, __){
              bool _isSwitched = false;
              _isSwitched = notifier.isDark;

              return SwitchListTile(
                value: _isSwitched,
                onChanged: (value){
                  _isSwitched = value;
                  ThemePreferences.saveTheme(isDark: _isSwitched);
                  Provider.of<ThemeProvider>(context,listen: false).setTheme(turnOn: _isSwitched);
                },
              );
            },
          )
        ],
      ),
    );
  }
}
