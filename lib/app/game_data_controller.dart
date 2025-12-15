import 'package:flutter/foundation.dart';
import 'package:nagolosi_app/core/repositories/game_data_repository.dart';

const wordsPerLevel = 5;

class GameDataController {
  GameDataController(this._repository)
      : isReady = ValueNotifier<bool>(false),
        results = ValueNotifier<List<int>>([]) {
    _init();
  }

  final GameDataRepository _repository;

  final ValueNotifier<bool> isReady;
  final ValueNotifier<List<int>> results;

  late List<String> _assetWords;
  late final List<List<String>> _chunkedWords;
  late List<String> _savedWords;
  late int _savedWordsPerLevel;
  late List<String> _savedResults;

  List<List<String>> get words => _chunkedWords;

  Future<void> _init() async {
    await _loadAsset();
    await _loadPreferences();
    isReady.value = true;
  }

  Future<void> _loadAsset() async {
    _assetWords = await _repository.loadAssetWords();
    _chunkedWords = _chunkWords(_assetWords, wordsPerLevel);
  }

  Future<void> _loadPreferences() async {
    _savedWords = await _repository.loadSavedWords();
    _savedWordsPerLevel = await _repository.loadWordsPerLevel();
    _savedResults = await _repository.loadLevelResults();
    results.value = _savedResults.map(int.parse).toList();

    if (_savedWords.isEmpty ||
        !listEquals(_savedWords, _assetWords) ||
        _savedWordsPerLevel != wordsPerLevel) {
      await _saveCleanData();
    }
  }

  Future<void> _saveCleanData() async {
    final numberOfLevels = _chunkedWords.length;

    final List<String> resultsToSave = List.filled(numberOfLevels, "0");
    results.value = List.filled(numberOfLevels, 0);

    await _repository.saveWords(_assetWords);
    await _repository.saveWordsPerLevel(wordsPerLevel);
    await _repository.saveResults(resultsToSave);
  }

  List<List<String>> _chunkWords(List<String> words, int size) {
    final List<List<String>> chunks = [];

    for (var i = 0; i < words.length; i += size) {
      final end = (i + size < words.length) ? i + size : words.length;
      chunks.add(words.sublist(i, end));
    }

    return chunks;
  }

  Future<void> applyLevelResult(int levelIndex, int? result) async {
    if (result != null && result > results.value[levelIndex]) {
      final resultsCopy = List<int>.from(results.value);
      resultsCopy[levelIndex] = result;
      results.value = resultsCopy;

      final List<String> resultsToSave = results.value.map((e) => e.toString()).toList();

      await _repository.saveResults(resultsToSave);
    }
  }
}