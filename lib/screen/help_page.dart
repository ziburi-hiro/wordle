import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/colors.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/providers/theme_provider.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: Consumer<Controller>(
        builder: (_, notifier , __) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Help',style: GoogleFonts.monomaniacOne(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),),
              centerTitle: true,
              elevation: 0,
            ),

            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: size.height*0.3,
                    child: Lottie.asset(
                        'assets/images/help.json',
                        errorBuilder: (context, error, stackTrace) {
                          return const Padding(
                            padding: EdgeInsets.all(10),
                            child: CircularProgressIndicator(),
                          );
                        }
                    ),
                  ),

                  ///WORDRILLとは
                  Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      onExpansionChanged: (bool changed){},
                      textColor: correctGreen,
                      iconColor: correctGreen,
                      title: Text('WORDRILLとは？',style: GoogleFonts.mPlusRounded1c(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold
                      ),),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                          child: Text('WORDRILLは遊びながら英単語を学習できる単語学習ゲームです\n'
                              '出題されている英単語をヒントを頼りに指定の回数の中で当てよう!!',style: GoogleFonts.mPlusRounded1c(
                            fontSize: 18,
                          ),),
                        )
                      ],
                    ),
                  ),

                  ///ノーマルモードとは
                  Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      textColor: containsYellow,
                      iconColor: containsYellow,
                      onExpansionChanged: (bool changed){},
                      title: Text('ノーマルモードとは？',style: GoogleFonts.mPlusRounded1c(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold
                      ),),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                          child: Text('ゲーム終了時に単語の意味と品詞が表示されるよ',style: GoogleFonts.mPlusRounded1c(
                            fontSize: 18,
                          ),),
                        ),
                        Image.asset(
                            'assets/images/Normal_result.png'
                        ),
                      ],
                    ),
                  ),

                  ///クイズモードとは
                  Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      textColor: Colors.grey,
                      iconColor: Colors.grey,
                      onExpansionChanged: (bool changed){},
                      title: Text('クイズモードとは？',style: GoogleFonts.mPlusRounded1c(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold
                      ),),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                          child: Text('ゲーム終了時に単語の意味が４択で問われるよ',style: GoogleFonts.mPlusRounded1c(
                            fontSize: 18,
                          ),),
                        ),
                        Image.asset(
                            'assets/images/Quiz_result.png'
                        ),
                      ],
                    ),
                  ),

                  ///単語帳とは？
                  Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      textColor: correctGreen,
                      iconColor: correctGreen,
                      onExpansionChanged: (bool changed){},
                      title: Text('単語帳とは？',style: GoogleFonts.mPlusRounded1c(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold
                      ),),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Text('ゲーム終了時に”単語帳に追加”にチェックを入れた単語を復習できるよ\n'
                              'たくさんプレイして自分だけの単語帳を作ろう!'
                              '復習した単語はテストボタンで意味をテストしよう!',style: GoogleFonts.mPlusRounded1c(
                            fontSize: 18,
                          ),),
                        )
                      ],
                    ),
                  ),

                  ///成績とは？
                  Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      textColor: containsYellow,
                      iconColor: containsYellow,
                      onExpansionChanged: (bool changed){},
                      title: Text('成績とは？',style: GoogleFonts.mPlusRounded1c(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold
                      ),),
                      children: [
                        Text('ゲームの成績が表示されるよ',style: GoogleFonts.mPlusRounded1c(
                          fontSize: 18,
                        ),)
                      ],
                    ),
                  ),

                  ///遊び方
                  Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      textColor: correctGreen,
                      iconColor: correctGreen,
                      onExpansionChanged: (bool changed){},
                      title: Text('遊び方',style: GoogleFonts.mPlusRounded1c(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold
                      ),),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w900
                              ),
                              children: const [
                                TextSpan(
                                  text: '出題されている英単語を予想してキーボードで入力します\n',
                                ),
                                TextSpan(
                                  text: 'ENTERを押すと文字の背景が変化するよ\n',
                                ),
                                TextSpan(
                                    text: '緑色',
                                    style: TextStyle(
                                      color: correctGreen,
                                    )
                                ),
                                TextSpan(
                                  text: '：文字と場所が正解\n',
                                ),
                                TextSpan(
                                    text: '黄色',
                                    style: TextStyle(
                                      color: containsYellow,
                                    )
                                ),
                                TextSpan(
                                  text: '：文字は正解だが場所が不正解\n',
                                ),
                                TextSpan(
                                    text: '灰色',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 120, 124, 127),
                                    )
                                ),
                                TextSpan(
                                  text: '：文字も場所も不正解\n',
                                ),
                                TextSpan(
                                  text: '色をヒントに出題単語を当てよう！\n',
                                ),
                              ]
                          ),
                      ),
                        ),

                        Text('例：正解は”soar”',style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w900
                                                    ),),

                        Image.asset(
                            'assets/images/Example.png'
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
