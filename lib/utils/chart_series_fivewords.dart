import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle/models/chart_model.dart';

Future<List<charts.Series<ChartModel, String>>> getSeriesFiveWords() async {

  List<ChartModel> data = [];
  final prefs = await SharedPreferences.getInstance();
  final scores = prefs.getStringList('chart_five_words');
  final row = prefs.getInt('row_five_words');
  if(scores != null){
    for(var e in scores){
      data.add(ChartModel(score: int.parse(e), currentGame: false));
    }
  }
  if(row != null){
    data[row - 1].currentGame = true;
  }

  return [
    charts.Series<ChartModel, String>(
        id: 'Stats_five_words',
        data: data,
        domainFn: (model, index){
          int i = index! + 1;
          return i.toString();
        },
        measureFn: (model, index) => model.score,
        colorFn: (model, index){
          if(model.currentGame){
            return charts.MaterialPalette.green.shadeDefault;
          }else{
            return charts.MaterialPalette.gray.shadeDefault;
          }
        },
        labelAccessorFn: (model, index) => model.score.toString()
    )
  ];
}