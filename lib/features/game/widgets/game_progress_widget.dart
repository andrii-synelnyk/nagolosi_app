import 'package:flutter/material.dart';
import 'package:nagolosi_app/features/game/game_view_model.dart';

class GameProgressWidget extends StatelessWidget {
  const GameProgressWidget({super.key, required this.viewModel});

  final GameViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: viewModel.gameProgress,
      builder: (context, progress, child) {
        return LinearProgressIndicator(
          value: progress,
          borderRadius: BorderRadius.circular(12),
          //color: Color(0xFF43B929),
          //backgroundColor: Color(0xFF2A2A2A),
          minHeight: 12,
        );
      },
    );
  }
}
