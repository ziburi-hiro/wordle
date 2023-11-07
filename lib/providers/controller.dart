import 'package:flutter/cupertino.dart';
import 'package:wordle/constants/five_words_means.dart';
import 'package:wordle/constants/means.dart';
import 'package:wordle/utils/calculate_chart_stats.dart';
import 'package:wordle/utils/calculate_chart_stats_fivewords.dart';
import 'package:wordle/utils/calculate_stats.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/data/key_map.dart';
import 'package:wordle/utils/calculate_stats_fivewords.dart';
import 'package:wordle/utils/checkList_preferences.dart';

import '../models/tile_model.dart';

class Controller extends ChangeNotifier {

  bool checkLine = false;
  bool isBackOrEnterTapped = false;
  bool gameWon = false;
  bool gameCompleted = false;
  bool notEnoughLetters = false;
  bool tapButton = false;
  bool answeredCorrect = false;
  bool answeredFalse = false;
  bool addListCheck = false;
  String correctWord = "";
  List<String> checkList = [];
  List<String> meanList = [];
  List<String> choicesList = [];
  List<String> choicesMean = [];
  List<String> meanList_5words = [];
  String partsOfSpeech = "";
  String partsOfSpeech_5words = "";
  int currentTile = 0;
  int currentRow = 0;
  int answerPositionNum = 0;
  List<TileModel> tilesEntered = [];

  setCorrectWord({required String word}) => correctWord = word;

  setCorrectMean({required String word}){
    meanList = Means[word]!;
  }

  setAnswerPositionNum({required int num}){
    answerPositionNum = num;
  }

  setCorrectMeanFiveWords({required String word}){
    meanList_5words = FiveWordsMeans[word]!;
  }
  
  setChoicesWord({required String choices1, required String choices2, required String choices3}){
    choicesList = [choices1,choices2,choices3];
  }

  setChoicesMean({required String choices1, required String choices2, required String choices3}){
    choicesMean.add(Means[choices1]![0]);
    choicesMean.add(Means[choices2]![0]);
    choicesMean.add(Means[choices3]![0]);
  }

  gameReset(){
    gameWon = false;
    gameCompleted = false;
    tapButton = false;
    answeredCorrect = false;
    answeredFalse = false;
    addListCheck = false;
    currentTile = 0;
    currentRow = 0;
    answerPositionNum = 0;
    tilesEntered.clear();
    choicesMean.clear();
  }

  addCheckList({required String word,required List<String> list}){
    if(list.contains(word) == false){
      list.add(word);
      list.sort(((a,b) => a.compareTo(b)));
      CheckListPreferences.saveCheckList(list: list);
    }
  }

  deleteCheckList({required String word,required List<String> list}){
    list.remove(word);
    CheckListPreferences.saveCheckList(list: list);
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
      if(length == 4){
        calculateStats(gameWon: gameWon);
      }else if(length == 5){
        calculateStatsFiveWords(gameWon: gameWon);
      }else{
        return false;
      }
      if(gameWon){
        if(length == 4){
          setChartStats(currentRow: currentRow);
        }else if(length == 5){
          setChartStatsFiveWords(currentRow: currentRow);
        }else{
          return false;
        }
      }
    }

    notifyListeners();
  }
}
