import 'package:shared_preferences/shared_preferences.dart';

setChartStatsFiveWords({required int currentRow}) async {

  List<int> distribution = [0,0,0,0,0,0];
  List<String> distributionString = [];

  final stats = await getChartStatsFiveWords();

  if(stats != null){
    distribution = stats;
  }

  for(int i = 0;i < 6;i++){
    if(currentRow - 1 == i){
      distribution[i]++;
    }
  }

  for(var e in distribution){
    distributionString.add(e.toString());
  }

  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('row_five_words', currentRow);
  prefs.setStringList('chart_five_words', distributionString);
}


Future<List<int>?> getChartStatsFiveWords() async {
  final prefs = await SharedPreferences.getInstance();
  final stats = prefs.getStringList('chart_five_words');
  if(stats != null){
    List<int> result = [];
    for(var e in stats){
      result.add(int.parse(e));
    }
    return result;
  }else{
    return null;
  }

}