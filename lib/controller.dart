import 'package:flutter/cupertino.dart';
import 'package:wordle/constants/answer_stages.dart';

import 'models/tile_model.dart';

class Controller extends ChangeNotifier {

  String correctWord = "";
  int currentTile = 0;
  int currentRow = 0;
  List<TileModel> tilesEntered = [];

  setCorrectWord({required String word}) => correctWord = word;

  setKeyTapped({required String value}) {

    if(value == 'ENTER'){
      if(currentTile == 4 * (currentRow + 1)){
        checkWord();
      }

    }else if(value == 'BACK'){
      if(currentTile > 4 * (currentRow + 1) - 4){
        currentTile--;
        tilesEntered.removeLast();
      }

    }else{
      if(currentTile < 4 * (currentRow + 1)){
        tilesEntered.add(TileModel(letter: value, answerStage: AnswerStage.notAnswered));
        currentTile++;
      }
    }
    notifyListeners();
  }

  checkWord(){

    List<String> guessed = [];
    List<String> remainingCorrect = [];
    String guessedWord = "";

    for(int i = currentRow * 4; i < (currentRow * 4) + 4; i++){
      guessed.add(tilesEntered[i].letter);
    }

    guessedWord = guessed.join();
    remainingCorrect = correctWord.characters.toList();

    if(guessedWord == correctWord){
      print("word guessed correct");
    }else{
      for(int i = 0;i < 4;i++){
        if(guessedWord[i] == correctWord[i]){
          remainingCorrect.remove(guessedWord[i]);
          print('letter guessed at ${guessedWord[i]}');
        }
      }

      for(int i = 0; i < remainingCorrect.length; i++){
        for(int j = 0; j < 4;j++){
          if(remainingCorrect[i] == tilesEntered[j + (currentRow * 4)].letter){
            print('contans ${remainingCorrect[i]}');
          }
        }
      }

    }

    currentRow++;

  }
}
