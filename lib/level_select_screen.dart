import 'package:flutter/material.dart';
import 'package:nagolosi_app/game_screen.dart';
import 'package:nagolosi_app/game_view_model.dart';
import 'package:nagolosi_app/level_select_view_model.dart';

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key, required this.viewModel});

  final LevelSelectViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          if (!viewModel.isReady) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              for (var i = 0; i < viewModel.words.length; i++)
                FilledButton(
                  onPressed: () async {
                    final gameViewModel = GameViewModel(viewModel.words[i]);
                    final result = await Navigator.push<int>(
                      context,
                      MaterialPageRoute(builder: (_) => GameScreen(viewModel: gameViewModel)),
                    );
                    await viewModel.applyLevelResult(i, result);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("${i + 1}"), Text("${viewModel.results[i]}")],
                  ),
                ),
            ],
          );
        }
      ),
    );
  }
}
