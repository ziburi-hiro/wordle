import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/data/key_map.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/screen/home_page.dart';

class TitleBackBox extends StatelessWidget {
  const TitleBackBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Back to Title?',
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 22
        ),
      ),
      content: const Text('You cant go back to this game\nCan I go back to the title?',
        style: TextStyle(
          fontSize: 16,
      ),),
      actions: [
        CupertinoDialogAction(
          child: const Text('NO'),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: const Text('YES'),
          onPressed: (){
            keyMap.updateAll((key, value) => value = AnswerStage.notAnswered);
            Provider.of<Controller>(context, listen: false).gameReset();

            Navigator.pop(context);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
      ],
    );
  }
}
