import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/constants/colors.dart';
import 'package:wordle/controller.dart';

class Tile extends StatefulWidget {
  const Tile({required this.index, super.key,
  });

  final int index;

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {

  Color _backgroundColor = Colors.transparent;
  Color _borderColor = Colors.transparent;
  late AnswerStage _answerStage;
  
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _borderColor = Theme.of(context).primaryColorLight;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(
        builder: (_, notifier, __){
          String text = "";
          Color fontColor = Colors.white;
          if(widget.index < notifier.tilesEntered.length){
            text = notifier.tilesEntered[widget.index].letter;
            _answerStage = notifier.tilesEntered[widget.index].answerStage;
            if(_answerStage == AnswerStage.correct){
              _borderColor = Colors.transparent;
              _backgroundColor = correctGreen;
            }else if(_answerStage == AnswerStage.contains){
              _borderColor = Colors.transparent;
              _backgroundColor = containsYellow;
            }else if(_answerStage == AnswerStage.incorrect){
              _borderColor = Colors.transparent;
              _backgroundColor = Theme.of(context).primaryColorDark;
            }else{
              fontColor = Theme.of(context).textTheme.bodyMedium?.color ?? Colors.white;
              _backgroundColor = Colors.transparent;
            }

            return Container(
                decoration: BoxDecoration(
                  color: _backgroundColor,
                  border: Border.all(
                    color: _borderColor,
                  )
                ),
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(text, style: TextStyle().copyWith(
                      color: fontColor
                    ),)));
          }else {
            return Container(
              decoration: BoxDecoration(
                  color: _backgroundColor,
                  border: Border.all(
                    color: _borderColor,
                  )
              ),
            );
          }
        });
  }
}