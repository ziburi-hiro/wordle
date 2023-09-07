import 'package:flutter/material.dart';
import 'package:wordle/components/stats_box.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/data/key_map.dart';
import 'package:wordle/main.dart';

class StatsBox extends StatelessWidget {
  const StatsBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconButton(
            alignment: Alignment.centerRight,
              onPressed: (){},
              icon: const Icon(Icons.clear)
          ),
          const Expanded(
              child: Text('STATISTICS',textAlign: TextAlign.center,)
          ),
          const Expanded(
            child: Row(
              children: [
                StatsTile(heading: 'Played',value: 50,),
                StatsTile(heading: 'Win %',value: 90,),
                StatsTile(heading: 'Current\nStreak',value: 20,),
                StatsTile(heading: 'Max\nStreak',value: 30,),
              ],
            ),
          ),
          Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green
                ),
                onPressed: (){
                  
                  keyMap.updateAll((key, value) => value = AnswerStage.notAnswered);
                  
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                          (route) => false
                  );
                },
                child: Text('Replay',style: TextStyle(
                  fontSize: 30,
                ),),
              )
          )
        ],
      ),
    );
  }
}