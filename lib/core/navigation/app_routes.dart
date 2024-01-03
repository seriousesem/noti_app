import 'package:flutter/material.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesNames.authorizationScreen:
        return _materialRoute(const SizedBox());

      case AppRoutesNames.notificationsScreen:
        return _materialRoute(const SizedBox());

      case AppRoutesNames.addNotificationScreen:
        return _materialRoute(const SizedBox());

      default:
        return _materialRoute(const SizedBox());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}

abstract class AppRoutesNames {
  static const String authorizationScreen = '/authorization_screen';
  static const String notificationsScreen = '/notifications_screen';
  static const String addNotificationScreen = '/add_notification_screen';
}
