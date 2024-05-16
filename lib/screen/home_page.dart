import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/colors.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/providers/quiz_provider.dart';
import 'package:wordle/providers/theme_provider.dart';
import 'package:wordle/screen/check_list_page.dart';
import 'package:wordle/screen/five_words_wordle.dart';
import 'package:wordle/screen/game_page.dart';
import 'package:wordle/screen/help_page.dart';
import 'package:wordle/screen/settings.dart';
import 'package:wordle/screen/statics_page.dart';
import 'package:wordle/utils/quiz_preferences.dart';
import 'package:wordle/main.dart';
import 'package:wordle/utils/rule_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware{

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // 一度、別の画面に遷移したあとで、再度この画面に戻ってきた時にコールされます。
    setState(() {
    });
  }

  @override
  void initState() {
    Provider.of<Controller>(context, listen: false).setQuizMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: ScreenUtilInit(
          designSize: const Size(393, 852),
          child: FutureBuilder(
            initialData: false,
            future: QuizPreferences.getQuizMode(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Provider.of<QuizProvider>(context, listen: false).setQuizMode(turnOn: snapshot.data as bool);
                });
              }
              return Consumer<ThemeProvider>(
                builder: (_, notifier, __) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 55,
                                width: 50,
                                child: Stack(
                                  children: [
                                    IconButton(
                                      onPressed: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HelpPage()
                                        ));
                                      },
                                      icon: const Icon(Icons.help_outline),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text('Help',style: TextStyle(
                                          color: notifier.isDark ? Colors.white : Colors.black
                                      ),),
                                    )
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 55,
                                width: 50,
                                child: Stack(
                                  children: [
                                    IconButton(
                                        onPressed: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Settings()
                                          ));
                                        },
                                        icon: const Icon(Icons.settings)
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text('設定',style: TextStyle(
                                          color: notifier.isDark ? Colors.white : Colors.black
                                      ),),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: 'W',style: GoogleFonts.monomaniacOne(
                                  fontSize: 90.sp,
                                  fontWeight: FontWeight.bold,
                                  color: correctGreen
                                )),
                                TextSpan(text: 'O',style: GoogleFonts.monomaniacOne(
                                    fontSize: 90.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey
                                )),
                                TextSpan(text: 'R',style: GoogleFonts.monomaniacOne(
                                    fontSize: 90.sp,
                                    fontWeight: FontWeight.bold,
                                    color: containsYellow
                                )),
                                TextSpan(text: 'D',style: GoogleFonts.monomaniacOne(
                                    fontSize: 90.sp,
                                    fontWeight: FontWeight.bold,
                                    color: containsYellow
                                )),
                                TextSpan(text: 'R',style: GoogleFonts.monomaniacOne(
                                    fontSize: 90.sp,
                                    fontWeight: FontWeight.bold,
                                    color: correctGreen
                                )),
                                TextSpan(text: 'I',style: GoogleFonts.monomaniacOne(
                                    fontSize: 90.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey
                                )),
                                TextSpan(text: 'L',style: GoogleFonts.monomaniacOne(
                                    fontSize: 90.sp,
                                    fontWeight: FontWeight.bold,
                                    color: containsYellow
                                )),
                                TextSpan(text: 'L',style: GoogleFonts.monomaniacOne(
                                    fontSize: 90.sp,
                                    fontWeight: FontWeight.bold,
                                    color: correctGreen
                                )),
                              ]
                            ),
                          ),
                          // child: Text('WORDRILL',style: GoogleFonts.monomaniacOne(
                          //   fontSize: 80.sp,
                          //   fontWeight: FontWeight.bold,
                          //   letterSpacing: 3.0,
                          // ),),
                        ),

                        // snapshot.data! ?
                        // FittedBox(
                        //   fit: BoxFit.fitWidth,
                        //   child: Text('クイズモード',style: GoogleFonts.monomaniacOne(
                        //       fontSize: 40.sp,
                        //       fontWeight: FontWeight.bold
                        //   ),),
                        // )
                        //     :
                        // FittedBox(
                        //   fit: BoxFit.fitWidth,
                        //   child: Text('ノーマルモード',style: GoogleFonts.monomaniacOne(
                        //       fontSize: 40.sp,
                        //       fontWeight: FontWeight.bold
                        //   ),),
                        // ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: ToggleButtons(
                            borderWidth: 5,
                            borderColor: notifier.isDark ? Colors.white : Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                            fillColor: Colors.green,
                            selectedBorderColor: notifier.isDark ? Colors.white : Colors.grey,
                            selectedColor: Colors.white,
                            isSelected: Provider.of<Controller>(context, listen: false).toggleButtonSelect,
                            children: [
                              SizedBox(
                                width: size.width * 0.4,
                                child: Center(
                                  child: Text('ノーマルモード',style: GoogleFonts.monomaniacOne(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.4,
                                child: Center(
                                  child: Text('クイズモード',style: GoogleFonts.monomaniacOne(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ),
                              )
                            ],
                            onPressed: (index){
                              setState(() {
                                if(index == 0){
                                  if(Provider.of<Controller>(context, listen: false).toggleButtonSelect[0] == false){
                                    Provider.of<Controller>(context, listen: false).toggleButtonSelect[0] = true;
                                    Provider.of<Controller>(context, listen: false).toggleButtonSelect[1] = false;
                                    QuizPreferences.saveQuizMode(isQuizMode: Provider.of<Controller>(context, listen: false).toggleButtonSelect[1]);
                                    Provider.of<QuizProvider>(context,listen: false).setQuizMode(turnOn: Provider.of<Controller>(context, listen: false).toggleButtonSelect[1]);
                                  }
                                }else if(index == 1){
                                  if(Provider.of<Controller>(context, listen: false).toggleButtonSelect[1] == false){
                                    Provider.of<Controller>(context, listen: false).toggleButtonSelect[1] = true;
                                    Provider.of<Controller>(context, listen: false).toggleButtonSelect[0] = false;
                                    QuizPreferences.saveQuizMode(isQuizMode: Provider.of<Controller>(context, listen: false).toggleButtonSelect[1]);
                                    Provider.of<QuizProvider>(context,listen: false).setQuizMode(turnOn: Provider.of<Controller>(context, listen: false).toggleButtonSelect[1]);
                                  }
                                }
                              });
                            },
                          ),
                        ),

                        SizedBox(
                          height: size.height*0.05,
                        ),

                        Text('ゲームプレイ',style: GoogleFonts.yuseiMagic(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold
                        ),),

                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: FutureBuilder(
                            future: RulePreferences.getRuleCheckBox(),
                            builder: (context,snapshot){
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: notifier.isDark ? Colors.transparent : Colors.transparent,
                                    fixedSize: Size(size.width * 0.85, size.height * 0.1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    side: BorderSide(
                                      width: 5,
                                      color: notifier.isDark ? Colors.white : Colors.grey,
                                    )
                                ),
                                onPressed: (){
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  GamePage(snapshot.data!)));
                                },
                                child: Text('4 WORDS VER',style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.italic
                                ),),
                              );
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FutureBuilder(
                            future: RulePreferences.getRuleCheckBox(),
                            builder: (context, snapshot){
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    fixedSize: Size(size.width * 0.85, size.height * 0.1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    side: BorderSide(
                                      width: 5,
                                      color: notifier.isDark ? Colors.white : Colors.grey,
                                    )
                                ),
                                onPressed: (){
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  FiveWordsWordle(snapshot.data!)));
                                },
                                child: Text('5 WORDS VER',style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.italic
                                ),),
                              );
                            },
                          ),
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 8.0),
                        //   child: Text('単語帳',style: GoogleFonts.yuseiMagic(
                        //       fontSize: 25.sp,
                        //       fontWeight: FontWeight.bold
                        //   ),),
                        // ),

                        SizedBox(
                          height: size.height*0.05,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: notifier.isDark ? Colors.transparent : Colors.transparent,
                                  fixedSize: Size(size.width * 0.4, size.height * 0.1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  side: BorderSide(
                                    width: 5,
                                    color: notifier.isDark ? Colors.white : Colors.grey,
                                  )
                              ),
                              onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CheckListPage()));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.menu_book,
                                    size: 45,
                                  ),
                                  Text('単語帳',style: GoogleFonts.yuseiMagic(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ],
                              )
                            ),

                            SizedBox(
                              width: size.width*0.05,
                            ),

                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: notifier.isDark ? Colors.transparent : Colors.transparent,
                                    fixedSize: Size(size.width * 0.4, size.height * 0.1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    side: BorderSide(
                                      width: 5,
                                      color: notifier.isDark ? Colors.white : Colors.grey,
                                    )
                                ),
                                onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const StaticsPage()));
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.equalizer,
                                      size: 45,
                                    ),
                                    Text('成績',style: GoogleFonts.yuseiMagic(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  ],
                                )
                            ),
                          ],
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                        //   child: Text('ゲームの記録',style: GoogleFonts.yuseiMagic(
                        //       fontSize: 25.sp,
                        //       fontWeight: FontWeight.bold
                        //   ),),
                        // ),

                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
