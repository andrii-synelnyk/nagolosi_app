import 'package:flutter/material.dart';
import 'package:nagolosi_app/features/game/widgets/game_progress_widget.dart';
import 'package:nagolosi_app/features/game/game_view_model.dart';
import 'package:nagolosi_app/features/game/widgets/game_rules_dialog.dart';
import 'package:nagolosi_app/features/game/widgets/game_word.dart';
import 'package:nagolosi_app/features/game/widgets/game_submit_button.dart';
import 'package:nagolosi_app/features/lives_widget.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.viewModel});

  final GameViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder<int>(
          valueListenable: viewModel.livesLeft,
          builder: (context, lives, child) {
            return LivesWidget(startLives: startLives, lives: lives);
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 56),
            child: Center(
              child: IconButton(
                icon: Icon(Icons.help_outline_rounded),
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => GameRulesDialog()
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GameProgressWidget(viewModel: viewModel),
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
