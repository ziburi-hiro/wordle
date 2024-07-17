import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wordle/components/stats_box.dart';
import 'package:wordle/components/stats_chart.dart';
import 'package:wordle/components/stats_chart_fivewords.dart';
import 'package:wordle/constants/colors.dart';
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
    final screenSize = MediaQuery.of(context).size;
    return Consumer<ThemeProvider>(
      builder: (_, notifier, __) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text('成績',style: GoogleFonts.yuseiMagic(
                fontSize: 22,
                  fontWeight: FontWeight.bold,
              ),),
              centerTitle: true,
              elevation: 0,
              actions: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Stack(
                    children: [
                      IconButton(
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HelpPage()
                          ));
                        },
                        icon: const Icon(Icons.help_outline),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text('Help',style: TextStyle(
                            color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.black
                        ),),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  width: 50,
                  height: 50,
                  child: Stack(
                    children: [
                      IconButton(
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Settings()
                            ));
                          },
                          icon: const Icon(Icons.settings)
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text('設定',style: TextStyle(
                            color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.black
                        ),),
                      ),
                    ],
                  ),
                ),
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
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                       height: screenSize.height*0.1,
                                       width: screenSize.width*0.46,
                                       decoration: BoxDecoration(
                                         border: Border.all(
                                           color: correctGreen
                                         ),
                                         borderRadius: BorderRadius.circular(10),
                                       ),
                                       child: Column(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                           Text('プレイ回数',style: GoogleFonts.yuseiMagic(
                                               fontSize: 22,
                                               fontWeight: FontWeight.bold,
                                               color: Colors.black
                                           ),),
                                           Text('${int.parse(results[0])}回',style: GoogleFonts.yuseiMagic(
                                               fontSize: 22,
                                               fontWeight: FontWeight.bold,
                                               color: Colors.black
                                           ),),
                                         ],
                                       ),
                                     ),
                                    Container(
                                      height: screenSize.height*0.1,
                                      width: screenSize.width*0.46,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: containsYellow
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('勝率',style: GoogleFonts.yuseiMagic(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),),
                                          Text('${int.parse(results[2])}%',style: GoogleFonts.yuseiMagic(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: screenSize.height*0.1,
                                      width: screenSize.width*0.46,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: containsYellow
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('連続成功回数',style: GoogleFonts.yuseiMagic(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),),
                                          Text('${int.parse(results[3])}回',style: GoogleFonts.yuseiMagic(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: screenSize.height*0.1,
                                      width: screenSize.width*0.46,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: correctGreen
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('最高連続成功回数',style: GoogleFonts.yuseiMagic(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),),
                                          Text('${int.parse(results[4])}回',style: GoogleFonts.yuseiMagic(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: screenSize.height*0.1,
                                      width: screenSize.width*0.46,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: correctGreen
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('プレイ回数',style: GoogleFonts.yuseiMagic(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),),
                                          Text('${int.parse(results[0])}回',style: GoogleFonts.yuseiMagic(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: screenSize.height*0.1,
                                      width: screenSize.width*0.46,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: containsYellow
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('勝率',style: GoogleFonts.yuseiMagic(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),),
                                          Text('${int.parse(results[2])}%',style: GoogleFonts.yuseiMagic(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: screenSize.height*0.1,
                                      width: screenSize.width*0.46,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: containsYellow
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('連続成功回数',style: GoogleFonts.yuseiMagic(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),),
                                          Text('${int.parse(results[3])}回',style: GoogleFonts.yuseiMagic(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: screenSize.height*0.1,
                                      width: screenSize.width*0.46,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: correctGreen
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('最高連続成功回数',style: GoogleFonts.yuseiMagic(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),),
                                          Text('${int.parse(results[4])}回',style: GoogleFonts.yuseiMagic(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
