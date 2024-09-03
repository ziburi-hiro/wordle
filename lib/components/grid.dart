import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wordle/animations/bounce.dart';
import 'package:wordle/animations/dance.dart';
import 'package:wordle/components/tile.dart';
import 'package:wordle/components/tileFiveWords.dart';
import 'package:wordle/providers/controller.dart';

class Grid extends StatelessWidget {
  const Grid({
    super.key, required this.itemCount, required this.space, required this.axisCount,required this.mode
  });
  final int itemCount;
  final double space;
  final int axisCount;
  final String mode;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: Container(
        width: double.infinity,
        height: size.height*0.55,
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: (size.width >= 500) ? EdgeInsets.fromLTRB(80.w, 30.h, 80.w,30.h) : EdgeInsets.fromLTRB(30.w, 20.h, 30.w,20.h),
            itemCount: itemCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: space,
              crossAxisSpacing: space,
              crossAxisCount: axisCount,
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
                    for(int i = notifier.tilesEntered.length - axisCount; i < notifier.tilesEntered.length; i++){
                      if(index == i){
                        animateDance = true;
                        danceDelay += 150 * (i - ((notifier.currentRow - 1) * axisCount));
                      }
                    }
                  }
                  return Dance(
                    delay: danceDelay,
                    animate: animateDance,
                    child: Bounce(
                      animate: animate,
                      child: (mode == 'FourWords') ? Tile(index: index,) :  TileFiveWords(index: index,)
                    ),
                  );
                },
              );
            }
        ),
      ),
    );
  }
}

