import 'package:flutter/material.dart';

class Step1 extends StatelessWidget {
  const Step1({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Step 1',style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),),
        Container(
          height: size.height*0.51,
          child: Image.asset(
            'assets/images/Step1.gif',
            fit: BoxFit.contain,
          ),
        ),

      ],
    );
  }
}