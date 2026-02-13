import 'package:flutter/material.dart';
import 'package:nagolosi_app/features/game/game_view_model.dart';

class GameWord extends StatelessWidget {
  const GameWord({required this.viewModel, super.key});

  final GameViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder<String>(
          valueListenable: viewModel.currentViewWord,
          builder: (context, currentViewWord, child) {
            final chars = currentViewWord.characters.toList();

            return ValueListenableBuilder<Status>(
              valueListenable: viewModel.currentWordStatus,
              builder: (context, status, child) {
                final wordColor = switch (status) {
                  Status.unchecked => Theme.of(context).colorScheme.onSurface,
                  Status.incorrect => const Color(0xFFFF4B5D),
                  Status.correct => Theme.of(context).colorScheme.primary,
                };

                return FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < chars.length; i++)
                        GestureDetector(
                          onTap: viewModel.canToggleChars
                              ? () {
                                  if (vowels.contains(chars[i])) {
                                    viewModel.toggleLetterCase(i);
                                  }
                                }
                              : null,
                          child: Text(
                            chars[i],
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w400,
                              color: wordColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: viewModel.currentWordDetails,
          builder: (context, details, child) {
            return FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                details,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
