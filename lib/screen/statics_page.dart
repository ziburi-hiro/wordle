import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/components/stats_box.dart';
import 'package:wordle/components/stats_chart.dart';
import 'package:wordle/components/stats_chart_fivewords.dart';
import 'package:wordle/providers/theme_provider.dart';
import 'package:wordle/screen/help_page.dart';
import 'package:wordle/screen/settings.dart';
import 'package:wordle/utils/calculate_stats.dart';
import 'package:wordle/utils/calculate_stats_fivewords.dart';

class StaticsPage extends StatefulWidget {
  const StaticsPage({Key? key}) : super(key: key);

  @override
  State<StaticsPage> createState() => _StaticsPageState();
}

class _StaticsPageState extends State<StaticsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, notifier, __) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('STATICS'),
              centerTitle: true,
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HelpPage()
                    ));
                  },
                  icon: const Icon(Icons.help_outline),
                ),
                IconButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Settings()
                      ));
                    },
                    icon: const Icon(Icons.settings)
                )
              ],
              bottom: TabBar(
                indicatorColor: notifier.isDark ? Colors.white : Colors.grey,
                labelColor: notifier.isDark ? Colors.white : Colors.black,
                tabs: const [
                  Tab(text: '4WORDS',),
                  Tab(text: '5WORDS',),
                ],
              ),
            ),
              body: TabBarView(
                children: [
                ///4word
                  Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: FutureBuilder(
                          future: getStats(),
                          builder: (context, snapshot) {
                           List<String> results = ['0','0','0','0','0'];
                            if(snapshot.hasData){
                            results = snapshot.data as List<String>;
                          }
                          return Row(
                           children: [
                              StatsTile(heading: 'Played',value: int.parse(results[0]),),
                              StatsTile(heading: 'Win %',value: int.parse(results[2]),),
                              StatsTile(heading: 'Current\nStreak',value: int.parse(results[3]),),
                              StatsTile(heading: 'Max\nStreak',value: int.parse(results[4]),),
                            ],
                          );
                        },
                      ),
                    ),

                    Text('GUESS DISTRIBUTION',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: notifier.isDark ? Colors.white : Colors.black
                    ),),

                    const Expanded(
                      flex: 7,
                      child: StatsChart(),
                   ),
                  ],
                ),
                ///5word
                Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: FutureBuilder(
                        future: getStatsFiveWords(),
                        builder: (context, snapshot) {
                          List<String> results = ['0','0','0','0','0'];
                          if(snapshot.hasData){
                            results = snapshot.data as List<String>;
                          }
                          return Row(
                            children: [
                              StatsTile(heading: 'Played',value: int.parse(results[0]),),
                              StatsTile(heading: 'Win %',value: int.parse(results[2]),),
                              StatsTile(heading: 'Current\nStreak',value: int.parse(results[3]),),
                              StatsTile(heading: 'Max\nStreak',value: int.parse(results[4]),),
                            ],
                          );
                        },
                      ),
                    ),

                    Text('GUESS DISTRIBUTION',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: notifier.isDark ? Colors.white : Colors.black
                    ),),

                    const Expanded(
                      flex: 7,
                      child: StatsChartFiveWords(),
                    ),
                  ],
                ),
              ],
            )
          ),
        );
      },
    );
  }
}
