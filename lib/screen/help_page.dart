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
                      children: const [
                        Text('wordrillの説明')
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
                      children: const [
                        Text('wordrillの説明')
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




          // return DefaultTabController(
          //   length: 2,
          //   child: Scaffold(
          //     appBar: AppBar(
          //       title: const Text('Help'),
          //       centerTitle: true,
          //       elevation: 0,
          //       bottom: TabBar(
          //         indicatorColor: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
          //         labelColor: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.black,
          //         tabs: const [
          //           Tab(text: "WORDRILLとは？",),
          //           Tab(text: '遊び方',),
          //         ],
          //       ),
          //     ),
          //     body: TabBarView(
          //       children: [
          //         //what's WORDRILL
          //         SingleChildScrollView(
          //             child: Padding(
          //               padding: const EdgeInsets.all(10.0),
          //               child: Container(
          //                 color: Colors.yellow,
          //                 child: Column(
          //                   children: [
          //                     Container(
          //                       width: double.infinity,
          //                       height: size.height*0.3,
          //                       decoration: BoxDecoration(
          //                         borderRadius: BorderRadius.circular(10),
          //                         color: Colors.red
          //                       ),
          //                       child: Column(
          //                         children: [
          //                           FittedBox(
          //                             fit: BoxFit.fitWidth,
          //                             child: Text('WORDRILLとは？',style: TextStyle(
          //                                 fontSize: 25.sp,
          //                                 fontWeight: FontWeight.w900
          //                             ),),
          //                           ),
          //                           const Divider(
          //                             height: 20,
          //                             thickness: 5,
          //                             indent: 0,
          //                             endIndent: 0,
          //                             color: correctGreen,
          //                           ),
          //                           Text('WORDRILLは遊びながら英単語を学習できる単語学習ゲームです\n'
          //                               '出題されている英単語をヒントを頼りに指定の回数の中で当てよう!!',
          //                             style: TextStyle(
          //                                 fontSize: 20.sp
          //                             ),),
          //                         ],
          //                       ),
          //                     ),
          //
          //                     const SizedBox(
          //                       height: 30,
          //                     ),
          //
          //                     FittedBox(
          //                       fit: BoxFit.fitWidth,
          //                       child: Text('NormalModeとQuizModeの違い',style: TextStyle(
          //                           fontSize: 25.sp,
          //                           fontWeight: FontWeight.w900
          //                       ),),
          //                     ),
          //                     const Divider(
          //                       height: 20,
          //                       thickness: 5,
          //                       indent: 0,
          //                       endIndent: 0,
          //                       color: containsYellow,
          //                     ),
          //                     Text('NormalMode\n'
          //                         'ゲーム終了時に単語の意味と品詞が表示されるよ\n',
          //                       style: TextStyle(
          //                         fontSize: 20.sp
          //                     ),),
          //
          //                     Image.asset(
          //                       'assets/images/Normal_result.png'
          //                     ),
          //
          //                     Text('QuizMode\n'
          //                         'ゲーム終了時に単語の意味が４択で問われるよ',
          //                       style: TextStyle(
          //                           fontSize: 20.sp
          //                       ),),
          //
          //                     Image.asset(
          //                         'assets/images/Quiz_result.png'
          //                     ),
          //
          //                     const SizedBox(
          //                       height: 30,
          //                     ),
          //
          //                     FittedBox(
          //                       fit: BoxFit.fitWidth,
          //                       child: Text('VIEW CHECKLISTとは？',style: TextStyle(
          //                           fontSize: 25.sp,
          //                           fontWeight: FontWeight.w900
          //                       ),),
          //                     ),
          //                     const Divider(
          //                       height: 20,
          //                       thickness: 5,
          //                       indent: 0,
          //                       endIndent: 0,
          //                       color: Color.fromARGB(255, 120, 124, 127),
          //                     ),
          //                     Text('ゲーム終了時に”Add List to review”にチェックを入れた単語を復習できるよ\n'
          //                         'たくさんプレイして自分だけの単語帳を作ろう!\n'
          //                         '復習した単語はテストボタンで意味をテストしよう!',style: TextStyle(
          //                         fontSize: 20.sp
          //                     ),),
          //
          //                     Image.asset(
          //                         'assets/images/Review.png'
          //                     ),
          //
          //                     const SizedBox(
          //                       height: 30,
          //                     ),
          //
          //                     FittedBox(
          //                       fit: BoxFit.fitWidth,
          //                       child: Text('VIEW STATICSとは？',style: TextStyle(
          //                           fontSize: 25.sp,
          //                           fontWeight: FontWeight.w900
          //                       ),),
          //                     ),
          //                     const Divider(
          //                       height: 20,
          //                       thickness: 5,
          //                       indent: 0,
          //                       endIndent: 0,
          //                       color: correctGreen,
          //                     ),
          //                     Text('ゲームの成績が表示されるよ\n'
          //                         'Played：ゲームプレイ回数\n'
          //                         'Win％：単語当て成功率\n'
          //                         'CurrentStreak：連続成功回数\n'
          //                         'MaxStreak：過去最高連続成功回数',style: TextStyle(
          //                         fontSize: 20.sp
          //                     ),),
          //                     const SizedBox(
          //                       height: 30,
          //                     ),
          //
          //                   ],
          //                 )
          //               ),
          //             )
          //         ),
          //
          //         //how to play
          //         SingleChildScrollView(
          //             child: Padding(
          //               padding: const EdgeInsets.all(10.0),
          //               child: Container(
          //                   child: Column(
          //                     children: [
          //                       FittedBox(
          //                         fit: BoxFit.fitWidth,
          //                         child: Text('GAME RULE',style: TextStyle(
          //                             fontSize: 25.sp,
          //                             fontWeight: FontWeight.w900
          //                         ),),
          //                       ),
          //                       const Divider(
          //                         height: 20,
          //                         thickness: 5,
          //                         indent: 0,
          //                         endIndent: 0,
          //                         color: correctGreen,
          //                       ),
          //                       RichText(
          //                           text: TextSpan(
          //                             style: TextStyle(
          //                                 fontSize: 20.sp,
          //                               color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.black,
          //                               fontWeight: FontWeight.w900
          //                             ),
          //                             children: const [
          //                               TextSpan(
          //                                 text: '出題されている英単語を予想してキーボードで入力します\n',
          //                               ),
          //                               TextSpan(
          //                                 text: 'ENTERを押すと文字の背景が変化するよ\n',
          //                               ),
          //                               TextSpan(
          //                                 text: '緑色',
          //                                 style: TextStyle(
          //                                   color: correctGreen,
          //                                 )
          //                               ),
          //                               TextSpan(
          //                                 text: '：文字と場所が正解\n',
          //                               ),
          //                               TextSpan(
          //                                   text: '黄色',
          //                                   style: TextStyle(
          //                                     color: containsYellow,
          //                                   )
          //                               ),
          //                               TextSpan(
          //                                 text: '：文字は正解だが場所が不正解\n',
          //                               ),
          //                               TextSpan(
          //                                   text: '灰色',
          //                                   style: TextStyle(
          //                                     color: Color.fromARGB(255, 120, 124, 127),
          //                                   )
          //                               ),
          //                               TextSpan(
          //                                 text: '：文字も場所も不正解\n',
          //                               ),
          //                               TextSpan(
          //                                 text: '色をヒントに出題単語を当てよう！\n',
          //                               ),
          //                             ]
          //                           ),
          //                       ),
          //
          //                       Text('例：正解は”soar”',style: TextStyle(
          //                         fontSize: 20.sp,
          //                         fontWeight: FontWeight.w900
          //                       ),),
          //
          //                       Image.asset(
          //                           'assets/images/Example.png'
          //                       ),
          //
          //                       const SizedBox(
          //                         height: 30,
          //                       ),
          //                     ],
          //                   )
          //               ),
          //             )
          //         ),
          //       ],
          //     ),
          //   ),
          // );
        },
      ),
    );
  }
}
