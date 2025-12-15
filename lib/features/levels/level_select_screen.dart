import 'package:flutter/material.dart';
import 'package:nagolosi_app/features/game/game_screen.dart';
import 'package:nagolosi_app/features/game/game_view_model.dart';
import 'package:nagolosi_app/features/levels/widgets/level_button.dart';
import 'package:nagolosi_app/app/game_data_controller.dart';

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key, required this.viewModel});

  final GameDataController viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder(
        valueListenable: viewModel.isReady,
        builder: (context, isReady, child) {
          if (!isReady) {
            return const Center(child: CircularProgressIndicator());
          }

          return ValueListenableBuilder(
            valueListenable: viewModel.results,
            builder: (context, results, child) {
              return ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: viewModel.words.length,
                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 12),
                itemBuilder: (BuildContext context, int i) {
                  // final enabled = true;
                  final enabled = (i == 0 || i > 0 && results[i - 1] > 0) ? true : false;

                  return LevelButton(
                    levelNumber: i + 1,
                    result: results[i],
                    startLives: startLives,
                    enabled: enabled,
                    onPressed: () async {
                      final gameViewModel = GameViewModel(viewModel.words[i]);
                      final result = await Navigator.push<int>(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              GameScreen(viewModel: gameViewModel),
                        ),
                      );
                      await viewModel.applyLevelResult(i, result);
                    },
                  );
                }
              );
            },
          );
        },
      ),
    );
  }
}
