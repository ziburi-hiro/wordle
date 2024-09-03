import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/screen/random_word_test_fivewords_page.dart';
import 'package:wordle/screen/random_word_test_page.dart';
import 'package:wordle/utils/checkList_preferences.dart';
import 'package:wordle/utils/checkList_preferences_fivewords.dart';
import 'package:wordle/utils/quick_box.dart';

class TestBoxFiveWords extends StatefulWidget {
  const TestBoxFiveWords({super.key});

  @override
  State<TestBoxFiveWords> createState() => _TestBoxFiveWordsState();
}

class _TestBoxFiveWordsState extends State<TestBoxFiveWords> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Consumer<Controller>(
          builder: (_ , notifier , __) {
            return SizedBox(
              width: size.width*0.8,
              height: size.height*0.25,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Text('5文字の英単語テスト',style: GoogleFonts.mPlusRounded1c(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    ),),
                  ),

                  FutureBuilder(
                      future: CheckListPreferencesFiveWords.getCheckListFiveWords(),
                      builder: (context, snapshot) {
                        List<String> checkList = [];
                        if (snapshot.hasData) {
                          checkList = snapshot.data as List<String>;
                        }
                        return Column(
                          children: [
                            (checkList.length > 9) ?
                            Text('単語帳からランダムで \n 10単語出題します',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mPlusRounded1c(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),)
                                :
                            Text('単語帳からランダムで \n ${checkList.length}単語出題します',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mPlusRounded1c(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),),

                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: SizedBox(
                                width: size.width*0.6,
                                height: size.height*0.06,
                                child: ElevatedButton(
                                  onPressed: () {
                                    notifier.testInit(list: checkList);
                                    notifier.choiceTestWord(list: checkList);
                                    notifier.makePositionNum(list: checkList);
                                    notifier.makeFakeWordListFiveWords(list: checkList);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (
                                            context) => const RandomWordTestFiveWordsPage()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )
                                  ),
                                  child: Text('テスト開始', style: GoogleFonts.mPlusRounded1c(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}