import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wordle/components/reset_statistics_box.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/providers/rule_display_provider.dart';
import 'package:wordle/providers/theme_provider.dart';
import 'package:wordle/utils/rule_preferences.dart';
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
      body: ScreenUtilInit(
        designSize: const Size(393, 852),
        child: Column(
          children: [
            Consumer<ThemeProvider>(
              builder: (_ , notifier, __){
                bool isSwitched = false;
                isSwitched = notifier.isDark;

                return SwitchListTile(
                  title: Text('Dark Theme',style: TextStyle(
                    fontSize: 20.sp,
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

            FutureBuilder(
              future: RulePreferences.getRuleCheckBox(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    Provider.of<RuleDisplayProvider>(context, listen: false).setRuleDisplay(turnOn: snapshot.data as bool);
                  });
                }
                return Consumer<RuleDisplayProvider>(
                  builder: (_ , notifier, __){
                    bool isSwitched = false;
                    isSwitched = notifier.isDisplay;

                    return SwitchListTile(
                      title: Text('Not Display Rule',style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),),
                      value: isSwitched,
                      onChanged: (value){
                        isSwitched = value;
                        RulePreferences.saveRuleCheckBox(checkBox: isSwitched);
                        Provider.of<RuleDisplayProvider>(context,listen: false).setRuleDisplay(turnOn: isSwitched);
                        Provider.of<Controller>(context,listen: false).ruleDisplayCheck = isSwitched;
                      },
                    );
                  },
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Consumer<ThemeProvider>(
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
                    child: Text('Reset Statistics',style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
