import 'package:flutter/material.dart';
import 'package:nagolosi_app/app/game_data_controller.dart';

class DictionaryScreen extends StatelessWidget {
  const DictionaryScreen({super.key, required this.viewModel});

  final GameDataController viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder(
        valueListenable: viewModel.isReady,
        builder: (context, isReady, child) {
          if (!isReady) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: EdgeInsets.all(20),
            children: [
              for (int i = 0; i < viewModel.words.length; i++) ...[
                Text(
                  "Рівень ${i + 1}",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int k = 0; k < viewModel.words[i].length; k++)
                        Text(
                          viewModel.words[i][k],
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ],
          );
        }
      ),
    );
  }
}
