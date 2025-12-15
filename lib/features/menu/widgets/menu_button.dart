import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.icon,
    required this.iconSize,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final double iconSize;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        fixedSize: Size.fromHeight(100),
        padding: EdgeInsets.symmetric(horizontal: 0),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Icon(icon, size: iconSize),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
