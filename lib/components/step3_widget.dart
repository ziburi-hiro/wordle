import 'package:flutter/material.dart';

class Step3 extends StatelessWidget {
  const Step3({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Step 3',style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),),
        Container(
          height: size.height*0.51,
          child: Image.asset(
            'assets/images/Step3.gif',
            fit: BoxFit.contain,
          ),
        ),

      ],
    );
  }
}