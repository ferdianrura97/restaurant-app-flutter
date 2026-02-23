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
import 'provider/theme_provider.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => RestaurantListProvider(apiService: ApiService())),
        ChangeNotifierProvider(create: (_) => RestaurantSearchProvider(apiService: ApiService())),
        ChangeNotifierProvider(create: (_) => RestaurantDetailProvider(apiService: ApiService())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: '/introPage',
          routes: {
            '/introPage': (context) => const IntroPage(),
            '/restaurantListPage': (context) => const RestaurantListPage(),
            '/restaurantSearchPage': (context) => const RestaurantSearchPage(),
            '/restaurantDetailPage': (context) => const RestaurantDetailPage(),
          },
        );
      },
    );
  }
}
