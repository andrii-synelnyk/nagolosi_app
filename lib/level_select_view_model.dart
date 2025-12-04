import 'package:flutter/foundation.dart';
import 'package:nagolosi_app/level_repository.dart';

class LevelSelectViewModel extends ChangeNotifier{
  LevelSelectViewModel(this._levelRepository) {
    _init();
  }

  static const int _wordsPerLevel = 15;

  final LevelRepository _levelRepository;

  bool _isReady = false;
  bool get isReady => _isReady;

  late List<String> _assetWords;
  late final List<List<String>> _chunkedWords;
  late List<String> _savedWords;
  late int _savedWordsPerLevel;
  late List<String> _savedResults;
  late List<int> _parsedResults;

  List<List<String>> get words => _chunkedWords;
  List<int> get results => _parsedResults;

  Future<void> _init() async {
    await _loadAsset();
    await _loadPreferences();
    _isReady = true;
    notifyListeners();
  }

  Future<void> _loadAsset() async {
    _assetWords = await _levelRepository.loadAssetWords();
    _chunkedWords = _chunkWords(_assetWords, _wordsPerLevel);
  }

  Future<void> _loadPreferences() async {
    _savedWords = await _levelRepository.loadSavedWords();
    _savedWordsPerLevel = await _levelRepository.loadWordsPerLevel();
    _savedResults = await _levelRepository.loadLevelResults();
    _parsedResults = _savedResults.map(int.parse).toList();

    if (_savedWords.isEmpty ||
        !listEquals(_savedWords, _assetWords) ||
        _savedWordsPerLevel != _wordsPerLevel) {
      await _saveCleanData();
    }
  }

  Future<void> _saveCleanData() async {
    final numberOfLevels = _chunkedWords.length;

    _savedResults = List.filled(numberOfLevels, "0");
    _parsedResults = List.filled(numberOfLevels, 0);

    notifyListeners();

    await _levelRepository.saveWords(_assetWords);
    await _levelRepository.saveWordsPerLevel(_wordsPerLevel);
    await _levelRepository.saveResults(_savedResults);
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
    if (result != null && result > _parsedResults[levelIndex]) {
      _parsedResults[levelIndex] = result;
      _savedResults[levelIndex] = result.toString();
      notifyListeners();

      await _levelRepository.saveResults(_savedResults);
    }
  }
}