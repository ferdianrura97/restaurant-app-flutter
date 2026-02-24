import 'package:flutter/material.dart';
import '../utils/preferences_helper.dart';

class ThemeProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  ThemeProvider({required this.preferencesHelper}) {
    _getTheme();
  }

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void _getTheme() async {
    _isDarkMode = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await preferencesHelper.setDarkTheme(_isDarkMode);
    notifyListeners();
  }
}