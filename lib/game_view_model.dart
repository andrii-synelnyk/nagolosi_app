import 'package:flutter/material.dart';

const vowels = "аоуеиіяюєїАОУЕИІЯЮЄЇ";

enum Status { correct, incorrect, unchecked }

enum CheckResult {
  correctContinue,
  correctWin,
  incorrectContinue,
  incorrectLose,
}

class GameViewModel extends ChangeNotifier {
  GameViewModel(List<String> words) : _words = List.of(words) {
    _words.shuffle();
    _prepareNextWord();
  }

  final List<String> _words;
  late String _currentString;
  late String _currentCorrectWord;
  String _currentWordDetails = "";
  late String _currentViewWord;
  bool _canCheck = false;
  int _lives = 3;
  Set<String> _incorrectAttempts = {};
  late Status _currentWordStatus;

  String get currentViewWord => _currentViewWord;

  String get currentWordDetails => _currentWordDetails;

  bool get canCheck => _canCheck;

  Status get currentWordStatus => _currentWordStatus;

  int get lives => _lives;

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
    _currentString = _words[0];
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
      _words.removeAt(0);
      _canCheck = false;
      _currentWordStatus = Status.correct;
      notifyListeners(); // show green

      await Future.delayed(const Duration(milliseconds: 700));

      if (_words.isEmpty) {
        return CheckResult.correctWin;
      } else {
        _prepareNextWord();
        notifyListeners(); // show next word
        // move progress bar
        return CheckResult.correctContinue;
      }
    } else {
      _lives--;
      _markIncorrectAttempt();
      notifyListeners(); // show red

      await Future.delayed(const Duration(milliseconds: 700));

      if (_lives == 0) {
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
