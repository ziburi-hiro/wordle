import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: AlertDialog(
        content: Consumer<Controller>(
          builder: (_ , notifier , __) {
            return SizedBox(
              width: size.width*0.8,
              height: size.height*0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Four Characters',style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 26.sp,
                  ),),

                  FutureBuilder(
                    future: CheckListPreferences.getCheckList(),
                    builder: (context, snapshot) {
                      List<String> checkList = [];
                      if (snapshot.hasData) {
                        checkList = snapshot.data as List<String>;
                      }
                      return Column(
                        children: [
                          (checkList.length > 9) ?
                          Text('Test random 10 words \n from your checklist!',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),)
                              :
                          Text('Test random ${checkList.length} words \n from your checklist!',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),),

                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: SizedBox(
                              width: size.width*0.6,
                              height: size.height*0.06,
                              child: ElevatedButton(
                                onPressed: () {
                                  notifier.testInit(list: checkList);
                                  notifier.choiceTestWord(list: checkList);
                                  notifier.makePositionNum(list: checkList);
                                  notifier.makeFakeWordList(list: checkList);
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (
                                          context) => const RandomWordTestPage()));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )
                                ),
                                child: const Text('Start Test', style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}