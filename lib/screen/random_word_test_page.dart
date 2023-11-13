import 'package:flutter/material.dart';

class RandomWordTestPage extends StatefulWidget {
  const RandomWordTestPage({super.key});

  @override
  State<RandomWordTestPage> createState() => _RandomWordTestPageState();
}

class _RandomWordTestPageState extends State<RandomWordTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('RANDOMWORDTESTMODE'),
      ),
      body: Text('bbb'),
    );
  }
}
