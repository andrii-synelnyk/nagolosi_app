import 'package:flutter/material.dart';
import 'package:nagolosi_app/features/game/game_view_model.dart';

class GameProgressWidget extends StatelessWidget {
  const GameProgressWidget({required this.viewModel, super.key});

  final GameViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: viewModel.gameProgress,
      builder: (context, progress, child) {
        return TweenAnimationBuilder(
          tween: Tween<double>(end: progress),
          duration: const Duration(milliseconds: 300),
          builder: (context, value, child) {
            return LinearProgressIndicator(
              value: value,
              borderRadius: BorderRadius.circular(12),
              minHeight: 12,
            );
          }
        );
      },
    );
  }
}
