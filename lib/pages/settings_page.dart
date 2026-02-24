import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';
import '../provider/scheduling_provider.dart';
import '../utils/background_service.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Consumer<ThemeProvider>(
        builder: (context, provider, _) {
          return ListView(
            children: [
              ListTile(
                title: const Text('Dark Theme'),
                trailing: Switch.adaptive(
                  value: provider.isDarkMode,
                  onChanged: (value) {
                    provider.toggleTheme();
                  },
                ),
              ),
              ListTile(
                title: const Text('Daily Reminder (11:00 AM)'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: scheduled.isScheduled,
                      onChanged: (value) async {
                        await scheduled.scheduledDailyReminder(value);
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    // Trigger the background service callback manually for testing
                    await BackgroundService.triggerNotificationNow();
                  },
                  child: const Text('Test Notification Now'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
