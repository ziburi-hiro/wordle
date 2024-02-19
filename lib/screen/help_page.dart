import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/colors.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/providers/theme_provider.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: Consumer<Controller>(
        builder: (_, notifier , __) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Help'),
                centerTitle: true,
                elevation: 0,
                bottom: TabBar(
                  indicatorColor: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.grey,
                  labelColor: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.black,
                  tabs: const [
                    Tab(text: "What's WORDRILL",),
                    Tab(text: 'How to play',),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  //what's WORDRILL
                  SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: size.height*1.5,
                          //color: Colors.yellow,
                          child: Column(
                            children: [
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text('WORDRILLとは？',style: TextStyle(
                                  fontSize: 25.sp
                                ),),
                              ),
                              const Divider(
                                height: 20,
                                thickness: 5,
                                indent: 0,
                                endIndent: 0,
                                color: correctGreen,
                              ),
                              Text('WORDRILLnosetumei',style: TextStyle(
                                  fontSize: 20.sp
                              ),),

                              SizedBox(
                                height: 30,
                              ),

                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text('NormalModeとQuizModeの違い',style: TextStyle(
                                    fontSize: 25.sp
                                ),),
                              ),
                              const Divider(
                                height: 20,
                                thickness: 5,
                                indent: 0,
                                endIndent: 0,
                                color: containsYellow,
                              ),
                              Text('WORDRILLnosetumeiあああああああああああああああああああああああああああああああ',style: TextStyle(
                                  fontSize: 20.sp
                              ),),

                              SizedBox(
                                height: 30,
                              ),

                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text('４文字版と５文字版',style: TextStyle(
                                    fontSize: 25.sp
                                ),),
                              ),
                              const Divider(
                                height: 20,
                                thickness: 5,
                                indent: 0,
                                endIndent: 0,
                                color: Color.fromARGB(255, 120, 124, 127),
                              ),
                              Text('WORDRILLnosetumeiあああああああああああああああああああああああああああああああ',style: TextStyle(
                                  fontSize: 20.sp
                              ),),

                              SizedBox(
                                height: 30,
                              ),

                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text('VIEW CHECKLISTとは？',style: TextStyle(
                                    fontSize: 25.sp
                                ),),
                              ),
                              const Divider(
                                height: 20,
                                thickness: 5,
                                indent: 0,
                                endIndent: 0,
                                color: correctGreen,
                              ),
                              Text('WORDRILLnosetumei',style: TextStyle(
                                  fontSize: 20.sp
                              ),),

                              SizedBox(
                                height: 30,
                              ),

                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text('VIEW STATICSとは？',style: TextStyle(
                                    fontSize: 25.sp
                                ),),
                              ),
                              const Divider(
                                height: 20,
                                thickness: 5,
                                indent: 0,
                                endIndent: 0,
                                color: containsYellow,
                              ),
                              Text('WORDRILLnosetumeiあああああああああああああああああああああああああああああああ',style: TextStyle(
                                  fontSize: 20.sp
                              ),),

                              SizedBox(
                                height: 30,
                              ),

                            ],
                          )
                        ),
                      )
                  ),

                  //how to play
                  Text("bb")
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
