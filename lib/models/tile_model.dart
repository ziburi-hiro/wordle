import 'package:wordle/constants/answer_stages.dart';

class TileModel {

  final String letter;
  AnswerStage answerStage;

  TileModel({required this.letter, required this.answerStage});

}