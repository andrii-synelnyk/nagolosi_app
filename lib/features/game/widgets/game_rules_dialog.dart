import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GameRulesDialog extends StatelessWidget {
  const GameRulesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      title: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(28), // matches AlertDialog radius
          ),
        ),
        child: Text(
          'Як грати',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      content: Column(
        mainAxisSize: .min,
        children: [
          Padding(
            padding: const .symmetric(vertical: 16),
            child: Lottie.asset('assets/word_animation.json', repeat: false),
          ),
          const Text(
            '• натискайте на голосні літери, щоб обрати правильний наголос',
          ),
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '• якщо слово має два можливі наголоси, зазначте ',
                ),
                TextSpan(
                  text: 'обидва',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FilledButton.tonal(
          onPressed: () => Navigator.pop(context),
          child: const Text('Гаразд'),
        ),
      ],
      actionsAlignment: .center,
    );
  }
}
