import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/controller.dart';

class Tile extends StatelessWidget {
  const Tile({required this.index, super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(
        builder: (_, notifier, __){
          String text = "";
          if(index < notifier.tilesEntered.length){
            text = notifier.tilesEntered[index].letter;
            return Center(child: Text(text));
          }else {
            return const SizedBox();
          }
        });
  }
}