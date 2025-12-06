import 'package:flutter/material.dart';
import 'package:nagolosi_app/game_view_model.dart';
import 'package:nagolosi_app/lives_widget.dart';

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
              color: Color(0xFF43B929),
              backgroundColor: Color(0xFF2A2A2A),
              minHeight: 12,
            );
          },
        ),
        ValueListenableBuilder<int>(
          valueListenable: viewModel.livesLeft,
          builder: (context, lives, child) {
            return SizedBox(
              height: 12,
              child: LivesWidget(
                startLives: startLives,
                lives: lives,
                spacing: 12,
              ),
            );
          },
        ),
      ],
    );
  }
}
