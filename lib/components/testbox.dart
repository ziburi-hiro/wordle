import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/screen/random_word_test_page.dart';
import 'package:wordle/utils/checkList_preferences.dart';
import 'package:wordle/utils/quick_box.dart';

class TestBox extends StatefulWidget {
  const TestBox({super.key});

  @override
  State<TestBox> createState() => _TestBoxState();
}

class _TestBoxState extends State<TestBox> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
      content: Consumer<Controller>(
        builder: (_ , notifier , __) {
          return SizedBox(
            width: size.width*0.8,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('10 words Test',style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 26,
                ),),

                const Text('Test random 10 words \n from your checklist!',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),

                FutureBuilder(
                  future: CheckListPreferences.getCheckList(),
                  builder: (context, snapshot) {
                    List<String> checkList = [];
                    if (snapshot.hasData) {
                      checkList = snapshot.data as List<String>;
                    }
                    return SizedBox(
                      width: 200,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (
                                  context) => const RandomWordTestPage()));
                          notifier.choiceTestWord(list: checkList);
                          notifier.makePositionNum();
                          notifier.makeFakeWordList();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                        ),
                        child: const Text('Start Test', style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                    );
                  }
                )
              ],
            ),
          );
        },
      ),
    );
  }
}