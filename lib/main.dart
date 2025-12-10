import 'package:flutter/material.dart';
import 'package:nagolosi_app/asset_service.dart';
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

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.black;

    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: backgroundColor,
          scrolledUnderElevation: 0,
        ),
        fontFamily: 'Nunito',
      ),
      // home: GameScreen(viewModel: viewModel),
      home: LevelSelectScreen(viewModel: levelViewModel),
    );
  }
}
