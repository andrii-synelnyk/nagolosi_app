import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nagolosi_app/app/game_data_controller.dart';
import 'package:nagolosi_app/core/repositories/game_data_repository.dart';
import 'package:nagolosi_app/core/services/asset_service.dart';
import 'package:nagolosi_app/core/services/shared_preferences_service.dart';
import 'package:nagolosi_app/features/menu/menu_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:nagolosi_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final assetService = AssetService();
  final preferenceService = SharedPreferencesService();
  final gameDataRepository = GameDataRepository(
    assetService,
    preferenceService,
  );
  final gameDataController = GameDataController(gameDataRepository);

  runApp(MyApp(gameDataController: gameDataController));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.gameDataController, super.key});

  final GameDataController gameDataController;

  ThemeData _baseTheme(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF1E202D),
      brightness: brightness,
    );

    return ThemeData(
      colorScheme: scheme,
      fontFamily: 'Nunito',
      filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      // theme: _baseTheme(Brightness.light),
      darkTheme: _baseTheme(Brightness.dark),
      home: MenuScreen(gameDataController: gameDataController),
    );
  }
}
