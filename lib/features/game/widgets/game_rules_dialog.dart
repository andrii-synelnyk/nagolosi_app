import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GameRulesDialog extends StatelessWidget {
  const GameRulesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: .min,
        children: [
          Padding(
            padding: .symmetric(vertical: 20.0),
            child: Lottie.asset('assets/word_animation.json', repeat: false),
          ),
          Text(
            "• натискайте на голосні літери, щоб обрати правильний наголос",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 12),
          Text(
            "• якщо слово має два можливі наголоси, зазначте обидва",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      actions: <Widget>[
        FilledButton.tonal(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('ГАРАЗД'),
        ),
      ],
      actionsAlignment: .center,
    );
  }
}
