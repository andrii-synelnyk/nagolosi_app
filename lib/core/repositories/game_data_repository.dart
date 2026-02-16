import 'package:nagolosi_app/core/services/asset_service.dart';
import 'package:nagolosi_app/core/services/shared_preferences_service.dart';

class GameDataRepository {
  GameDataRepository(this._assetService, this._preferenceService);

  final AssetService _assetService;
  final SharedPreferencesService _preferenceService;

  Future<List<String>> loadAssetWords() async {
    final words = await _assetService.loadWords();
    return words;
  }

  Future<List<String>> loadSavedWords() async {
    final words = await _preferenceService.loadWords();
    return words;
  }

  Future<int> loadWordsPerLevel() async {
    final wordsPerLevel = await _preferenceService.loadWordsPerLevel();
    return wordsPerLevel;
  }

  Future<List<String>> loadLevelResults() async {
    final levelResults = await _preferenceService.loadLevelResults();
    return levelResults;
  }

  Future<bool> loadRulesSeen() async {
    final rulesSeen = await _preferenceService.loadRulesSeen();
    return rulesSeen;
  }

  Future<void> saveWords(List<String> words) async {
    await _preferenceService.saveWords(words);
  }

  Future<void> saveWordsPerLevel(int wordsPerLevel) async {
    await _preferenceService.saveWordsPerLevel(wordsPerLevel);
  }

  Future<void> saveResults(List<String> results) async {
    await _preferenceService.saveResults(results);
  }

  Future<void> saveRulesSeen() async {
    await _preferenceService.saveRulesSeen(true);
  }
}
