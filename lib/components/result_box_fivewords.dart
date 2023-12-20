import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/data/key_map.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/screen/five_words_wordle.dart';
import 'package:wordle/screen/home_page.dart';
import 'package:wordle/utils/checkList_preferences_fivewords.dart';

class ResultBoxFiveWords extends StatefulWidget {
  const ResultBoxFiveWords({Key? key}) : super(key: key);

  @override
  State<ResultBoxFiveWords> createState() => _ResultBoxFiveWordsState();
}

class _ResultBoxFiveWordsState extends State<ResultBoxFiveWords> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: AlertDialog(
        insetPadding: EdgeInsets.fromLTRB(size.width * 0.02, size.height * 0.05, size.width * 0.02, size.height * 0.05),
        content: Consumer<Controller>(
          builder: (_, notifier, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IconButton(
                    alignment: Alignment.centerRight,
                    onPressed: (){
                      Navigator.maybePop(context);
                    },
                    icon: const Icon(Icons.clear)
                ),
                Expanded(
                    child: Text('RESULTS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w900
                      ),
                    )
                ),

                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Text('Correct Word',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(notifier.correctWord.toLowerCase(),
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold
                        ),),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Text('Mean',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold
                        ),),
                      Text(notifier.meanList_5words[0],
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold
                        ),),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Text('Parts of Speech',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold
                        ),),
                      Text(notifier.meanList_5words[1],
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder(
                        future: CheckListPreferencesFiveWords.getCheckListFiveWords(),
                        builder: (context, snapshot) {
                          List<String> checkListFiveWords = [];
                          if(snapshot.hasData){
                            checkListFiveWords = snapshot.data as List<String>;
                          }
                          return Transform.scale(
                            scale: 1.0.sp,
                            child: Checkbox(
                              activeColor: Colors.green,
                              value: notifier.addListCheck,
                              onChanged: (bool? value) {
                                setState(() {
                                  notifier.addListCheck = value!;
                                });
                                if (notifier.addListCheck == true) {
                                  notifier.addCheckListFiveWords(
                                      word: notifier.correctWord.toLowerCase(), list: checkListFiveWords);
                                } else if (notifier.addListCheck == false) {
                                  notifier.deleteCheckListFiveWords(
                                      word: notifier.correctWord.toLowerCase(), list: checkListFiveWords);
                                }
                              },
                            ),
                          );
                        }
                    ),
                    Text('Add List to review',style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold
                    ),)
                  ],
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    fixedSize: Size(size.width * 0.7, size.height * 0.06),
                  ),
                  onPressed: (){
                    keyMap.updateAll((key, value) => value = AnswerStage.notAnswered);
                    notifier.gameReset();

                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const FiveWordsWordle()));
                  },
                  child: const Text('Replay',style: TextStyle(
                    fontSize: 30,
                  ),),
                ),

                SizedBox(
                  height: 10.sp,
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    fixedSize: Size(size.width * 0.7, size.height * 0.06),
                  ),
                  onPressed: (){
                    keyMap.updateAll((key, value) => value = AnswerStage.notAnswered);
                    notifier.gameReset();

                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
                  },
                  child: const Text('To Title',style: TextStyle(
                    fontSize: 30,
                  ),),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
