import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle/utils/quick_box.dart';

class ResetStatisticsBox extends StatelessWidget {
  const ResetStatisticsBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Text('成績のリセット',style: GoogleFonts.mPlusRounded1c(
                fontSize: 22,
                fontWeight: FontWeight.bold
            ),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'これまでの成績をリセットしますか？\nリセットすると元には戻せません',
              textAlign: TextAlign.center,
              style: GoogleFonts.mPlusRounded1c(
                  fontSize: 16,
                  color: Colors.grey
              ),
            ),
          ),

          const SizedBox(height: 24,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  elevation: 5,
                  shape: const StadiumBorder(),
                ),
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 18,
                  ),
                  child: Text(
                    'いいえ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 5,
                  shape: const StadiumBorder(),
                ),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.remove('stats');
                  prefs.remove('chart');
                  prefs.remove('row');
                  prefs.remove('stats_five_words');
                  prefs.remove('chart_five_words');
                  prefs.remove('row_five_words');
                  runQuickBox(context: context, message: '成績をリセットしました');
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 18,
                  ),
                  child: Text(
                    'はい',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24,),
        ],
      ),
    );
  }
}
