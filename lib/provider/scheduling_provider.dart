import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import '../utils/preferences_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  final PreferencesHelper preferencesHelper;

  SchedulingProvider({required this.preferencesHelper}) {
    _getDailyReminderPreference();
  }

  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  void _getDailyReminderPreference() async {
    _isScheduled = await preferencesHelper.isDailyReminderActive;
    notifyListeners();
  }

  Future<void> scheduledDailyReminder(bool value) async {
    _isScheduled = value;
    preferencesHelper.setDailyReminder(value);

    if (_isScheduled) {
      debugPrint('Scheduling Daily Reminder');

      final now = DateTime.now();
      var targetTime = DateTime(now.year, now.month, now.day, 11, 00);
      if (now.isAfter(targetTime)) {
        targetTime = targetTime.add(const Duration(days: 1));
      }
      final initialDelay = targetTime.difference(now);

      await Workmanager().registerPeriodicTask(
        '1',
        'dailyReminderTask',
        frequency: const Duration(hours: 24),
        initialDelay: initialDelay,
      );

      // testing
      // await Workmanager().registerOneOffTask(
      //   'testImmediate',
      //   'dailyReminderTask',
      // );
    } else {
      debugPrint('Canceling Daily Reminder');
      await Workmanager().cancelByUniqueName('1');
    }
    notifyListeners();
  }
}
