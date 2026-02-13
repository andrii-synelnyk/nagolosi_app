import 'package:flutter/services.dart' show rootBundle;

class AssetService {
  Future<List<String>> loadWords() async {
    final raw = await rootBundle.loadString('assets/words.txt');
    final words = raw.split('\n');
    return words;
  }
}
