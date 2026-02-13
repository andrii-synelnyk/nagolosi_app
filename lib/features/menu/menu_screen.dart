import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nagolosi_app/app/game_data_controller.dart';
import 'package:nagolosi_app/features/dictionary/dictionary_screen.dart';
import 'package:nagolosi_app/features/levels/level_select_screen.dart';
import 'package:nagolosi_app/features/menu/widgets/menu_button.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({required this.gameDataController, super.key});

  final GameDataController gameDataController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  MenuButton(
                    icon: Icons.play_arrow_rounded,
                    iconSize: 70,
                    label: 'Грати',
                    onPressed: () {
                      unawaited(Navigator.push<int>(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              LevelSelectScreen(controller: gameDataController),
                        ),
                      ));
                    },
                  ),
                  MenuButton(
                    icon: Icons.menu_book_rounded,
                    iconSize: 50,
                    label: 'Словник',
                    onPressed: () {
                      unawaited(Navigator.push<int>(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DictionaryScreen(controller: gameDataController),
                        ),
                      ));
                    },
                    tonal: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
