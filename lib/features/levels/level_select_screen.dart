import 'package:flutter/material.dart';
import 'package:nagolosi_app/app/game_data_controller.dart';
import 'package:nagolosi_app/features/game/game_screen.dart';
import 'package:nagolosi_app/features/game/game_view_model.dart';
import 'package:nagolosi_app/features/levels/widgets/level_button.dart';

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({required this.controller, super.key});

  final GameDataController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: ValueListenableBuilder(
            valueListenable: controller.isReady,
            builder: (context, isReady, child) {
              if (!isReady) {
                return const Center(child: CircularProgressIndicator());
              }

              return ValueListenableBuilder(
                valueListenable: controller.results,
                builder: (context, results, child) {
                  return ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: controller.words.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, i) {
                      // final enabled = true;
                      final enabled = i == 0 || results[i - 1] > 0;

                      return LevelButton(
                        levelNumber: i + 1,
                        result: results[i],
                        startLives: startLives,
                        enabled: enabled,
                        onPressed: () async {
                          final gameViewModel = GameViewModel(
                            controller.words[i], controller.shouldShowRules
                          );
                          final result = await Navigator.push<int>(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  GameScreen(viewModel: gameViewModel),
                            ),
                          );
                          await controller.applyLevelResult(i, result);
                          await controller.updateRulesSeen();
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
