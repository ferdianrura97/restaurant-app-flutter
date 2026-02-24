import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const darkTheme = 'DARK_THEME';
  static const dailyReminder = 'DAILY_REMINDER';

  Future<bool> get isDarkTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(darkTheme) ?? false;
  }

  Future<void> setDarkTheme(bool value) async {
    final prefs = await sharedPreferences;
    await prefs.setBool(darkTheme, value);
  }

  Future<bool> get isDailyReminderActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyReminder) ?? false;
  }

  Future<void> setDailyReminder(bool value) async {
    final prefs = await sharedPreferences;
    await prefs.setBool(dailyReminder, value);
  }
}
