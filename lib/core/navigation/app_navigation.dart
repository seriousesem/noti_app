import 'package:flutter/material.dart';

import '../../presentation/features/login/login_screen.dart';
import '../../presentation/features/notifications/notifications_screen.dart';

class AppNavigation {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesNames.loginScreen:
        return _materialRoute(const LoginScreen());

      case AppRoutesNames.notificationsScreen:
        return _materialRoute(const NotificationsScreen());

      case AppRoutesNames.addNotificationScreen:
        return _materialRoute(const SizedBox());

      default:
        return _materialRoute(const LoginScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}

abstract class AppRoutesNames {
  static const String loginScreen = '/login_screen';
  static const String notificationsScreen = '/notifications_screen';
  static const String addNotificationScreen = '/add_notification_screen';
}
