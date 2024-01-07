import 'package:flutter/material.dart';
import 'package:noti_app/core/theme/app_themes.dart';
import 'package:noti_app/presentation/features/login/login_screen.dart';

import 'core/navigation/app_navogation.dart';
import 'di/injection_container.dart';

Future<void> main() async {
  await initializeDependencies();
  runApp(const NotiApp());
}

class NotiApp extends StatelessWidget {
  const NotiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      onGenerateRoute: AppNavigation.onGenerateRoutes,
      theme: theme(),
      home: const LoginScreen(),
    );
  }
}
