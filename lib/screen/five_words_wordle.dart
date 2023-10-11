import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/components/grid.dart';
import 'package:wordle/components/keyboard_row.dart';
import 'package:wordle/components/result_box_fivewords.dart';
import 'package:wordle/components/title_back_box.dart';
import 'package:wordle/constants/five_words.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/screen/settings.dart';
import 'package:wordle/utils/quick_box.dart';

class FiveWordsWordle extends StatefulWidget {
  const FiveWordsWordle({Key? key}) : super(key: key);

  @override
  State<FiveWordsWordle> createState() => _FiveWordsWordleState();
}

class _FiveWordsWordleState extends State<FiveWordsWordle> {

  late String _word;

  @override
  void initState() {
    final r = Random().nextInt(five_words.length);
    _word = five_words[r];

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<Controller>(context, listen: false).setCorrectWord(word: _word);
      Provider.of<Controller>(context, listen: false).setCorrectMeanFiveWords(word: _word);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('5 WORDS WORDLE'),
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
                      showDialog(context: context, builder: (_) => const ResultBoxFiveWords());
                    }
                  });
                }
                return IconButton(
                    onPressed: () async {
                      notifier.gameCompleted ? showDialog(context: context, builder: (_) => const ResultBoxFiveWords())
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
              child: Grid(itemCount: 30, space: 4, axisCount: 5,)
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
