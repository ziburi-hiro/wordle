import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/means.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/providers/theme_provider.dart';
import 'package:wordle/utils/checkList_preferences.dart';

class CheckListPage extends StatefulWidget {
  const CheckListPage({Key? key}) : super(key: key);

  @override
  State<CheckListPage> createState() => _CheckListPageState();
}

class _CheckListPageState extends State<CheckListPage> {
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
                Column(
                  children: [
                    FutureBuilder(
                      future: CheckListPreferences.getCheckList(),
                      builder: (context, snapshot) {
                        List<String> checkList = [];
                        if(snapshot.hasData){
                          checkList = snapshot.data as List<String>;
                        }
                        return ListView.builder(
                          itemCount: checkList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Card(
                              child: SizedBox(
                                height: 50,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0),
                                      child: Text(checkList[index]!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),),
                                    ),

                                    const SizedBox(
                                      width: 20,
                                    ),


                                    Text(Means[checkList[index]
                                        .toUpperCase()]![0]),

                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          checkList.remove(checkList[index]);
                                          CheckListPreferences.saveCheckList(list: checkList);
                                        });
                                      },
                                      icon: Icon(Icons.delete),
                                    )

                                  ],
                                ),
                              ),
                            );
                          },
                          physics: const NeverScrollableScrollPhysics(),
                        );
                      }
                    )
                  ],
                ),
                const Column(
                  children: [
                    Text('abbab')
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
