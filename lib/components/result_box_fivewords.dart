import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/data/key_map.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/screen/five_words_wordle.dart';
import 'package:wordle/screen/home_page.dart';
import 'package:wordle/utils/checkList_preferences_fivewords.dart';

class ResultBoxFiveWords extends StatefulWidget {
  const ResultBoxFiveWords({Key? key}) : super(key: key);

  @override
  State<ResultBoxFiveWords> createState() => _ResultBoxFiveWordsState();
}

class _ResultBoxFiveWordsState extends State<ResultBoxFiveWords> {
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
                        fontSize: 30,
                        fontWeight: FontWeight.w900
                    ),
                  )
              ),

              Expanded(
                flex: 3,
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

              Row(
                children: [
                  FutureBuilder(
                      future: CheckListPreferencesFiveWords.getCheckListFiveWords(),
                      builder: (context, snapshot) {
                        List<String> checkListFiveWords = [];
                        if(snapshot.hasData){
                          checkListFiveWords = snapshot.data as List<String>;
                        }
                        return Checkbox(
                          activeColor: Colors.green,
                          value: notifier.addListCheck,
                          onChanged: (bool? value) {
                            setState(() {
                              notifier.addListCheck = value!;
                            });
                            if (notifier.addListCheck == true) {
                              notifier.addCheckListFiveWords(
                                  word: notifier.correctWord.toLowerCase(), list: checkListFiveWords);
                            } else if (notifier.addListCheck == false) {
                              notifier.deleteCheckListFiveWords(
                                  word: notifier.correctWord.toLowerCase(), list: checkListFiveWords);
                            }
                          },
                        );
                      }
                  ),
                  const Text('Add List to review',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),)
                ],
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
                  flex: 1,
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
