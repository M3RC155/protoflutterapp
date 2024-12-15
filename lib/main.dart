import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proto_app/screens/calculator_screen.dart';
import 'package:proto_app/screens/settings/settings_view.dart';
import 'package:proto_app/screens/todo_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/calculator_models.dart';
import 'screens/main_menu.dart';
import 'screens/settings/settings_controller.dart';
import 'screens/settings/settings_service.dart';
import 'utils/calculator_engine.dart';

void main() async {
  final sharedPref = await SharedPreferences.getInstance();
  final settingsController = SettingsController(SettingsService(sharedPreferences: sharedPref));
  await settingsController.loadSettings();
  runApp(App(settingsController: settingsController));
}

final calculatorStateProvider =
    StateNotifierProvider<CalculatorEngine, CalculatorState>(
        (_) => CalculatorEngine());

class App extends StatelessWidget {
  const App({
    super.key,
    required this.settingsController
  });
  
  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Proto app',
          theme: ThemeData(
            colorSchemeSeed: Colors.deepPurple,
          ),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          home: const MainMenu(),
          routes: {
            '/todolist': (ctx) => const TodoListScreen(),
            '/calculator': (ctx) => ProviderScope(
              child: CalculatorScreen(calculatorStateProvider: calculatorStateProvider)
            ),
            '/settings': (ctx) => SettingsView(controller: settingsController),
          },
        );
      }
    );
  }
}