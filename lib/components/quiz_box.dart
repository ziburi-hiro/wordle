import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/data/key_map.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/providers/theme_provider.dart';
import 'package:wordle/screen/game_page.dart';
import 'package:wordle/screen/home_page.dart';
import 'package:wordle/utils/checkList_preferences.dart';
import 'package:wordle/utils/rule_preferences.dart';

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
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Consumer<Controller>(
          builder: (_ , notifier, __){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('クイズ',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.yuseiMagic(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.h,bottom: 10.h),
                  child: Text('この単語の意味は何？',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.yuseiMagic(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),

                SizedBox(
                  height: size.height*0.2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text('"${notifier.correctWord.toLowerCase()}"',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w900
                        ),
                      ),

                      Visibility(
                        visible: notifier.answeredCorrect,
                        child: Opacity(
                          opacity: 0.6,
                          child: Text('○',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 150.sp,
                              fontWeight: FontWeight.w900,
                              color: Colors.green,
                            ),),
                        ),
                      ),

                      Visibility(
                        visible: notifier.answeredCorrect,
                        child: const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text('Good!',style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                              color: Colors.green
                          ),),
                        ),
                      ),

                      Visibility(
                        visible: notifier.answeredFalse,
                        child: Opacity(
                          opacity: 0.6,
                          child: Text('×',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 150.sp,
                              fontWeight: FontWeight.w900,
                              color: Colors.red,
                            ),),
                        ),
                      ),

                      Visibility(
                        visible: notifier.answeredFalse,
                        child: const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text('Bad..',style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                              color: Colors.redAccent
                          ),),
                        ),
                      ),

                    ],
                  ),
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
                    Text('単語帳に追加する',style: GoogleFonts.yuseiMagic(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold
                    ),)
                  ],
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FutureBuilder(
                        future: RulePreferences.getRuleCheckBox(),
                        builder: (context,snapshot){
                          return ElevatedButton(
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
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => GamePage(snapshot.data!)));
                            },
                            child: Text('もう一度遊ぶ',style: GoogleFonts.yuseiMagic(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),),
                          );
                        },
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
                        child: Text('タイトルに戻る',style: GoogleFonts.yuseiMagic(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),

                      const SizedBox(
                        height: 20,
                      )
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
