import 'package:flutter/material.dart';

import 'settings_service.dart';

class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  final SettingsService _settingsService;
  late ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;

  Future<void> loadSettings() async {
    _themeMode = _settingsService.themeMode();
    notifyListeners();
  }

  Future<void> updateTheme(ThemeMode? mode) async {
    if(mode == null) return;
    if(mode == _themeMode) return;
    _themeMode = mode;
    notifyListeners();
    await _settingsService.updateTheme(mode);
  }
}