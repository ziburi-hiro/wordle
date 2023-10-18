import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/data/key_map.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/screen/five_words_wordle.dart';
import 'package:wordle/screen/home_page.dart';

class ResultBoxFiveWords extends StatelessWidget {
  const ResultBoxFiveWords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      insetPadding: EdgeInsets.fromLTRB(size.width * 0.08, size.height * 0.12, size.width * 0.08, size.height * 0.12),
      content: Consumer<Controller>(
        builder: (_, notifier, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IconButton(
                  alignment: Alignment.centerRight,
                  onPressed: (){
                    Navigator.maybePop(context);
                  },
                  icon: const Icon(Icons.clear)
              ),
              const Expanded(
                  child: Text('RESULTS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900
                    ),
                  )
              ),

              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    const Text('Correct Word',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(notifier.correctWord.toLowerCase(),
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                      ),),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Mean',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    Text(notifier.meanList_5words[0],
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                      ),),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Parts of Speech',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    Text(notifier.meanList_5words[1],
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                      ),),
                  ],
                ),
              ),

              Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green
                    ),
                    onPressed: (){
                      keyMap.updateAll((key, value) => value = AnswerStage.notAnswered);
                      notifier.gameReset();

                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const FiveWordsWordle()));
                    },
                    child: const Text('Replay',style: TextStyle(
                      fontSize: 30,
                    ),),
                  )
              ),

              const SizedBox(
                height: 10,
              ),

              Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green
                    ),
                    onPressed: (){
                      keyMap.updateAll((key, value) => value = AnswerStage.notAnswered);
                      notifier.gameReset();

                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
                    },
                    child: const Text('To Title',style: TextStyle(
                      fontSize: 30,
                    ),),
                  )
              ),
            ],
          );
        },
      ),
    );
  }
}
