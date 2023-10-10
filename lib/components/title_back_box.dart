import 'package:flutter/material.dart';
import 'package:wordle/screen/home_page.dart';

class TitleBackBox extends StatelessWidget {
  const TitleBackBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Back to Title?',
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 22
        ),
      ),
      content: const Text('You cant go back to this game\nCan I go back to the title?'),
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,

                ),
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text('No',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),

            Expanded(
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
                },
                child: const Text('Yes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
