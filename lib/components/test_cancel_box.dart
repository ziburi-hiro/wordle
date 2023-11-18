import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/data/key_map.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/screen/home_page.dart';

class TestCancelBox extends StatelessWidget {
  const TestCancelBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Back to CheckList?',
        style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 22
        ),
      ),
      content: const FittedBox(
        fit: BoxFit.fitWidth,
        child: Text('You cant go back to this game.\nDo you want to interrupt this test?',
          style: TextStyle(
            fontSize: 16,
          ),),
      ),
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
            Provider.of<Controller>(context, listen: false).testReset();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
