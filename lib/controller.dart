import 'package:flutter/cupertino.dart';

class Controller extends ChangeNotifier {

  int currentTile = 0;
  int currentRow = 0;

  setKeyTapped({required String value}) {

    if(value == 'ENTER'){
      if(currentTile == 4 * (currentRow + 1)){
        currentRow++;
        print('check word');
      }

    }else if(value == 'BACK'){
      if(currentTile > 4 * (currentRow + 1) - 4){
        currentTile--;
      }

    }else{
      if(currentTile < 4 * (currentRow + 1)){
        currentTile++;
      }
    }
    print('current tile $currentTile and currentRow $currentRow');
  }
}