import 'package:flutter/material.dart';
import 'package:nagolosi_app/features/lives_widget.dart';

class LevelButton extends StatelessWidget {
  const LevelButton({
    required this.levelNumber,
    required this.result,
    required this.startLives,
    required this.enabled,
    required this.onPressed,
    super.key,
  });

  static const double _height = 70;
  static const double _radius = 20;

  final int levelNumber;
  final int result;
  final int startLives;
  final bool enabled;
  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      style: FilledButton.styleFrom(
        padding: .zero,
        minimumSize: const .fromHeight(_height),
        shape: RoundedRectangleBorder(borderRadius: .circular(_radius)),
      ),
      onPressed: enabled ? onPressed : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const .symmetric(horizontal: 24),
            child: Text(
              'Рівень $levelNumber',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          if (enabled)
            Ink(
              padding: const .symmetric(horizontal: 24),
              height: _height,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.horizontal(
                  right: .circular(_radius),
                ),
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
              ),
              child: Center(
                child: LivesWidget(startLives: startLives, lives: result),
              ),
            )
          else
            const Padding(
              padding: .symmetric(horizontal: 24),
              child: Row(
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    size: 28,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
