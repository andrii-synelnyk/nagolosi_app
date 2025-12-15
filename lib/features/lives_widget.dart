import 'package:flutter/material.dart';

class LivesWidget extends StatelessWidget {
  const LivesWidget({
    super.key,
    required this.startLives,
    required this.lives,
  });

  final int startLives;
  final int lives;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < startLives; i++)
          // Expanded(
          //   child: LinearProgressIndicator(
          //     value: lives <= i ? 0 : 1,
          //     borderRadius: BorderRadius.circular(8),
          //     color: Color(0xFFFD3B31), // Color(0xFFFD3B31) // Color(0xFFFF7070)
          //     backgroundColor: Color(0xFF2A2A2A),
          //     minHeight: double.infinity,
          //   ),
          // ),
          Icon(Icons.favorite_rounded, size: 28, color: lives <= i ? Theme.of(context).colorScheme.secondaryContainer : Color(0xFFFF4B5D))
      ],
    );
  }
}
