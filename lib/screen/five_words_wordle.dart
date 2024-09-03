import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/components/grid.dart';
import 'package:wordle/components/keyboard_row.dart';
import 'package:wordle/components/quiz_box_fivewords.dart';
import 'package:wordle/components/result_box_fivewords.dart';
import 'package:wordle/components/rule_box.dart';
import 'package:wordle/components/title_back_box.dart';
import 'package:wordle/constants/five_words.dart';
import 'package:wordle/main.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/providers/quiz_provider.dart';
import 'package:wordle/screen/help_page.dart';
import 'package:wordle/screen/settings.dart';
import 'package:wordle/utils/quick_box.dart';

class FiveWordsWordle extends StatefulWidget {
  FiveWordsWordle(this.ruleDisplayCheck,{Key? key}) : super(key: key);

  bool ruleDisplayCheck;

  @override
  State<FiveWordsWordle> createState() => _FiveWordsWordleState();
}

class _FiveWordsWordleState extends State<FiveWordsWordle> with RouteAware{

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
  void didPush() async {
    if(widget.ruleDisplayCheck == false){
      Future.delayed(const Duration(seconds: 1),() {
        showDialog(context: context,barrierDismissible: false, builder: (_) => const RuleBox());
      });
    }
  }

  late String _word;
  late String _choices1;
  late String _choices2;
  late String _choices3;

  @override
  void initState() {
    final r = Random().nextInt(five_words.length);
    _word = five_words[r];
    final num1 = Random().nextInt(five_words.length);
    final num2 = Random().nextInt(five_words.length);
    final num3 = Random().nextInt(five_words.length);
    _choices1 = five_words[num1];
    _choices2 = five_words[num2];
    _choices3 = five_words[num3];

    final answerPositionNum = Random().nextInt(4);

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<Controller>(context, listen: false).setCorrectWord(word: _word);
      Provider.of<Controller>(context, listen: false).setCorrectMeanFiveWords(word: _word);
      Provider.of<Controller>(context, listen: false).setChoicesWordFiveWords(choices1: _choices1, choices2: _choices2, choices3: _choices3);
      Provider.of<Controller>(context, listen: false).setChoicesMeanFiveWords(choices1: _choices1, choices2: _choices2, choices3: _choices3);
      Provider.of<Controller>(context, listen: false).setAnswerPositionNum(num: answerPositionNum);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('5 WORDS GAME'),
        centerTitle: true,
        leading: Consumer<Controller>(
            builder: (_, notifier, __) {
              if(notifier.notEnoughLetters){
                runQuickBox(context: context, message: 'Not Enough Letters');
              }
              if(notifier.gameCompleted){
                if(notifier.gameWon){
                  if(notifier.currentRow == 6){
                    runQuickBox(context: context, message: 'Phew!');
                  }else{
                    runQuickBox(context: context, message: 'Splendid!');
                  }
                }else{
                  runQuickBox(context: context, message: notifier.correctWord);
                }
                Future.delayed(const Duration(milliseconds: 2000), (){
                  if(mounted){
                    if(Provider.of<QuizProvider>(context,listen: false).quizMode){
                      showDialog(context: context, builder: (_) => const QuizBoxFiveWords());
                    }else{
                      showDialog(context: context, builder: (_) => const ResultBoxFiveWords());
                    }
                  }
                });
              }
              return IconButton(
                  onPressed: () async {
                    if(Provider.of<QuizProvider>(context,listen: false).quizMode){
                      notifier.gameCompleted ? showDialog(context: context, builder: (_) => const QuizBoxFiveWords())
                          :
                      showDialog(context: context, builder: (_) => const TitleBackBox());
                    }else{
                      notifier.gameCompleted ? showDialog(context: context, builder: (_) => const ResultBoxFiveWords())
                          :
                      showDialog(context: context, builder: (_) => const TitleBackBox());
                    }
                  },
                  icon: notifier.gameCompleted ? const Icon(Icons.description) : const Icon(Icons.home)
              );
            }
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HelpPage()
              ));
            },
            icon: const Icon(Icons.help_outline),
          ),
          IconButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Settings()
                ));
              },
              icon: const Icon(Icons.settings)
          )
        ],
      ),
      body: const Column(
        children: [
          Divider(
            height: 1,
            thickness: 2,
          ),

          Expanded(
              flex: 7,
              child: Grid(itemCount: 30, space: 4, axisCount: 5, mode: 'FiveWords',)
          ),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  KeyboardRow(min: 1, max: 10, length: 5,),
                  KeyboardRow(min: 11,max: 19, length: 5,),
                  KeyboardRow(min: 20, max: 29, length: 5,),
                ],
              )
          ),
        ],
      ),
    );
  }
}
