import 'package:flutter/material.dart';
import 'package:nagolosi_app/game_view_model.dart';

class GameBottomButtons extends StatelessWidget {
  const GameBottomButtons({super.key, required this.viewModel});

  final GameViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        return FilledButton(
          style: FilledButton.styleFrom(
            shape: CircleBorder(),
            fixedSize: Size.square(100),
            backgroundColor: Color.fromARGB(255, 255, 211, 88),
            foregroundColor: Colors.black, // Color(0xFF3C541F)
          ),
          onPressed: viewModel.canCheck
              ? () async {
                  final result = await viewModel.checkWord();

                  switch (result) {
                    case CheckResult.correctWin:
                      if (context.mounted) Navigator.pop(context, viewModel.livesLeft);
                      break;
                    case CheckResult.incorrectLose:
                      if (context.mounted) Navigator.pop(context, 0);
                      break;
                    case CheckResult.correctContinue:
                    case CheckResult.incorrectContinue:
                      break;
                  }
                }
              : null,
          child: const Icon(Icons.arrow_forward_rounded, size: 50),
        );
      },
    );
  }
}
