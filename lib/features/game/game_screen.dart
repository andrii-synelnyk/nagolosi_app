import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nagolosi_app/features/game/game_view_model.dart';
import 'package:nagolosi_app/features/game/widgets/game_progress_widget.dart';
import 'package:nagolosi_app/features/game/widgets/game_rules_dialog.dart';
import 'package:nagolosi_app/features/game/widgets/game_submit_button.dart';
import 'package:nagolosi_app/features/game/widgets/game_word.dart';
import 'package:nagolosi_app/features/lives_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({required this.viewModel, super.key});

  final GameViewModel viewModel;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.viewModel.shouldShowRules) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        unawaited(
          showDialog<void>(
            context: context,
            builder: (context) => const GameRulesDialog(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder<int>(
          valueListenable: widget.viewModel.livesLeft,
          builder: (context, lives, child) {
            return LivesWidget(startLives: startLives, lives: lives);
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 56),
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.help_outline_rounded),
                onPressed: () => showDialog<void>(
                  context: context,
                  builder: (context) => const GameRulesDialog(),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: GameProgressWidget(viewModel: widget.viewModel),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GameWord(viewModel: widget.viewModel),
                ),
              ),
              Expanded(
                child: Center(
                  child: GameSubmitButton(viewModel: widget.viewModel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
