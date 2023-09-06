import 'package:flutter/cupertino.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/data/key_map.dart';

import 'models/tile_model.dart';

class Controller extends ChangeNotifier {

  bool checkLine = false;
  bool isBackOrEnterTapped = false;
  bool gameWon = false;
  String correctWord = "";
  int currentTile = 0;
  int currentRow = 0;
  List<TileModel> tilesEntered = [];

  setCorrectWord({required String word}) => correctWord = word;

  setKeyTapped({required String value}) {

    if(value == 'ENTER'){
      if(currentTile == 4 * (currentRow + 1)){
        isBackOrEnterTapped = true;
        checkWord();
      }

    }else if(value == 'BACK'){
      if(currentTile > 4 * (currentRow + 1) - 4){
        currentTile--;
        tilesEntered.removeLast();
        isBackOrEnterTapped = true;
      }

    }else{
      if(currentTile < 4 * (currentRow + 1)){
        tilesEntered.add(TileModel(letter: value, answerStage: AnswerStage.notAnswered));
        currentTile++;
        isBackOrEnterTapped = false;
      }
    }
    notifyListeners();
  }

  checkWord() {
    List<String> guessed = [];
    List<String> remainingCorrect = [];
    String guessedWord = "";

    for (int i = currentRow * 4; i < (currentRow * 4) + 4; i++) {
      guessed.add(tilesEntered[i].letter);
    }

    guessedWord = guessed.join();
    remainingCorrect = correctWord.characters.toList();

    if (guessedWord == correctWord) {
      for (int i = currentRow * 4; i < (currentRow * 4) + 4; i++) {
        tilesEntered[i].answerStage = AnswerStage.correct;
        keyMap.update(tilesEntered[i].letter, (value) => AnswerStage.correct);
        gameWon = true;
      }
    } else {
      for (int i = 0; i < 4; i++) {
        if (guessedWord[i] == correctWord[i]) {
          remainingCorrect.remove(guessedWord[i]);
          tilesEntered[i + (currentRow * 4)].answerStage = AnswerStage.correct;
          keyMap.update(guessedWord[i], (value) => AnswerStage.correct);
        }
      }

      for (int i = 0; i < remainingCorrect.length; i++) {
        for (int j = 0; j < 4; j++) {
          if (remainingCorrect[i] ==
              tilesEntered[j + (currentRow * 4)].letter) {
            if (tilesEntered[j + (currentRow * 4)].answerStage !=
                AnswerStage.correct) {
              tilesEntered[j + (currentRow * 4)].answerStage =
                  AnswerStage.contains;
            }

            final resultKey = keyMap.entries.where((element) =>
            element.key == tilesEntered[j + (currentRow * 4)].letter);

            if (resultKey.single.value != AnswerStage.correct) {
              keyMap.update(
                  resultKey.single.key, (value) => AnswerStage.contains);
            }
          }
        }
      }

      for (int i = currentRow * 4; i < (currentRow * 4) + 4; i++) {
        if (tilesEntered[i].answerStage == AnswerStage.notAnswered) {
          tilesEntered[i].answerStage = AnswerStage.incorrect;

          final results = keyMap.entries.where((element) => element.key == tilesEntered[i].letter);
          if(results.single.value == AnswerStage.notAnswered){
            keyMap.update(
                tilesEntered[i].letter, (value) => AnswerStage.incorrect);
          }
        }
      }
    }
    checkLine = true;
    currentRow++;
    notifyListeners();
  }
}
