import 'package:flutter/material.dart';
import 'package:nagolosi_app/features/lives_widget.dart';

class LevelButton extends StatelessWidget {
  const LevelButton({
    super.key,
    required this.levelNumber,
    required this.result,
    required this.startLives,
    required this.enabled,
    required this.onPressed,
  });

  final int levelNumber;
  final int result;
  final int startLives;
  final bool enabled;
  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        minimumSize: Size.fromHeight(70),
      ),
      onPressed: enabled ? onPressed : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Рівень $levelNumber",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (enabled)
            LivesWidget(
              startLives: startLives,
              lives: result,
            ),
        ],
      ),
    );
  }
}
