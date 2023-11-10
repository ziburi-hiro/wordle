import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/screen/all_word_test_page.dart';
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
              const Text('Select Test Mode',style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 24,
              ),),

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Checkbox(
                      value: notifier.testModeALL,
                      fillColor: MaterialStateProperty.resolveWith((states) => Colors.green),
                      onChanged: (bool? value) {
                        setState(() {
                          if(notifier.testModeRandom == true){
                            notifier.testModeALL = value!;
                            notifier.testModeRandom = false;
                          }else{
                            notifier.testModeALL = value!;
                          }
                        });
                      },
                    ),
                    const Text('All word Test',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),)
                  ],
                ),
              ),

              Row(
                children: [
                  Checkbox(
                    value: notifier.testModeRandom,
                    fillColor: MaterialStateProperty.resolveWith((states) => Colors.green),
                    onChanged: (bool? value) {
                      setState(() {
                        if(notifier.testModeALL == true){
                          notifier.testModeRandom = value!;
                          notifier.testModeALL = false;
                        }else{
                          notifier.testModeRandom = value!;
                        }
                      });
                    },
                  ),
                  const Text('Random 10 word Test',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),)
                ],
              ),

              SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  onPressed: (){
                    if(notifier.testModeALL == true && notifier.testModeRandom == false){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AllWordTestPage()));
                    }else if(notifier.testModeALL == false && notifier.testModeRandom == true){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AllWordTestPage()));
                    }else{
                      runQuickBox(context: context, message: 'Select test mode');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                  child: const Text('Start Test',style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              )
            ],
          ),
          );
        },
      ),
    );
  }
}
