import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/components/grid.dart';
import 'package:wordle/components/keyboard_row.dart';
import 'package:wordle/components/quiz_box.dart';
import 'package:wordle/components/result_box.dart';
import 'package:wordle/components/title_back_box.dart';
import 'package:wordle/constants/words.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/providers/quiz_provider.dart';
import 'package:wordle/screen/help_page.dart';
import 'package:wordle/screen/settings.dart';
import 'package:wordle/utils/quick_box.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  late String _word;
  late String _choices1;
  late String _choices2;
  late String _choices3;

  @override
  void initState() {
    final r = Random().nextInt(words.length);
    _word = words[r];
    final num1 = Random().nextInt(words.length);
    final num2 = Random().nextInt(words.length);
    final num3 = Random().nextInt(words.length);
    _choices1 = words[num1];
    _choices2 = words[num2];
    _choices3 = words[num3];

    final answerPositionNum = Random().nextInt(4);

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<Controller>(context, listen: false).setCorrectWord(word: _word);
      Provider.of<Controller>(context, listen: false).setCorrectMean(word: _word);
      Provider.of<Controller>(context, listen: false).setChoicesWord(choices1: _choices1, choices2: _choices2, choices3: _choices3);
      Provider.of<Controller>(context, listen: false).setChoicesMean(choices1: _choices1, choices2: _choices2, choices3: _choices3);
      Provider.of<Controller>(context, listen: false).setAnswerPositionNum(num: answerPositionNum);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('4 WORDS GAME'),
        centerTitle: true,
        leading: Consumer<Controller>(
            builder: (_, notifier, __) {
              if(notifier.notEnoughLetters){
                runQuickBox(context: context, message: 'Not Enough Letters');
              }
              if(notifier.gameCompleted){
                if(notifier.gameWon){
                  if(notifier.currentRow == 5){
                    runQuickBox(context: context, message: 'Phew!');
                  }else{
                    runQuickBox(context: context, message: 'Splendid!');
                  }
                }else{
                  runQuickBox(context: context, message: notifier.correctWord.toLowerCase());
                }
                Future.delayed(const Duration(milliseconds: 2000), (){
                  if(mounted){
                    if(Provider.of<QuizProvider>(context,listen: false).quizMode){
                      showDialog(context: context, builder: (_) => const QuizBox());
                    }else{
                      showDialog(context: context, builder: (_) => const ResultBox());
                    }
                  }
                });
              }
              return IconButton(
                  onPressed: () async {
                    if(Provider.of<QuizProvider>(context,listen: false).quizMode){
                      notifier.gameCompleted ? showDialog(context: context, builder: (_) => const QuizBox())
                          :
                      showDialog(context: context, builder: (_) => const TitleBackBox());
                    }else{
                      notifier.gameCompleted ? showDialog(context: context, builder: (_) => const ResultBox())
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
              child: Grid(itemCount: 20, space: 3, axisCount: 4, mode: 'FourWords',)
          ),

          Expanded(
            flex: 4,
              child: Column(
                children: [
                  KeyboardRow(min: 1, max: 10, length: 4,),
                  KeyboardRow(min: 11,max: 19, length: 4,),
                  KeyboardRow(min: 20, max: 29, length: 4,),
                ],
              )
          ),
        ],
      ),
    );
  }
}
