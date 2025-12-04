import 'package:flutter/material.dart';
import 'package:nagolosi_app/game_view_model.dart';

class GameWord extends StatelessWidget {
  const GameWord({super.key, required this.viewModel});

  final GameViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        var chars = viewModel.currentViewWord.characters.toList();

        Color wordColor = switch (viewModel.currentWordStatus) {
          Status.unchecked => Theme.of(context).colorScheme.onSurface,
          Status.incorrect => Colors.red,
          Status.correct => Colors.green,
        };

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < chars.length; i++)
                    GestureDetector(
                      onTap: () {
                        if (vowels.contains(chars[i])) viewModel.toggleLetterCase(i);
                      },
                      child: Text(
                        chars[i],
                        style: TextStyle(
                          fontSize: 50,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w300,
                          color: wordColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                viewModel.currentWordDetails,
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
          ],
        );
      },
    );
  }
}
