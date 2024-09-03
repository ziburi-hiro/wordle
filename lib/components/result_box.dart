import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/data/key_map.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/screen/game_page.dart';
import 'package:wordle/screen/home_page.dart';
import 'package:wordle/utils/checkList_preferences.dart';
import 'package:wordle/utils/rule_preferences.dart';

class ResultBox extends StatefulWidget {
  const ResultBox({Key? key}) : super(key: key);

  @override
  State<ResultBox> createState() => _ResultBoxState();
}

class _ResultBoxState extends State<ResultBox> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        insetPadding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.15, size.width * 0.05, size.height * 0.15),
        child: Consumer<Controller>(
          builder: (_, notifier, __) {
            return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              const SizedBox(
                height: 20,
              ),

              Expanded(
                  child: Text('結果',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.yuseiMagic(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w900
                    ),
                  )
              ),

              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Text('正解の単語',
                      style: GoogleFonts.yuseiMagic(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    Text(notifier.correctWord.toLowerCase(),
                      style: GoogleFonts.yuseiMagic(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold
                    ),),

                    SizedBox(
                      height: 10.sp,
                    ),

                    Text('単語の意味',
                      style: GoogleFonts.yuseiMagic(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold
                    ),),

                    Text(notifier.meanList[0],
                      style: GoogleFonts.yuseiMagic(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold
                    ),),

                    SizedBox(
                      height: 10.sp,
                    ),

                    Text('品詞',
                      style: GoogleFonts.yuseiMagic(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold
                      ),),

                    Text(notifier.meanList[1],
                      style: GoogleFonts.yuseiMagic(
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

              FutureBuilder(
                future: RulePreferences.getRuleCheckBox(),
                builder: (context,snapshot){
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                    child: SizedBox(
                      height: size.height*0.05,
                      width: size.width*0.4,
                      child: ElevatedButton(
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
                      ),
                    ),
                  );
                },
              ),

              SizedBox(
                height: 10.sp,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                child: SizedBox(
                  height: size.height*0.05,
                  width: size.width*0.4,
                  child: ElevatedButton(
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
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
            );
            },
        ),
      ),
    );
  }
}
