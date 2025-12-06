import 'package:flutter/material.dart';
import 'package:nagolosi_app/game_stats.dart';
import 'package:nagolosi_app/game_view_model.dart';
import 'package:nagolosi_app/game_word.dart';
import 'package:nagolosi_app/game_submit_button.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.viewModel});

  final GameViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GameStats(viewModel: viewModel),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GameWord(viewModel: viewModel),
                ),
              ),
              Expanded(
                child: Center(child: GameSubmitButton(viewModel: viewModel)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
