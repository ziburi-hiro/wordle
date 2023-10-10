import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/components/grid.dart';
import 'package:wordle/components/keyboard_row.dart';
import 'package:wordle/components/result_box.dart';
import 'package:wordle/components/title_back_box.dart';
import 'package:wordle/constants/words.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/screen/settings.dart';
import 'package:wordle/utils/quick_box.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  late String _word;

  @override
  void initState() {
    final r = Random().nextInt(words.length);
    _word = words[r];

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<Controller>(context, listen: false).setCorrectWord(word: _word);
      Provider.of<Controller>(context, listen: false).setCorrectMean(word: _word);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('4 WORDS WORDLE'),
        centerTitle: true,

        actions: [
          Consumer<Controller>(
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
                  runQuickBox(context: context, message: notifier.correctWord);
                }
                Future.delayed(const Duration(milliseconds: 3000), (){
                  if(mounted){
                    showDialog(context: context, builder: (_) => const ResultBox());
                  }
                });
              }
              return IconButton(
                  onPressed: () async {
                    notifier.gameCompleted ? showDialog(context: context, builder: (_) => const ResultBox())
                        :
                    showDialog(context: context, builder: (_) => const TitleBackBox());
                  },
                  icon: notifier.gameCompleted ? const Icon(Icons.description) : const Icon(Icons.reply)
              );
            }
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
              child: Grid(itemCount: 20, space: 3, axisCount: 4,)
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
