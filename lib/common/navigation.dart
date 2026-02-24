import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static Future<dynamic>? intentWithData(String routeName, Object arguments) {
    return navigatorKey.currentState?.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  static Future<dynamic>? intentTo(String routeName) {
    return navigatorKey.currentState?.pushNamed(routeName);
  }

  static void back() => navigatorKey.currentState?.pop();
}
