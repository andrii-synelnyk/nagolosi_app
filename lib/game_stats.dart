import 'package:flutter/material.dart';
import 'package:nagolosi_app/game_view_model.dart';

class GameStats extends StatelessWidget {
  const GameStats({super.key, required this.viewModel});

  final GameViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        ValueListenableBuilder<double>(
          valueListenable: viewModel.gameProgress,
          builder: (context, progress, child) {
            return LinearProgressIndicator(
              value: progress,
              borderRadius: BorderRadius.circular(12),
              color: Colors.green,
              backgroundColor: Colors.white24,
              minHeight: 12,
            );
          }
        ),
        ValueListenableBuilder<int>(
          valueListenable: viewModel.livesLeft,
          builder: (context, lives, child) {
            return Row(
              spacing: 12,
              children: [
                for (var i = 0; i < startLives; i++)
                  Expanded(
                    child: LinearProgressIndicator(
                      value: lives <= i ? 0 : 1,
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.red,
                      backgroundColor: Colors.white24,
                      minHeight: 12,
                    ),
                  ),
              ],
            );
          }
        ),
      ],
    );
  }
}
