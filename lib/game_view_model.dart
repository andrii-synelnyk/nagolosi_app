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

class GameViewModel extends ChangeNotifier {
  GameViewModel(List<String> words)
    : _wordsLeft = List.of(words),
      _gameLength = words.length,
      _livesLeft = startLives {
    _wordsLeft.shuffle();
    _prepareNextWord();
  }

  final List<String> _wordsLeft;
  late String _currentString;
  late String _currentCorrectWord;
  String _currentWordDetails = "";
  late Status _currentWordStatus;
  late String _currentViewWord;
  bool _canCheck = false;
  final int _gameLength;
  double _gameProgress = 0;
  int _livesLeft;
  Set<String> _incorrectAttempts = {};

  String get currentViewWord => _currentViewWord;

  String get currentWordDetails => _currentWordDetails;

  Status get currentWordStatus => _currentWordStatus;

  bool get canCheck => _canCheck;

  int get livesLeft => _livesLeft;

  double get gameProgress => _gameProgress;

  bool _isAllLowercase(String word) => word == word.toLowerCase();

  bool _wasTried(String word) => _incorrectAttempts.contains(word);

  void toggleLetterCase(int letterIndex) {
    final chars = _currentViewWord.characters.toList();
    final char = chars[letterIndex];
    chars[letterIndex] = (char.toLowerCase() == char)
        ? char.toUpperCase()
        : char.toLowerCase();
    _currentViewWord = chars.join();

    _updateCanCheckAndStatus();
    notifyListeners();
  }

  void _prepareNextWord() {
    _currentString = _wordsLeft[0];
    var splitString = _currentString.replaceFirst(" ", "|").split("|");
    _currentCorrectWord = splitString[0];
    _currentWordDetails = (splitString.length > 1)
        ? splitString.getRange(1, splitString.length).join()
        : "";
    _currentViewWord = _currentCorrectWord.toLowerCase();
    _incorrectAttempts.clear();
    _updateCanCheckAndStatus();
  }

  void _markIncorrectAttempt() {
    _incorrectAttempts.add(_currentViewWord);
    _updateCanCheckAndStatus();
  }

  void _updateCanCheckAndStatus() {
    if (_isAllLowercase(_currentViewWord)) {
      _canCheck = false;
      _currentWordStatus = Status.unchecked;
    } else if (_wasTried(_currentViewWord)) {
      _canCheck = false;
      _currentWordStatus = Status.incorrect;
    } else {
      _canCheck = true;
      _currentWordStatus = Status.unchecked;
    }
  }

  Future<CheckResult> checkWord() async {
    if (_currentViewWord == _currentCorrectWord) {
      _wordsLeft.removeAt(0);
      _canCheck = false;
      _currentWordStatus = Status.correct;
      notifyListeners(); // show green

      await Future.delayed(const Duration(milliseconds: 700));

      if (_wordsLeft.isEmpty) {
        _gameProgress = (_gameLength - _wordsLeft.length) / (_gameLength);
        notifyListeners();
        return CheckResult.correctWin;
      } else {
        _gameProgress = (_gameLength - _wordsLeft.length) / (_gameLength);
        _prepareNextWord();
        notifyListeners(); // show next word
        // move progress bar
        return CheckResult.correctContinue;
      }
    } else {
      _livesLeft--;
      _markIncorrectAttempt();
      notifyListeners(); // show red

      await Future.delayed(const Duration(milliseconds: 700));

      if (_livesLeft == 0) {
        return CheckResult.incorrectLose;
      } else {
        _currentViewWord = _currentCorrectWord.toLowerCase();
        _updateCanCheckAndStatus();
        notifyListeners(); // back to base state
        return CheckResult.incorrectContinue;
      }
    }
  }
}
