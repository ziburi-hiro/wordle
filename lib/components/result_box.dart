import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/data/key_map.dart';
import 'package:wordle/main.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/screen/game_page.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({Key? key}) : super(key: key);

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
              child: Column(
                children: [
                  const Text('Correct Word',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(notifier.correctWord,
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
                  Text(notifier.meanList[0],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),),
                ],
              ),
            ),

            Expanded(
                flex: 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green
                  ),
                  onPressed: (){
                    keyMap.updateAll((key, value) => value = AnswerStage.notAnswered);
                    notifier.gameReset();

                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const GamePage()));
                  },
                  child: const Text('Replay',style: TextStyle(
                    fontSize: 30,
                  ),),
                )
            )
          ],
          );
          },
      ),
    );
  }
}
