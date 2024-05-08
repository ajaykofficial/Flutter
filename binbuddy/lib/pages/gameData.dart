import 'package:shared_preferences/shared_preferences.dart';

class GameData {
  static const String levelKey = 'current_level';
  static const String correctSortingKey = 'correct_sortings';
  static const String incorrectSortingKey = 'incorrect_sortings';

  static Future<int> getCurrentLevel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(levelKey) ?? 0;
  }

  static Future<void> setCurrentLevel(int level) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(levelKey, level);
  }

  static Future<int> getCorrectSortings() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(correctSortingKey) ?? 0;
  }

  static Future<void> setCorrectSortings(int count) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(correctSortingKey, count);
  }

  static Future<int> getIncorrectSortings() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(incorrectSortingKey) ?? 0;
  }

  static Future<void> setIncorrectSortings(int count) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(incorrectSortingKey, count);
  }
}
