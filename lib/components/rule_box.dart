import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/components/step1_widget.dart';
import 'package:wordle/components/step2_widget.dart';
import 'package:wordle/components/step3_widget.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/utils/rule_preferences.dart';

class RuleBox extends StatefulWidget {
  const RuleBox({super.key});

  @override
  State<RuleBox> createState() => _RuleBoxState();
}

class _RuleBoxState extends State<RuleBox> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<Widget> list = [Step1(size: size),Step2(size: size),Step3(size: size)];

    return AlertDialog(
      content: SizedBox(
        width: size.width*0.9,
        height: size.height*0.7,
        child: Column(
          children: [
            Text('Game Rule',style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),),

            SizedBox(
              height: 5,
            ),

            Container(
              height: size.height*0.55,
              //color: Colors.grey,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return list[index];
                },
                loop: false,
                itemCount: 3,
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

            SizedBox(
              height: size.height*0.03,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder(
                      future: RulePreferences.getRuleCheckBox(),
                      builder: (context, snapshot) {
                        return Transform.scale(
                          scale: 1.0,
                          child: Checkbox(
                            activeColor: Colors.green,
                            value: Provider.of<Controller>(context, listen: false).ruleDisplayCheck,
                            onChanged: (bool? value) {
                              setState(() {
                                Provider.of<Controller>(context, listen: false).ruleDisplayCheck = value!;
                              });
                              RulePreferences.saveRuleCheckBox(checkBox: Provider.of<Controller>(context, listen: false).ruleDisplayCheck);
                            },
                          ),
                        );
                      }
                  ),
                  const Text('今後ルールを表示しない',style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),)
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                width: size.width*0.5,
                height: size.height*0.05,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('I got it',style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


