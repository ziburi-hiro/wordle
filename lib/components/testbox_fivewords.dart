import 'package:flutter/material.dart';
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

    return AlertDialog(
      content: Consumer<Controller>(
        builder: (_ , notifier , __) {
          return SizedBox(
            width: size.width*0.8,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Five Characters',style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 26,
                ),),

                const Text('Test random 10 words \n from your checklist!',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),

                FutureBuilder(
                    future: CheckListPreferencesFiveWords.getCheckListFiveWords(),
                    builder: (context, snapshot) {
                      List<String> checkList = [];
                      if (snapshot.hasData) {
                        checkList = snapshot.data as List<String>;
                      }
                      return SizedBox(
                        width: size.width*0.6,
                        height: size.height*0.06,
                        child: ElevatedButton(
                          onPressed: () {
                            if(checkList.isEmpty){
                              Navigator.of(context).pop();
                              print('No word in checklist');
                            }else{
                              notifier.testInit(list: checkList);
                              notifier.choiceTestWord(list: checkList);
                              notifier.makePositionNum(list: checkList);
                              notifier.makeFakeWordListFiveWords(list: checkList);
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (
                                      context) => const RandomWordTestFiveWordsPage()));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )
                          ),
                          child: const Text('Start Test', style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                      );
                    }
                )
              ],
            ),
          );
        },
      ),
    );
  }
}