import 'package:flutter/material.dart';
import 'package:nagolosi_app/asset_service.dart';
import 'package:nagolosi_app/game_screen.dart';
import 'package:nagolosi_app/game_view_model.dart';
import 'package:nagolosi_app/level_repository.dart';
import 'package:nagolosi_app/level_select_screen.dart';
import 'package:nagolosi_app/level_select_view_model.dart';
import 'package:nagolosi_app/shared_preferences_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // final viewModel = GameViewModel();
  final assetService = AssetService();
  final preferenceService = SharedPreferencesService();
  final levelRepository = LevelRepository(assetService, preferenceService);
  final levelViewModel = LevelSelectViewModel(levelRepository);

  runApp(MyApp(levelViewModel: levelViewModel));
}

class MyApp extends StatelessWidget {
  // final GameViewModel viewModel;
  final LevelSelectViewModel levelViewModel;

  const MyApp({required this.levelViewModel, super.key});

  ThemeData _buildTheme(Brightness brightness) {
    final base = ThemeData(brightness: brightness, fontFamily: 'Nunito');
    final backgroundColor = brightness == Brightness.light
        ? Colors.white
        : Colors.black;

    return base.copyWith(
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(backgroundColor: backgroundColor, scrolledUnderElevation: 0,),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      // home: GameScreen(viewModel: viewModel),
      home: LevelSelectScreen(viewModel: levelViewModel),
    );
  }
}
