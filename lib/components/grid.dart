import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/animations/bounce.dart';
import 'package:wordle/animations/dance.dart';
import 'package:wordle/components/tile.dart';
import 'package:wordle/providers/controller.dart';

class Grid extends StatelessWidget {
  const Grid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(36, 20, 36, 20),
        itemCount: 20,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
          crossAxisCount: 4,
        ),
        itemBuilder: (context, index){
          return Consumer<Controller>(
            builder: (_, notifier , __) {
              bool animate = false;
              bool animateDance = false;
              int danceDelay = 1600;
              if(index == notifier.currentTile - 1 && !notifier.isBackOrEnterTapped){
                animate = true;
              }
              if(notifier.gameWon){
                for(int i = notifier.tilesEntered.length - 4; i < notifier.tilesEntered.length; i++){
                  if(index == i){
                    animateDance = true;
                    danceDelay += 150 * (i - ((notifier.currentRow - 1) * 4));
                  }
                }
              }
              return Dance(
                delay: danceDelay,
                animate: animateDance,
                child: Bounce(
                  animate: animate,
                  child: Tile(index: index,)
            ),
              );
            },
          );
        }
    );
  }
}

