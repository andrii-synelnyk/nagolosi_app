import 'package:flutter/material.dart';
import 'package:nagolosi_app/game_view_model.dart';

class GameStats extends StatelessWidget {
  const GameStats({super.key, required this.viewModel});

  final GameViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        return Column(
          spacing: 12,
          children: [
            LinearProgressIndicator(
              value: viewModel.gameProgress,
              borderRadius: BorderRadius.circular(12),
              color: Colors.green,
              backgroundColor: Colors.white24,
              minHeight: 12,
            ),
            Row(
              spacing: 12,
              children: [
                for (var i = 0; i < startLives; i++)
                  Expanded(
                    child: LinearProgressIndicator(
                      value: viewModel.livesLeft <= i ? 0 : 1,
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.red,
                      backgroundColor: Colors.white24,
                      minHeight: 12,
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
