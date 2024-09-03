import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle/utils/quick_box.dart';

class ResetStatisticsBox extends StatelessWidget {
  const ResetStatisticsBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Reset Statistics?',
        style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 22
        ),
      ),
      content: const Text('Do you really want to reset the statistics?',style: TextStyle(
        fontSize: 16,
      ),),
      actions: [
        CupertinoDialogAction(child: const Text('NO'),
          onPressed: (){
            Navigator.pop(context);
          },),
        CupertinoDialogAction(child: const Text('YES'),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.remove('stats');
            prefs.remove('chart');
            prefs.remove('row');
            prefs.remove('stats_five_words');
            prefs.remove('chart_five_words');
            prefs.remove('row_five_words');
            runQuickBox(context: context, message: 'Statistics Reset');
            Navigator.pop(context);
        },),

      ],
    );
  }
}
