import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _kWords = 'words';
  static const String _kWordsPerLevel = 'wordsPerLevel';
  static const String _kResults = 'results';
  static const String _kRulesSeen = 'rulesSeen';

  Future<List<String>> loadWords() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_kWords) ?? [];
  }

  Future<int> loadWordsPerLevel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kWordsPerLevel) ?? 0;
  }

  Future<List<String>> loadLevelResults() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_kResults) ?? [];
  }

  Future<bool> loadRulesSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kRulesSeen) ?? false;
  }

  Future<void> saveWords(List<String> words) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_kWords, words);
  }

  Future<void> saveWordsPerLevel(int wordsPerLevel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kWordsPerLevel, wordsPerLevel);
  }

  Future<void> saveResults(List<String> results) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_kResults, results);
  }

  Future<void> saveRulesSeen(bool rulesSeen) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kRulesSeen, rulesSeen);
  }
}
