import 'package:shared_preferences/shared_preferences.dart';

calculateStats({required bool gameWon}) async {
  int gamesPlayed = 0;
  int gamesWon = 0;
  int winPercent = 0;
  int currentSteak = 0;
  int maxStreak = 0;

  final stats = await getStats();
  if(stats != null){
    gamesPlayed = int.parse(stats[0]);
    gamesWon = int.parse(stats[1]);
    winPercent = int.parse(stats[2]);
    currentSteak = int.parse(stats[3]);
    maxStreak = int.parse(stats[4]);
  }

  gamesPlayed++;

  if(gameWon){
    gamesWon++;
    currentSteak++;
  }else{
    currentSteak = 0;
  }

  if(currentSteak > maxStreak){
    maxStreak = currentSteak;
  }

  winPercent = ((gamesWon / gamesPlayed) * 100).toInt();

  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList('stats', [
    gamesPlayed.toString(),
    gamesWon.toString(),
    winPercent.toString(),
    currentSteak.toString(),
    maxStreak.toString(),

  ]);

}

Future<List<String>?> getStats() async {
  final prefs = await SharedPreferences.getInstance();
  final stats = prefs.getStringList('stats');
  if(stats != null){
    return stats;
  }else{
    return null;
  }
}