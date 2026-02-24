import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import '../utils/preferences_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  final PreferencesHelper preferencesHelper;

  static const String _taskUniqueName = 'daily_restaurant_notification';
  static const String _taskName = 'dailyRestaurantNotification';

  SchedulingProvider({required this.preferencesHelper}) {
    _getDailyReminderPreference();
  }

  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  void _getDailyReminderPreference() async {
    _isScheduled = await preferencesHelper.isDailyReminderActive;

    if (_isScheduled) {
      await _registerWorkmanagerTask();
    }
    notifyListeners();
  }

  Future<void> scheduledDailyReminder(bool value) async {
    _isScheduled = value;
    await preferencesHelper.setDailyReminder(value);

    if (_isScheduled) {
      debugPrint('Scheduling Daily Reminder via Workmanager');
      await _registerWorkmanagerTask();
    } else {
      debugPrint('Canceling Daily Reminder');
      await Workmanager().cancelByUniqueName(_taskUniqueName);
    }

    notifyListeners();
  }

  Future<void> _registerWorkmanagerTask() async {
    final now = DateTime.now();
    var scheduledTime = DateTime(now.year, now.month, now.day, 11, 0);
    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }
    final initialDelay = scheduledTime.difference(now);

    await Workmanager().registerPeriodicTask(
      _taskUniqueName,
      _taskName,
      frequency: const Duration(hours: 24),
      initialDelay: initialDelay,
      constraints: Constraints(networkType: NetworkType.connected),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.update,
    );
  }
}