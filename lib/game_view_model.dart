import 'package:flutter/material.dart';

const vowels = "аоуеиіяюєїАОУЕИІЯЮЄЇ";
const startLives = 3;

enum Status { correct, incorrect, unchecked }

enum CheckResult {
  correctContinue,
  correctWin,
  incorrectContinue,
  incorrectLose,
}

class GameViewModel {
  GameViewModel(List<String> words)
    : _wordsLeft = List.of(words),
      _gameLength = words.length,
      gameProgress = ValueNotifier<double>(0),
      livesLeft = ValueNotifier<int>(startLives),
      currentViewWord = ValueNotifier<String>(''),
      currentWordDetails = ValueNotifier<String>(''),
      currentWordStatus = ValueNotifier<Status>(Status.unchecked),
      canSubmit = ValueNotifier<bool>(false) {
    _wordsLeft.shuffle();
    _prepareNextWord();
  }

  final List<String> _wordsLeft;
  final int _gameLength;
  final ValueNotifier<double> gameProgress;
  final ValueNotifier<int> livesLeft;
  final ValueNotifier<String> currentViewWord;
  final ValueNotifier<String> currentWordDetails;
  final ValueNotifier<Status> currentWordStatus;
  final ValueNotifier<bool> canSubmit;

  String _currentString = '';
  String _currentCorrectWord = '';
  Set<String> _incorrectAttempts = {};
  bool _canToggleChars = true;

  bool get canToggleChars => _canToggleChars;

  bool _isAllLowercase(String word) => word == word.toLowerCase();

  bool _wasTried(String word) => _incorrectAttempts.contains(word);

  void toggleLetterCase(int letterIndex) {
    final chars = currentViewWord.value.characters.toList();
    final char = chars[letterIndex];
    chars[letterIndex] = (char.toLowerCase() == char)
        ? char.toUpperCase()
        : char.toLowerCase();
    currentViewWord.value = chars.join();

    _updateCanCheckAndStatus();
  }

  void _prepareNextWord() {
    _currentString = _wordsLeft[0];
    var splitString = _currentString.replaceFirst(" ", "|").split("|");
    _currentCorrectWord = splitString[0];
    currentWordDetails.value = (splitString.length > 1)
        ? splitString.getRange(1, splitString.length).join()
        : "";
    currentViewWord.value = _currentCorrectWord.toLowerCase();
    _incorrectAttempts.clear();
    _updateCanCheckAndStatus();
  }

  void _markIncorrectAttempt() {
    _incorrectAttempts.add(currentViewWord.value);
    _updateCanCheckAndStatus();
  }

  void _updateCanCheckAndStatus() {
    if (_isAllLowercase(currentViewWord.value)) {
      canSubmit.value = false;
      currentWordStatus.value = Status.unchecked;
    } else if (_wasTried(currentViewWord.value)) {
      canSubmit.value = false;
      currentWordStatus.value = Status.incorrect;
    } else {
      canSubmit.value = true;
      currentWordStatus.value = Status.unchecked;
    }
  }

  Future<void> _pauseAndDisableControls() async {
    _canToggleChars = false;
    await Future.delayed(const Duration(milliseconds: 700));
    _canToggleChars = true;
  }

  Future<CheckResult> submitWord() async {
    if (currentViewWord.value == _currentCorrectWord) {
      _wordsLeft.removeAt(0);
      canSubmit.value = false;
      currentWordStatus.value = Status.correct;

      await _pauseAndDisableControls();

      if (_wordsLeft.isEmpty) {
        gameProgress.value = (_gameLength - _wordsLeft.length) / (_gameLength);
        return CheckResult.correctWin;
      } else {
        gameProgress.value = (_gameLength - _wordsLeft.length) / (_gameLength);
        _prepareNextWord();
        return CheckResult.correctContinue;
      }
    } else {
      livesLeft.value--;
      _markIncorrectAttempt();

      await _pauseAndDisableControls();

      if (livesLeft.value == 0) {
        return CheckResult.incorrectLose;
      } else {
        currentViewWord.value = _currentCorrectWord.toLowerCase();
        _updateCanCheckAndStatus();
        return CheckResult.incorrectContinue;
      }
    }
  }
}
