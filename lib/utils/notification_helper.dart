import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../data/model/restaurant.dart';
import '../common/navigation.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(FlutterLocalNotificationsPlugin plugin) async {
    var initializationSettingsAndroid = const AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await plugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) async {
        final payload = details.payload;
        if (payload != null && payload.isNotEmpty) {
          dynamic data;
          try {
            data = json.decode(payload);
          } catch (_) {
            return;
          }

          final id = (data is Map) ? data['id'] : null;
          if (id != null) {
            Navigation.intentWithData('/restaurantDetailPage', id);
          }
        }
      },
    );
  }

  Future<void> requestPermission(FlutterLocalNotificationsPlugin plugin) async {
    await plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin plugin,
    RestaurantListResponse restaurantResponse,
  ) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "restaurant recomendation channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true),
    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    int randomIndex =
        (restaurantResponse.restaurants..shuffle()).first.id.hashCode;
    Restaurant randomRestaurant = restaurantResponse.restaurants.first;
    var notificationId = randomIndex;

    var titleNotification = "<b>Daily Restaurant Recommendation</b>";
    var titleNews = randomRestaurant.name;

    await plugin.show(
      id: notificationId,
      title: titleNotification,
      body: titleNews,
      notificationDetails: platformChannelSpecifics,
      payload: json.encode({
        'id': randomRestaurant.id,
        'name': randomRestaurant.name,
      }),
    );
  }
}
