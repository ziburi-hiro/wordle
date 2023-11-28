import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/components/test_cancel_box.dart';
import 'package:wordle/components/test_result_box.dart';
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text('10WRODTEST'),
          actions: [
            Visibility(
              visible: (Provider.of<Controller>(context, listen: false)
                  .tapButtonList
                  .where((element) => element == true)
                  .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length),
              child: IconButton(
                onPressed: (){
                  showDialog(context: context, builder: (_) => const TestResultBox());
                },
                icon: const Icon(Icons.description_outlined),
              ),
            ),
            IconButton(
              onPressed: (){
                showDialog(context: context, builder: (_) => const TestCancelBox());
              },
              icon: const Icon(Icons.clear),
            )
          ],
        ),
        body: FutureBuilder(
          future: CheckListPreferences.getCheckList(),
          builder: (context,snapshot){
            List<String> checkList = [];
            if(snapshot.hasData){
              checkList = snapshot.data as List<String>;
            }
            return Consumer<Controller>(
              builder: (_, notifier, __) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.7,
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
                                        fontSize: 35,
                                        fontWeight: FontWeight.w900
                                    ),
                                  ),

                                  const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text('What is this word mean?',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 2,
                                            fontWeight: FontWeight.w900
                                        ),
                                      ),
                                    ),
                                  ),

                                  Text('"${notifier.testList[index]}"',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 30,
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
                                                    notifier.testCounter++;
                                                    if(Provider.of<Controller>(context, listen: false)
                                                        .tapButtonList
                                                        .where((element) => element == true)
                                                        .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                      showDialog(context: context, builder: (_) => const TestResultBox());
                                                    }
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
                                                    if(Provider.of<Controller>(context, listen: false)
                                                        .tapButtonList
                                                        .where((element) => element == true)
                                                        .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                      showDialog(context: context, builder: (_) => const TestResultBox());
                                                    }
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
                                                    if(Provider.of<Controller>(context, listen: false)
                                                        .tapButtonList
                                                        .where((element) => element == true)
                                                        .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                      showDialog(context: context, builder: (_) => const TestResultBox());
                                                    }
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
                                                    if(Provider.of<Controller>(context, listen: false)
                                                        .tapButtonList
                                                        .where((element) => element == true)
                                                        .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                      showDialog(context: context, builder: (_) => const TestResultBox());
                                                    }
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
                                                    if(Provider.of<Controller>(context, listen: false)
                                                        .tapButtonList
                                                        .where((element) => element == true)
                                                        .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                      showDialog(context: context, builder: (_) => const TestResultBox());
                                                    }
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
                                                    notifier.testCounter++;
                                                    if(Provider.of<Controller>(context, listen: false)
                                                        .tapButtonList
                                                        .where((element) => element == true)
                                                        .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                      showDialog(context: context, builder: (_) => const TestResultBox());
                                                    }
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
                                                    if(Provider.of<Controller>(context, listen: false)
                                                        .tapButtonList
                                                        .where((element) => element == true)
                                                        .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                      showDialog(context: context, builder: (_) => const TestResultBox());
                                                    }
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
                                                    if(Provider.of<Controller>(context, listen: false)
                                                        .tapButtonList
                                                        .where((element) => element == true)
                                                        .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                      showDialog(context: context, builder: (_) => const TestResultBox());
                                                    }
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
                                                    if(Provider.of<Controller>(context, listen: false)
                                                        .tapButtonList
                                                        .where((element) => element == true)
                                                        .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                      showDialog(context: context, builder: (_) => const TestResultBox());
                                                    }
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
                                                    if(Provider.of<Controller>(context, listen: false)
                                                        .tapButtonList
                                                        .where((element) => element == true)
                                                        .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                      showDialog(context: context, builder: (_) => const TestResultBox());
                                                    }
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
                                                    notifier.testCounter++;
                                                    if(Provider.of<Controller>(context, listen: false)
                                                        .tapButtonList
                                                        .where((element) => element == true)
                                                        .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                      showDialog(context: context, builder: (_) => const TestResultBox());
                                                    }
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
                                                    if(Provider.of<Controller>(context, listen: false)
                                                        .tapButtonList
                                                        .where((element) => element == true)
                                                        .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                      showDialog(context: context, builder: (_) => const TestResultBox());
                                                    }
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
                                                    if(Provider.of<Controller>(context, listen: false)
                                                        .tapButtonList
                                                        .where((element) => element == true)
                                                        .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                      showDialog(context: context, builder: (_) => const TestResultBox());
                                                    }
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
                                                    if(Provider.of<Controller>(context, listen: false)
                                                        .tapButtonList
                                                        .where((element) => element == true)
                                                        .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                      showDialog(context: context, builder: (_) => const TestResultBox());
                                                    }
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
                                                    if(Provider.of<Controller>(context, listen: false)
                                                        .tapButtonList
                                                        .where((element) => element == true)
                                                        .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                      showDialog(context: context, builder: (_) => const TestResultBox());
                                                    }
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
                                                    notifier.testCounter++;
                                                    if(Provider.of<Controller>(context, listen: false)
                                                        .tapButtonList
                                                        .where((element) => element == true)
                                                        .toList().length == Provider.of<Controller>(context, listen: false).tapButtonList.length){
                                                      showDialog(context: context, builder: (_) => const TestResultBox());
                                                    }
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

                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                          Checkbox(
                                            activeColor: Colors.green,
                                            value: notifier.checkRemove[index],
                                            onChanged: (bool? value) {
                                              if(value == true){
                                                notifier.deleteCheckList(word: notifier.testList[index], list: checkList);
                                              }else if(value == false){
                                                notifier.addCheckList(word: notifier.testList[index], list: checkList);
                                              }
                                              setState(() {
                                                notifier.checkRemove[index] = !notifier.checkRemove[index];
                                              });
                                              },
                                          ),
                                          const Text(':  Delete from checkList',style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                        ),)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          loop: false,
                          itemCount: (checkList.length < 10) ? notifier.tapButtonList.length : 10,
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
                  ],
                );
              },
            );
          }
        ),
      ),
    );
  }
}
