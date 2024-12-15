import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  SettingsService({required this.sharedPreferences});
  late ThemeMode _themeMode;
  final SharedPreferences sharedPreferences;

  ThemeMode themeMode() {
    final mode = sharedPreferences.getString('ThemeMode');
    switch (mode) {
      case 'light':
        _themeMode = ThemeMode.light;
        break;
      case 'dark':
        _themeMode = ThemeMode.dark;
        break;
      default:
       _themeMode = ThemeMode.system;
        break; 
    }
    return _themeMode;
  }

  Future<void> updateTheme(ThemeMode mode) async {
    await sharedPreferences.setString('ThemeMode', mode.name);
  }
}