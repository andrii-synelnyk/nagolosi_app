import 'package:flutter/material.dart';
import 'package:nagolosi_app/game_view_model.dart';

class GameWord extends StatelessWidget {
  const GameWord({super.key, required this.viewModel});

  final GameViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder<String>(
          valueListenable: viewModel.currentViewWord,
          builder: (context, currentViewWord, child) {
            var chars = currentViewWord.characters.toList();

            return ValueListenableBuilder<Status>(
              valueListenable: viewModel.currentWordStatus,
              builder: (context, status, child) {
                Color wordColor = switch (status) {
                  Status.unchecked => Theme.of(context).colorScheme.onSurface,
                  Status.incorrect => Color(0xFFFD3B31),
                  Status.correct => Color(0xFF43B929),
                };

                return FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < chars.length; i++)
                        GestureDetector(
                          onTap: viewModel.canToggleChars ? () {
                            if (vowels.contains(chars[i])) viewModel.toggleLetterCase(i);
                          } : null,
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
                );
              }
            );
          }
        ),
        ValueListenableBuilder(
          valueListenable: viewModel.currentWordDetails,
          builder: (context, details, child) {
            return FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                details,
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            );
          }
        ),
      ],
    );
  }
}
