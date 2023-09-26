import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/components/stats_box.dart';
import 'package:wordle/components/stats_chart.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/data/key_map.dart';
import 'package:wordle/main.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/utils/calculate_chart_stats.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      insetPadding: EdgeInsets.fromLTRB(size.width * 0.08, size.height * 0.12, size.width * 0.08, size.height * 0.12),
      content: Column(
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
            child: Consumer<Controller>(
              builder: (_ , notifier, __){
                return Column(
                  children: [
                    Text('Correct Word',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(notifier.correctWord,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                    ),),
                  ],
                );
              }
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

                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => const MyApp()),
                          (route) => false
                  );

                },
                child: const Text('Replay',style: TextStyle(
                  fontSize: 30,
                ),),
              )
          )
        ],
      ),
    );
  }
}
