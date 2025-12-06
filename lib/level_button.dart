import 'package:flutter/material.dart';
import 'package:nagolosi_app/lives_widget.dart';

class LevelButton extends StatelessWidget {
  const LevelButton({
    super.key,
    required this.levelNumber,
    required this.result,
    required this.startLives,
    required this.onPressed,
  });

  final int levelNumber;
  final int result;
  final int startLives;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        minimumSize: Size.fromHeight(70),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Color(0xFFF0EFF4), // Color(0xFFB88DFF)
        foregroundColor: Colors.black,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Рівень $levelNumber",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10,
            width: 100,
            child: LivesWidget(
              startLives: startLives,
              lives: result,
              spacing: 4,
            ),
          ),
        ],
      ),
    );
  }
}
