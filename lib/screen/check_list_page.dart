import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/providers/theme_provider.dart';

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
                    ListView.builder(
                      itemCount: notifier.checkList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return Card(
                          child: SizedBox(
                            height: 60,
                            child: Text(notifier.checkList[index]!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                            ),),
                          ),
                        );
                      },
                      physics: const NeverScrollableScrollPhysics(),
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
