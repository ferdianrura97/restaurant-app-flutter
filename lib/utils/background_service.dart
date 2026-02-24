import 'dart:developer' as developer;
import 'dart:isolate';
import 'dart:ui';
import '../data/api/api_service.dart';
import 'notification_helper.dart';
import 'package:workmanager/workmanager.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  // Manual Trigger button
  static Future<void> triggerNotificationNow() async {
    await _triggerNotification();
  }
}

Future<void> _triggerNotification() async {
  final NotificationHelper notificationHelper = NotificationHelper();
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  var result = await ApiService().getRestaurantList();
  await notificationHelper.showNotification(
    flutterLocalNotificationsPlugin,
    result,
  );

  BackgroundService._uiSendPort ??= IsolateNameServer.lookupPortByName(
    BackgroundService._isolateName,
  );
  BackgroundService._uiSendPort?.send(null);
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    developer.log('callbackDispatcher CALLED by Workmanager! Task: $task');
    await _triggerNotification();
    developer.log('callbackDispatcher COMPLETED successfully!');
    return Future.value(true);
  });
}
