import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        Text('STEP3',style: GoogleFonts.yuseiMagic(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),),
        Container(
          height: size.height*0.5,
          child: Image.asset(
            'assets/images/STEP3.gif',
            fit: BoxFit.contain,
          ),
        ),

      ],
    );
  }
}