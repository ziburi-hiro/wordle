import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/providers/theme_provider.dart';

class QuizBox extends StatelessWidget {
  const QuizBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      content: Consumer<Controller>(
        builder: (_ , notifier, __){
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

              const Text('QUIZ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(top: 10,bottom: 10),
                child: Text('What is this word mean?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900
                  ),
                ),
              ),

              Text('"${notifier.correctWord.toLowerCase()}"',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Column(
                children: [
                  if(notifier.answerPositionNum == 0) ...[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ElevatedButton(
                            onPressed: (){

                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                side: BorderSide(
                                  width: 5,
                                  color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                )
                            ),
                            child: Text(notifier.meanList[0],style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ElevatedButton(
                            onPressed: (){

                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                side: BorderSide(
                                  width: 5,
                                  color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                )
                            ),
                            child: Text(notifier.choicesMean[0],style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ElevatedButton(
                            onPressed: (){

                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                side: BorderSide(
                                  width: 5,
                                  color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                )
                            ),
                            child: Text(notifier.choicesMean[1],style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ElevatedButton(
                            onPressed: (){

                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                side: BorderSide(
                                  width: 5,
                                  color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                )
                            ),
                            child: Text(notifier.choicesMean[2],style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),),
                          ),
                        ),
                      ],
                    )
                  ] else if(notifier.answerPositionNum == 1) ...[
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: (){

                          },
                          child: Text(notifier.choicesMean[0]),
                        ),
                        ElevatedButton(
                          onPressed: (){

                          },
                          child: Text(notifier.meanList[0]),
                        ),
                        ElevatedButton(
                          onPressed: (){

                          },
                          child: Text(notifier.choicesMean[1]),
                        ),
                        ElevatedButton(
                          onPressed: (){

                          },
                          child: Text(notifier.choicesMean[2]),
                        ),
                      ],
                    )
                  ] else if(notifier.answerPositionNum == 2) ...[
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: (){

                          },
                          child: Text(notifier.choicesMean[0]),
                        ),
                        ElevatedButton(
                          onPressed: (){

                          },
                          child: Text(notifier.choicesMean[1]),
                        ),
                        ElevatedButton(
                          onPressed: (){

                          },
                          child: Text(notifier.meanList[0]),
                        ),
                        ElevatedButton(
                          onPressed: (){

                          },
                          child: Text(notifier.choicesMean[2]),
                        ),
                      ],
                    )
                  ] else if(notifier.answerPositionNum == 3) ...[
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: (){

                          },
                          child: Text(notifier.choicesMean[0]),
                        ),
                        ElevatedButton(
                          onPressed: (){

                          },
                          child: Text(notifier.choicesMean[1]),
                        ),
                        ElevatedButton(
                          onPressed: (){

                          },
                          child: Text(notifier.choicesMean[2]),
                        ),
                        ElevatedButton(
                          onPressed: (){

                          },
                          child: Text(notifier.meanList[0]),
                        ),
                      ],
                    )
                  ]
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
