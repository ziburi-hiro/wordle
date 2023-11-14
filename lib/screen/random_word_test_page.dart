import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/means.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/providers/theme_provider.dart';
import 'package:wordle/utils/checkList_preferences.dart';

class RandomWordTestPage extends StatefulWidget {
  const RandomWordTestPage({super.key});

  @override
  State<RandomWordTestPage> createState() => _RandomWordTestPageState();
}

class _RandomWordTestPageState extends State<RandomWordTestPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text('RANDOMWORDTESTMODE'),
      ),
      body: Consumer<Controller>(
        builder: (_, notifier, __) {
          return Column(
            children: [
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 5,
                        color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.transparent : Colors.white70,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),

                            const Text('QUIZ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900
                              ),
                            ),

                            const Padding(
                              padding: EdgeInsets.only(top: 10,bottom: 10),
                              child: Text('What is this word mean?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900
                                ),
                              ),
                            ),

                            Text('"${notifier.testList[index]}"',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            Visibility(
                              visible: notifier.answeredCorrectList[index],
                              child: const Text('○',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.green,
                                ),),
                            ),

                            Visibility(
                              visible: notifier.answeredFalseList[index],
                              child: const Text('×',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.red,
                                ),),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                children: [
                                  ///1番が正解のパターン
                                  if(notifier.positionNum[index] == 0) ...[
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ElevatedButton(
                                            onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                              notifier.tapButtonList[index] = true;
                                              notifier.answeredCorrectList[index] = true;
                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: notifier.tapButtonList[index] ? Colors.green : Colors.transparent,
                                                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                side: BorderSide(
                                                  width: 5,
                                                  color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                )
                                            ),
                                            child: Text(Means[notifier.testList[index].toUpperCase()]![0],style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ElevatedButton(
                                            onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                              notifier.tapButtonList[index] = true;
                                              notifier.answeredFalseList[index] = true;
                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                side: BorderSide(
                                                  width: 5,
                                                  color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                )
                                            ),
                                            child: Text(notifier.fakeMeanList[index][0],style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ElevatedButton(
                                            onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                              notifier.tapButtonList[index] = true;
                                              notifier.answeredFalseList[index] = true;
                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                side: BorderSide(
                                                  width: 5,
                                                  color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                )
                                            ),
                                            child: Text(notifier.fakeMeanList[index][1],style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ElevatedButton(
                                            onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                              notifier.tapButtonList[index] = true;
                                              notifier.answeredFalseList[index] = true;
                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                side: BorderSide(
                                                  width: 5,
                                                  color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                )
                                            ),
                                            child: Text(notifier.fakeMeanList[index][2],style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                        ),
                                      ],
                                    )
                                    ///2番が正解のパターン
                                  ] else if(notifier.positionNum[index] == 1) ...[
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ElevatedButton(
                                            onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                              notifier.tapButtonList[index] = true;
                                              notifier.answeredFalseList[index] = true;
                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                side: BorderSide(
                                                  width: 5,
                                                  color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                )
                                            ),
                                            child: Text(notifier.fakeMeanList[index][0],style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ElevatedButton(
                                            onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                              notifier.tapButtonList[index] = true;
                                              notifier.answeredCorrectList[index] = true;
                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: notifier.tapButtonList[index] ? Colors.green : Colors.transparent,
                                                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                side: BorderSide(
                                                  width: 5,
                                                  color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                )
                                            ),
                                            child: Text(Means[notifier.testList[index].toUpperCase()]![0],style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ElevatedButton(
                                            onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                              notifier.tapButtonList[index] = true;
                                              notifier.answeredFalseList[index] = true;
                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                side: BorderSide(
                                                  width: 5,
                                                  color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                )
                                            ),
                                            child: Text(notifier.fakeMeanList[index][1],style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ElevatedButton(
                                            onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                              notifier.tapButtonList[index] = true;
                                              notifier.answeredFalseList[index] = true;
                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                side: BorderSide(
                                                  width: 5,
                                                  color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                )
                                            ),
                                            child: Text(notifier.fakeMeanList[index][2],style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                        ),
                                      ],
                                    )
                                    ///3番が正解のパターン
                                  ] else if(notifier.positionNum[index] == 2) ...[
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ElevatedButton(
                                            onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                              notifier.tapButtonList[index] = true;
                                              notifier.answeredFalseList[index] = true;
                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                side: BorderSide(
                                                  width: 5,
                                                  color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                )
                                            ),
                                            child: Text(notifier.fakeMeanList[index][0],style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ElevatedButton(
                                            onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                              notifier.tapButtonList[index] = true;
                                              notifier.answeredFalseList[index] = true;
                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                side: BorderSide(
                                                  width: 5,
                                                  color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                )
                                            ),
                                            child: Text(notifier.fakeMeanList[index][1],style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ElevatedButton(
                                            onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                              notifier.tapButtonList[index] = true;
                                              notifier.answeredCorrectList[index] = true;
                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: notifier.tapButtonList[index] ? Colors.green : Colors.transparent,
                                                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                side: BorderSide(
                                                  width: 5,
                                                  color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                )
                                            ),
                                            child: Text(Means[notifier.testList[index].toUpperCase()]![0],style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ElevatedButton(
                                            onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                              notifier.tapButtonList[index] = true;
                                              notifier.answeredFalseList[index] = true;
                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                side: BorderSide(
                                                  width: 5,
                                                  color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                )
                                            ),
                                            child: Text(notifier.fakeMeanList[index][2],style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                        ),
                                      ],
                                    )
                                    ///4番が正解のパターン
                                  ] else if(notifier.positionNum[index] == 3) ...[
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ElevatedButton(
                                            onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                              notifier.tapButtonList[index] = true;
                                              notifier.answeredFalseList[index] = true;
                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                side: BorderSide(
                                                  width: 5,
                                                  color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                )
                                            ),
                                            child: Text(notifier.fakeMeanList[index][0],style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ElevatedButton(
                                            onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                              notifier.tapButtonList[index] = true;
                                              notifier.answeredFalseList[index] = true;
                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                side: BorderSide(
                                                  width: 5,
                                                  color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                )
                                            ),
                                            child: Text(notifier.fakeMeanList[index][1],style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ElevatedButton(
                                            onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                              notifier.tapButtonList[index] = true;
                                              notifier.answeredFalseList[index] = true;
                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: notifier.tapButtonList[index] ? Colors.redAccent : Colors.transparent,
                                                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                side: BorderSide(
                                                  width: 5,
                                                  color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                )
                                            ),
                                            child: Text(notifier.fakeMeanList[index][2],style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ElevatedButton(
                                            onPressed: (notifier.tapButtonList[index] == true) ? (){} : (){
                                              notifier.tapButtonList[index] = true;
                                              notifier.answeredCorrectList[index] = true;
                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: notifier.tapButtonList[index] ? Colors.green : Colors.transparent,
                                                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                side: BorderSide(
                                                  width: 5,
                                                  color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                                                )
                                            ),
                                            child: Text(Means[notifier.testList[index].toUpperCase()]![0],style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ),
                                        ),
                                      ],
                                    )
                                  ]
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    loop: false,
                    itemCount: 10,
                    viewportFraction: 1,
                    layout: SwiperLayout.DEFAULT,
                    pagination: const SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                        activeColor: Colors.green,
                        color: Colors.grey,
                        activeSize: 15,
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Visibility(
                  visible: (notifier.tapButtonList[0] && notifier.tapButtonList[1] && notifier.tapButtonList[2]
                      && notifier.tapButtonList[3] && notifier.tapButtonList[4] && notifier.tapButtonList[5]
                      && notifier.tapButtonList[6] && notifier.tapButtonList[7] && notifier.tapButtonList[8] && notifier.tapButtonList[9]),
                  child: Container(
                    width: size.width*0.8,
                    height: size.height*0.12,
                    color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('xx out of ${notifier.testList.length}',style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900
                        ),),
                        const Text('questions correct!!',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900
                        ),),
                        const Text('Congratulations!!',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),)
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Visibility(
                  visible: (notifier.tapButtonList[0] && notifier.tapButtonList[1] && notifier.tapButtonList[2]
                      && notifier.tapButtonList[3] && notifier.tapButtonList[4] && notifier.tapButtonList[5]
                      && notifier.tapButtonList[6] && notifier.tapButtonList[7] && notifier.tapButtonList[8] && notifier.tapButtonList[9]
                  ),
                  child: SizedBox(
                    width: size.width*0.7,
                    height: size.height*0.08,
                    child: ElevatedButton(
                      onPressed: (){
                        print('back');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                      child: const Text('Back to CheckList',style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
