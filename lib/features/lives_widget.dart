import 'package:flutter/material.dart';

class LivesWidget extends StatelessWidget {
  const LivesWidget({super.key, required this.startLives, required this.lives});

  final int startLives;
  final int lives;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < startLives; i++)
              Icon(
                Icons.favorite_rounded,
                size: 28,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < startLives; i++)
              TweenAnimationBuilder(
                tween: Tween<double>(end: lives <= i ? 0 : 1),
                duration: const Duration(milliseconds: 300),
                builder: (context, value, child) {
                  return Icon(
                    Icons.favorite_rounded,
                    size: 28,
                    color: Color(0xFFFF4B5D).withValues(alpha: value),
                  );
                },
              ),
          ],
        ),
      ],
    );
  }
}
