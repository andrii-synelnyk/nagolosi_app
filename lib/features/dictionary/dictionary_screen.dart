import 'package:flutter/material.dart';
import 'package:nagolosi_app/app/game_data_controller.dart';

class DictionaryScreen extends StatelessWidget {
  const DictionaryScreen({super.key, required this.controller});

  final GameDataController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder(
        valueListenable: controller.isReady,
        builder: (context, isReady, child) {
          if (!isReady) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: EdgeInsets.all(20),
            children: [
              for (int i = 0; i < controller.words.length; i++) ...[
                Text(
                  "Рівень ${i + 1}",
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 16),
                Container(
                  padding: .all(16),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final s in controller.words[i])
                        buildWordLine(context, s),
                    ],
                  ),
                ),
                SizedBox(height: 16),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget buildWordLine(BuildContext context, String raw) {
    final parts = raw.replaceFirst(" ", "|").split("|");
    final word = parts[0];
    final desc = parts.length > 1 ? parts[1] : null;

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: word,
            style: TextStyle(
              fontSize: 17,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (desc != null)
            TextSpan(
              text: " $desc",
              style: TextStyle(
                fontSize: 17,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}
