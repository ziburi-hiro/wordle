import 'package:flutter/material.dart';
import 'package:wordle/components/grid.dart';
import 'package:wordle/components/keyboard_row.dart';
import 'package:wordle/data/key_map.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordle'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 7,
              child: Container(
                color: Colors.yellow,
                child: const Grid(),
              )
          ),
          Expanded(
            flex: 4,
              child: Container(color: Colors.green,
              child: const Column(
                children: [
                  KeyboardRow(min: 1, max: 10,),
                  KeyboardRow(min: 11,max: 19,),
                  KeyboardRow(min: 20, max: 29,),
                ],
              ),
              )
          ),
        ],
      ),
    );
  }
}
