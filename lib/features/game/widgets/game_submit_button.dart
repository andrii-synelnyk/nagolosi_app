import 'package:flutter/material.dart';
import 'package:nagolosi_app/features/game/game_view_model.dart';

class GameSubmitButton extends StatelessWidget {
  const GameSubmitButton({required this.viewModel, super.key});

  final GameViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: viewModel.canSubmit,
      builder: (context, canSubmit, child) {
        return FilledButton(
          style: FilledButton.styleFrom(
            shape: const CircleBorder(),
            fixedSize: const .square(120),
            //backgroundColor: Color(0xFFFFCA3A),
            //foregroundColor: Colors.black, // Color(0xFF3C541F)
          ),
          onPressed: canSubmit
              ? () async {
                  final result = await viewModel.submitWord();

                  switch (result) {
                    case CheckResult.correctWin:
                      if (context.mounted) {
                        Navigator.pop(context, viewModel.livesLeft.value);
                      }
                    case CheckResult.incorrectLose:
                      if (context.mounted) Navigator.pop(context, 0);
                    case CheckResult.correctContinue:
                    case CheckResult.incorrectContinue:
                      break;
                  }
                }
              : null,
          child: const Icon(Icons.arrow_forward_rounded, size: 60),
        );
      },
    );
  }
}
