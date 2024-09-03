import 'package:flutter/material.dart';

class Step2 extends StatelessWidget {
  const Step2({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Step 2',style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),),
        Container(
          height: size.height*0.51,
          child: Image.asset(
            'assets/images/Step2.gif',
            fit: BoxFit.contain,
          ),
        ),

      ],
    );
  }
}