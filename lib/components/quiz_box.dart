import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/data/key_map.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/providers/theme_provider.dart';
import 'package:wordle/screen/game_page.dart';
import 'package:wordle/screen/home_page.dart';
import 'package:wordle/utils/checkList_preferences.dart';

class QuizBox extends StatefulWidget {
  const QuizBox({Key? key}) : super(key: key);

  @override
  State<QuizBox> createState() => _QuizBoxState();
}

class _QuizBoxState extends State<QuizBox> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: AlertDialog(
        content: Consumer<Controller>(
          builder: (_ , notifier, __){
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

                Text('QUIZ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w900
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.h,bottom: 10.h),
                  child: Text('What is this word mean?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                ),

                Text('"${notifier.correctWord.toLowerCase()}"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 21.sp,
                      fontWeight: FontWeight.w900
                  ),
                ),

                Visibility(
                  visible: notifier.answeredCorrect,
                  child: Text('○',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.green,
                    ),),
                ),

                Visibility(
                  visible: notifier.answeredFalse,
                  child: Text('×',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.red,
                    ),),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Column(
                    children: [
                      ///1番が正解のパターン
                      if(notifier.answerPositionNum == 0) ...[
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 5.0.h),
                              child: ElevatedButton(
                                onPressed: (notifier.tapButton == true) ? (){} : (){
                                  notifier.tapButton = true;
                                  notifier.answeredCorrect = true;
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: notifier.tapButton ? Colors.green : Colors.transparent,
                                    fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    side: BorderSide(
                                      width: 5,
                                      color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                    )
                                ),
                                child: Text(notifier.meanList[0],style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0.h),
                              child: ElevatedButton(
                                onPressed: (notifier.tapButton == true) ? (){} : (){
                                  notifier.tapButton = true;
                                  notifier.answeredFalse = true;
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: notifier.tapButton ? Colors.redAccent : Colors.transparent,
                                    fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    side: BorderSide(
                                      width: 5,
                                      color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                    )
                                ),
                                child: Text(notifier.choicesMean[0],style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0.h),
                              child: ElevatedButton(
                                onPressed: (notifier.tapButton == true) ? (){} : (){
                                  notifier.tapButton = true;
                                  notifier.answeredFalse = true;
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: notifier.tapButton ? Colors.redAccent : Colors.transparent,
                                    fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    side: BorderSide(
                                      width: 5,
                                      color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                    )
                                ),
                                child: Text(notifier.choicesMean[1],style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0.h),
                              child: ElevatedButton(
                                onPressed: (notifier.tapButton == true) ? (){} : (){
                                  notifier.tapButton = true;
                                  notifier.answeredFalse = true;
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: notifier.tapButton ? Colors.redAccent : Colors.transparent,
                                    fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    side: BorderSide(
                                      width: 5,
                                      color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                    )
                                ),
                                child: Text(notifier.choicesMean[2],style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                          ],
                        )
                        ///2番が正解のパターン
                      ] else if(notifier.answerPositionNum == 1) ...[
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 5.0.h),
                              child: ElevatedButton(
                                onPressed: (notifier.tapButton == true) ? (){} : (){
                                  notifier.tapButton = true;
                                  notifier.answeredFalse = true;
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: notifier.tapButton ? Colors.redAccent : Colors.transparent,
                                    fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    side: BorderSide(
                                      width: 5,
                                      color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                    )
                                ),
                                child: Text(notifier.choicesMean[0],style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0.h),
                              child: ElevatedButton(
                                onPressed: (notifier.tapButton == true) ? (){} : (){
                                  notifier.tapButton = true;
                                  notifier.answeredCorrect = true;
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: notifier.tapButton ? Colors.green : Colors.transparent,
                                    fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    side: BorderSide(
                                      width: 5,
                                      color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                    )
                                ),
                                child: Text(notifier.meanList[0],style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0.h),
                              child: ElevatedButton(
                                onPressed: (notifier.tapButton == true) ? (){} : (){
                                  notifier.tapButton = true;
                                  notifier.answeredFalse = true;
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: notifier.tapButton ? Colors.redAccent : Colors.transparent,
                                    fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    side: BorderSide(
                                      width: 5,
                                      color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                    )
                                ),
                                child: Text(notifier.choicesMean[1],style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0.h),
                              child: ElevatedButton(
                                onPressed: (notifier.tapButton == true) ? (){} : (){
                                  notifier.tapButton = true;
                                  notifier.answeredFalse = true;
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: notifier.tapButton ? Colors.redAccent : Colors.transparent,
                                    fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    side: BorderSide(
                                      width: 5,
                                      color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                    )
                                ),
                                child: Text(notifier.choicesMean[2],style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                          ],
                        )
                        ///3番が正解のパターン
                      ] else if(notifier.answerPositionNum == 2) ...[
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 5.0.h),
                              child: ElevatedButton(
                                onPressed: (notifier.tapButton == true) ? (){} : (){
                                  notifier.tapButton = true;
                                  notifier.answeredFalse = true;
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: notifier.tapButton ? Colors.redAccent : Colors.transparent,
                                    fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    side: BorderSide(
                                      width: 5,
                                      color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                    )
                                ),
                                child: Text(notifier.choicesMean[0],style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0.h),
                              child: ElevatedButton(
                                onPressed: (notifier.tapButton == true) ? (){} : (){
                                  notifier.tapButton = true;
                                  notifier.answeredFalse = true;
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: notifier.tapButton ? Colors.redAccent : Colors.transparent,
                                    fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    side: BorderSide(
                                      width: 5,
                                      color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                    )
                                ),
                                child: Text(notifier.choicesMean[1],style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0.h),
                              child: ElevatedButton(
                                onPressed: (notifier.tapButton == true) ? (){} : (){
                                  notifier.tapButton = true;
                                  notifier.answeredCorrect = true;
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: notifier.tapButton ? Colors.green : Colors.transparent,
                                    fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    side: BorderSide(
                                      width: 5,
                                      color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                    )
                                ),
                                child: Text(notifier.meanList[0],style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0.h),
                              child: ElevatedButton(
                                onPressed: (notifier.tapButton == true) ? (){} : (){
                                  notifier.tapButton = true;
                                  notifier.answeredFalse = true;
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: notifier.tapButton ? Colors.redAccent : Colors.transparent,
                                    fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    side: BorderSide(
                                      width: 5,
                                      color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                    )
                                ),
                                child: Text(notifier.choicesMean[2],style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                          ],
                        )
                        ///4番が正解のパターン
                      ] else if(notifier.answerPositionNum == 3) ...[
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 5.0.h),
                              child: ElevatedButton(
                                onPressed: (notifier.tapButton == true) ? (){} : (){
                                  notifier.tapButton = true;
                                  notifier.answeredFalse = true;
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: notifier.tapButton ? Colors.redAccent : Colors.transparent,
                                    fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    side: BorderSide(
                                      width: 5,
                                      color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                    )
                                ),
                                child: Text(notifier.choicesMean[0],style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0.h),
                              child: ElevatedButton(
                                onPressed: (notifier.tapButton == true) ? (){} : (){
                                  notifier.tapButton = true;
                                  notifier.answeredFalse = true;
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: notifier.tapButton ? Colors.redAccent : Colors.transparent,
                                    fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    side: BorderSide(
                                      width: 5,
                                      color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                    )
                                ),
                                child: Text(notifier.choicesMean[1],style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0.h),
                              child: ElevatedButton(
                                onPressed: (notifier.tapButton == true) ? (){} : (){
                                  notifier.tapButton = true;
                                  notifier.answeredFalse = true;
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: notifier.tapButton ? Colors.redAccent : Colors.transparent,
                                    fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    side: BorderSide(
                                      width: 5,
                                      color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                    )
                                ),
                                child: Text(notifier.choicesMean[2],style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0.h),
                              child: ElevatedButton(
                                onPressed: (notifier.tapButton == true) ? (){} : (){
                                  notifier.tapButton = true;
                                  notifier.answeredCorrect = true;
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: notifier.tapButton ? Colors.green : Colors.transparent,
                                    fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    side: BorderSide(
                                      width: 5,
                                      color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                    )
                                ),
                                child: Text(notifier.meanList[0],style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                          ],
                        )
                      ]
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder(
                      future: CheckListPreferences.getCheckList(),
                      builder: (context, snapshot) {
                        List<String> checkList = [];
                        if(snapshot.hasData){
                          checkList = snapshot.data as List<String>;
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
                                notifier.addCheckList(
                                    word: notifier.correctWord.toLowerCase(), list: checkList);
                              } else if (notifier.addListCheck == false) {
                                notifier.deleteCheckList(
                                    word: notifier.correctWord.toLowerCase(), list: checkList);
                              }
                            },
                          ),
                        );
                      }
                    ),
                    Text(' Add List to review',style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold
                    ),)
                  ],
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          fixedSize: Size(size.width * 0.7, size.height * 0.06),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                        onPressed: (){
                          keyMap.updateAll((key, value) => value = AnswerStage.notAnswered);
                          notifier.gameReset();

                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const GamePage()));
                        },
                        child: const Text('Replay',style: TextStyle(
                          fontSize: 30,
                        ),),
                      ),

                      SizedBox(
                        height: 5.h,
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          fixedSize: Size(size.width * 0.7, size.height * 0.06),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
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
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
