import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/providers/quiz_provider.dart';
import 'package:wordle/providers/theme_provider.dart';
import 'package:wordle/screen/check_list_page.dart';
import 'package:wordle/screen/five_words_wordle.dart';
import 'package:wordle/screen/game_page.dart';
import 'package:wordle/screen/settings.dart';
import 'package:wordle/screen/statics_page.dart';
import 'package:wordle/utils/quiz_preferences.dart';
import 'package:wordle/main.dart';

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
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Settings()
                ));
              },
              icon: const Icon(Icons.settings)
          ),
        ],
      ),
      body: FutureBuilder(
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
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text('WORDLE',style: TextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.w900,
                              ),),
                            ),
                            snapshot.data! ?
                            const Text('QuizMode',style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),)
                                :
                            const Text('NormalMode',style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold
                            ),),
                          ],
                        )
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ToggleButtons(
                        borderWidth: 5,
                        borderColor: notifier.isDark ? Colors.white : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                        fillColor: Colors.green,
                        selectedBorderColor: notifier.isDark ? Colors.white : Colors.grey,
                        selectedColor: Colors.white,
                        isSelected: Provider.of<Controller>(context, listen: false).toggleButtonSelect,
                        children: const [
                          SizedBox(
                            width: 130,
                            child: Center(
                              child: Text('NormalMode',style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),),
                            ),
                          ),
                          SizedBox(
                            width: 130,
                            child: Center(
                              child: Text('QuizMode',style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
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

                    const Text('---Single Play---',style: TextStyle(
                        fontSize: 24
                    ),),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: notifier.isDark ? Colors.transparent : Colors.transparent,
                            fixedSize: Size(size.width * 0.7, size.height * 0.08),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            side: BorderSide(
                              width: 5,
                              color: notifier.isDark ? Colors.white : Colors.grey,
                            )
                        ),
                        onPressed: (){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const GamePage()));
                        },
                        child: const Text('4WORDS WORDLE',style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic
                        ),),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            fixedSize: Size(size.width * 0.7, size.height * 0.08),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            side: BorderSide(
                              width: 5,
                              color: notifier.isDark ? Colors.white : Colors.grey,
                            )
                        ),
                        onPressed: (){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const FiveWordsWordle()));
                        },
                        child: const Text('5WORDS WORDLE',style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic
                        ),),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('---Review---',style: TextStyle(
                          fontSize: 24
                      ),),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: notifier.isDark ? Colors.transparent : Colors.transparent,
                          fixedSize: Size(size.width * 0.7, size.height * 0.08),
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
                      child: const Text('View CheckList',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic
                      ),),
                    ),

                    const Padding(
                      padding: EdgeInsets.only(top: 16.0,bottom: 8.0),
                      child: Text('---Statistics---',style: TextStyle(
                          fontSize: 24
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: notifier.isDark ? Colors.transparent : Colors.transparent,
                            fixedSize: Size(size.width * 0.7, size.height * 0.08),
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
                        child: const Text('View Statics',style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic
                        ),),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
