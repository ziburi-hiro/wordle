import 'package:flutter/material.dart';

class AllWordTestPage extends StatefulWidget {
  const AllWordTestPage({super.key});

  @override
  State<AllWordTestPage> createState() => _AllWordTestPageState();
}

class _AllWordTestPageState extends State<AllWordTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('ALLWORDTESTMODE'),
      ),
      body: Text('aaa'),
    );
  }
}
