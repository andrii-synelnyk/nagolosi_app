import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.icon,
    required this.iconSize,
    required this.label,
    required this.onPressed,
    this.tonal = false,
  });

  final IconData icon;
  final double iconSize;
  final String label;
  final VoidCallback onPressed;
  final bool tonal;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      children: [
        SizedBox(width: 100, height: 100, child: Icon(icon, size: iconSize)),
        Text(
          label,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ],
    );

    final style = FilledButton.styleFrom(
      fixedSize: const Size.fromHeight(100),
      padding: const EdgeInsets.symmetric(horizontal: 0),
    );

    return tonal
        ? FilledButton.tonal(onPressed: onPressed, style: style, child: child)
        : FilledButton(onPressed: onPressed, style: style, child: child);
  }
}
