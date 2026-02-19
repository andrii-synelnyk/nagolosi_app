import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:nagolosi_app/core/repositories/game_data_repository.dart';

import 'package:in_app_review/in_app_review.dart';

const wordsPerLevel = 15;

class GameDataController {
  GameDataController(this._repository)
    : isReady = ValueNotifier<bool>(false),
      results = ValueNotifier<List<int>>([]) {
    unawaited(_init());
  }

  final GameDataRepository _repository;

  final ValueNotifier<bool> isReady;
  final ValueNotifier<List<int>> results;

  late final List<String> _assetWords;
  late final List<List<String>> _chunkedWords;
  late bool _shouldShowRules;
  late bool _reviewRequested;

  List<List<String>> get words => _chunkedWords;
  bool get shouldShowRules => _shouldShowRules;

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
    final savedWords = await _repository.loadSavedWords();
    final savedWordsPerLevel = await _repository.loadWordsPerLevel();
    final savedResults = await _repository.loadLevelResults();
    final savedRulesSeen = await _repository.loadRulesSeen();
    final savedReviewRequested = await _repository.loadReviewRequested();

    results.value = savedResults.map(int.parse).toList();
    _shouldShowRules = !savedRulesSeen;
    _reviewRequested = savedReviewRequested;

    // Current results data is not up to date (e.g., list of words in assets was
    // modified via app update)
    if (savedWords.isEmpty ||
        !listEquals(savedWords, _assetWords) ||
        savedWordsPerLevel != wordsPerLevel) {
      await _saveCleanData();
    }
  }

  Future<void> _saveCleanData() async {
    final numberOfLevels = _chunkedWords.length;

    final resultsToSave = List<String>.filled(numberOfLevels, '0');
    results.value = List.filled(numberOfLevels, 0);

    await _repository.saveWords(_assetWords);
    await _repository.saveWordsPerLevel(wordsPerLevel);
    await _repository.saveResults(resultsToSave);
  }

  List<List<String>> _chunkWords(List<String> words, int size) {
    final chunks = <List<String>>[];

    for (var i = 0; i < words.length; i += size) {
      final end = (i + size < words.length) ? i + size : words.length;
      chunks.add(words.sublist(i, end));
    }

    return chunks;
  }

  Future<void> applyLevelResult({
    required int levelIndex,
    required int? result,
  }) async {
    if (result == null || result <= results.value[levelIndex]) return;

    final resultsCopy = List<int>.from(results.value);
    resultsCopy[levelIndex] = result;
    results.value = resultsCopy;

    final resultsToSave = results.value.map((e) => e.toString()).toList();

    await _repository.saveResults(resultsToSave);
  }

  Future<void> maybeUpdateRulesSeen() async {
    if (!_shouldShowRules) return;

    _shouldShowRules = false;
    await _repository.saveRulesSeen();
  }

  Future<void> maybeRequestReview({
    required int levelIndex,
    required int? result,
  }) async {
    if (result == null || result == 0) return;

    if (_reviewRequested) return;

    final totalLevels = _chunkedWords.length;
    final targetLevelIndex = (totalLevels * 0.33).floor();

    if (levelIndex < targetLevelIndex) return;

    final inAppReview = InAppReview.instance;

    final available = await inAppReview.isAvailable();
    if (!available) return;

    _reviewRequested = true;
    await _repository.saveReviewRequested();

    unawaited(inAppReview.requestReview());
  }
}
