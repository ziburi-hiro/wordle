import 'package:flutter/material.dart';
import 'package:wordle/components/stats_box.dart';
import 'package:wordle/components/stats_chart.dart';
import 'package:wordle/components/stats_chart_fivewords.dart';
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('STATICS'),
          centerTitle: true,
          elevation: 0,
          bottom: const TabBar(
            indicatorColor: Colors.grey,
            labelColor: Colors.black,
            tabs: [
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
  }
}
