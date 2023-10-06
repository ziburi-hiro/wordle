import 'package:flutter/cupertino.dart';
import 'package:wordle/constants/means.dart';
import 'package:wordle/utils/calculate_chart_stats.dart';
import 'package:wordle/utils/calculate_stats.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/data/key_map.dart';

import '../models/tile_model.dart';

class Controller extends ChangeNotifier {

  bool checkLine = false;
  bool isBackOrEnterTapped = false;
  bool gameWon = false;
  bool gameCompleted = false;
  bool notEnoughLetters = false;
  String correctWord = "";
  List<String> meanList = [];
  String partsOfSpeech = "";
  int currentTile = 0;
  int currentRow = 0;
  List<TileModel> tilesEntered = [];

  setCorrectWord({required String word}) => correctWord = word;

  setCorrectMean({required String word}){
    meanList = Means[word]!;
  }

  gameReset(){
    gameWon = false;
    gameCompleted = false;
    currentTile = 0;
    currentRow = 0;
    tilesEntered.clear();
  }

  setKeyTapped({required String value, required int length}) {

    if(value == 'ENTER'){
      isBackOrEnterTapped = true;
      if(currentTile == length * (currentRow + 1)){
        checkWord(length: length);
      }else{
        notEnoughLetters = true;
      }
    }else if(value == 'BACK'){
      isBackOrEnterTapped = true;
      notEnoughLetters = false;
      if(currentTile > length * (currentRow + 1) - length){
        currentTile--;
        tilesEntered.removeLast();
      }

    }else{
      isBackOrEnterTapped = false;
      notEnoughLetters = false;
      if(currentTile < length * (currentRow + 1)){
        tilesEntered.add(TileModel(letter: value, answerStage: AnswerStage.notAnswered));
        currentTile++;
      }
    }
    notifyListeners();
  }

  checkWord({required int length}) {
    List<String> guessed = [];
    List<String> remainingCorrect = [];
    String guessedWord = "";

    for (int i = currentRow * length; i < (currentRow * length) + length; i++) {
      guessed.add(tilesEntered[i].letter);
    }

    guessedWord = guessed.join();
    remainingCorrect = correctWord.characters.toList();

    if (guessedWord == correctWord) {
      for (int i = currentRow * length; i < (currentRow * length) + length; i++) {
        tilesEntered[i].answerStage = AnswerStage.correct;
        keyMap.update(tilesEntered[i].letter, (value) => AnswerStage.correct);
        gameWon = true;
        gameCompleted = true;
      }
    } else {
      for (int i = 0; i < length; i++) {
        if (guessedWord[i] == correctWord[i]) {
          remainingCorrect.remove(guessedWord[i]);
          tilesEntered[i + (currentRow * length)].answerStage = AnswerStage.correct;
          keyMap.update(guessedWord[i], (value) => AnswerStage.correct);
        }
      }

      for (int i = 0; i < remainingCorrect.length; i++) {
        for (int j = 0; j < length; j++) {
          if (remainingCorrect[i] ==
              tilesEntered[j + (currentRow * length)].letter) {
            if (tilesEntered[j + (currentRow * length)].answerStage !=
                AnswerStage.correct) {
              tilesEntered[j + (currentRow * length)].answerStage =
                  AnswerStage.contains;
            }

            final resultKey = keyMap.entries.where((element) =>
            element.key == tilesEntered[j + (currentRow * length)].letter);

            if (resultKey.single.value != AnswerStage.correct) {
              keyMap.update(
                  resultKey.single.key, (value) => AnswerStage.contains);
            }
          }
        }
      }

      for (int i = currentRow * length; i < (currentRow * length) + length; i++) {
        if (tilesEntered[i].answerStage == AnswerStage.notAnswered) {
          tilesEntered[i].answerStage = AnswerStage.incorrect;

          final results = keyMap.entries.where((element) => element.key == tilesEntered[i].letter);
          if(results.single.value == AnswerStage.notAnswered){
            keyMap.update(
                tilesEntered[i].letter, (value) => AnswerStage.incorrect);
          }else{
            return false;
          }
        }
      }
    }
    checkLine = true;
    currentRow++;

    if(currentRow == length + 1){
      gameCompleted = true;
    }

    if(gameCompleted){
      calculateStats(gameWon: gameWon);
      if(gameWon){
        setChartStats(currentRow: currentRow);
      }
    }

    notifyListeners();
  }
}
