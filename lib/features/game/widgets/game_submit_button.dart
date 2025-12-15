import 'package:flutter/material.dart';
import 'package:nagolosi_app/features/game/game_view_model.dart';

class GameSubmitButton extends StatelessWidget {
  const GameSubmitButton({super.key, required this.viewModel});

  final GameViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: viewModel.canSubmit,
      builder: (context, canSubmit, child) {
        return FilledButton(
          style: FilledButton.styleFrom(
            shape: CircleBorder(),
            fixedSize: Size.square(120),
            //backgroundColor: Color(0xFFFFCA3A),
            //foregroundColor: Colors.black, // Color(0xFF3C541F)
          ),
          onPressed: canSubmit
              ? () async {
                  final result = await viewModel.submitWord();

                  switch (result) {
                    case CheckResult.correctWin:
                      if (context.mounted) Navigator.pop(context, viewModel.livesLeft.value);
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
          child: const Icon(Icons.arrow_forward_rounded, size: 60),
        );
      }
    );
  }
}
