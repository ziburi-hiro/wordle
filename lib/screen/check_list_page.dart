import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/components/testBox.dart';
import 'package:wordle/components/testbox_fivewords.dart';
import 'package:wordle/constants/five_words_means.dart';
import 'package:wordle/constants/means.dart';
import 'package:wordle/main.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/providers/theme_provider.dart';
import 'package:wordle/utils/checkList_preferences.dart';
import 'package:wordle/utils/checkList_preferences_fivewords.dart';
import 'package:wordle/utils/quick_box.dart';

class CheckListPage extends StatefulWidget {
  const CheckListPage({Key? key}) : super(key: key);

  @override
  State<CheckListPage> createState() => _CheckListPageState();
}

class _CheckListPageState extends State<CheckListPage> with RouteAware{

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // 一度、別の画面に遷移したあとで、再度この画面に戻ってきた時にコールされます。
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(
      builder: (_, notifier , __) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
             title: const Text('CheckList'),
              centerTitle: true,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                labelColor: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.black,
                tabs: const [
                  Tab(text: '4WORDS',),
                  Tab(text: '5WORDS',),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        FutureBuilder(
                          future: CheckListPreferences.getCheckList(),
                          builder: (context, snapshot) {
                            List<String> checkList = [];
                            if(snapshot.hasData){
                              checkList = snapshot.data as List<String>;
                            }
                            return Flexible(
                              child: ListView.builder(
                                itemCount: checkList.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: SizedBox(
                                      height: 70,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0),
                                            child: Text(checkList[index]!,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 26,
                                              ),),
                                          ),

                                          Expanded(
                                            child: Container(),),

                                          Column(
                                            mainAxisAlignment:MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text('意味：${Means[checkList[index].toUpperCase()]![0]}',style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                              Text('品詞：${Means[checkList[index].toUpperCase()]![1]}',style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                            ],
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  checkList.remove(checkList[index]);
                                                  CheckListPreferences.saveCheckList(list: checkList);
                                                });
                                              },
                                              icon: const Icon(Icons.delete),
                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        ),
                        FutureBuilder(
                          future: CheckListPreferences.getCheckList(),
                          builder: (context, snapshot) {
                            List<String> checkList = [];
                            if (snapshot.hasData) {
                              checkList = snapshot.data as List<String>;
                            }
                            return Container(
                              width: double.infinity,
                              height: 70,
                              color: Colors.green,
                              child: ElevatedButton(
                                onPressed: (){
                                  if(checkList.isEmpty){
                                    runQuickBox(context: context, message: 'No word in checklist!');
                                  }else{
                                    showDialog(context: context, builder: (_) => const TestBox());
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                child: const Text('Lets Test!',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),),
                              ),
                            );
                          }
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    FutureBuilder(
                        future: CheckListPreferencesFiveWords.getCheckListFiveWords(),
                        builder: (context, snapshot) {
                          List<String> checkListFiveWords = [];
                          if(snapshot.hasData){
                            checkListFiveWords = snapshot.data as List<String>;
                          }
                          return Flexible(
                            child: ListView.builder(
                              itemCount: checkListFiveWords.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: SizedBox(
                                    height: 70,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0),
                                          child: Text(checkListFiveWords[index]!,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 26,
                                            ),),
                                        ),

                                        Expanded(
                                          child: Container(),),

                                        Column(
                                          mainAxisAlignment:MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text('意味：${FiveWordsMeans[checkListFiveWords[index].toUpperCase()]![0]}',style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                            Text('品詞：${FiveWordsMeans[checkListFiveWords[index].toUpperCase()]![1]}',style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ],
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0),
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                checkListFiveWords.remove(checkListFiveWords[index]);
                                                CheckListPreferencesFiveWords.saveCheckListFiveWords(list: checkListFiveWords);
                                              });
                                            },
                                            icon: const Icon(Icons.delete),
                                          ),
                                        )

                                      ],
                                    ),
                                  ),
                                );
                              },
                              //physics: const NeverScrollableScrollPhysics(),
                            ),
                          );
                        }
                    ),
                    FutureBuilder(
                        future: CheckListPreferencesFiveWords.getCheckListFiveWords(),
                        builder: (context, snapshot) {
                          List<String> checkListFiveWords = [];
                          if (snapshot.hasData) {
                            checkListFiveWords = snapshot.data as List<String>;
                          }
                          return Container(
                            width: double.infinity,
                            height: 70,
                            color: Colors.green,
                            child: ElevatedButton(
                              onPressed: (){
                                if(checkListFiveWords.isEmpty){
                                  runQuickBox(context: context, message: 'No word in checklist!');
                                }else{
                                  showDialog(context: context, builder: (_) => const TestBoxFiveWords());
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: const Text('Lets Test!',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),),
                            ),
                          );
                        }
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
