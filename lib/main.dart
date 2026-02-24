import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/api/api_service.dart';
import 'pages/intro_page.dart';
import 'pages/restaurant_list_page.dart';
import 'pages/restaurant_search_page.dart';
import 'pages/restaurant_detail_page.dart';
import 'provider/restaurant_list_provider.dart';
import 'provider/restaurant_search_provider.dart';
import 'provider/restaurant_detail_provider.dart';
import 'provider/favorite_provider.dart';
import 'provider/theme_provider.dart';
import 'data/db/database_helper.dart';
import 'theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'pages/favorite_page.dart';
import 'pages/settings_page.dart';
import 'utils/preferences_helper.dart';
import 'utils/background_service.dart';
import 'utils/notification_helper.dart';
import 'provider/scheduling_provider.dart';
import 'common/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();

  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  await notificationHelper.requestPermission(flutterLocalNotificationsPlugin);

  // Check if app was launched by tapping a notification
  final launchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  String? notificationRestaurantId;
  if (launchDetails != null &&
      launchDetails.didNotificationLaunchApp &&
      launchDetails.notificationResponse?.payload != null) {
    try {
      final data = json.decode(launchDetails.notificationResponse!.payload!);
      notificationRestaurantId = (data is Map) ? data['id'] : null;
    } catch (_) {}
  }

  Workmanager().initialize(callbackDispatcher);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: Future.value(prefs),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: Future.value(prefs),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantListProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantSearchProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantDetailProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(databaseHelper: DatabaseHelper()),
        ),
      ],
      child: MyApp(notificationRestaurantId: notificationRestaurantId),
    ),
  );
}

class MyApp extends StatefulWidget {
  final String? notificationRestaurantId;

  const MyApp({super.key, this.notificationRestaurantId});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    if (widget.notificationRestaurantId != null) {
      // Wait for navigator to be ready, then navigate to detail page
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navigatorKey.currentState?.pushNamed(
          '/restaurantDetailPage',
          arguments: widget.notificationRestaurantId,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          initialRoute: '/introPage',
          routes: {
            '/introPage': (context) => const IntroPage(),
            '/restaurantListPage': (context) => const RestaurantListPage(),
            '/restaurantSearchPage': (context) => const RestaurantSearchPage(),
            '/restaurantDetailPage': (context) => const RestaurantDetailPage(),
            '/favoritePage': (context) => const FavoritePage(),
            '/settingsPage': (context) => const SettingsPage(),
          },
        );
      },
    );
  }
}