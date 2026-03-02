import 'package:flutter/material.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/setting_screen.dart';
import '../screens/notification_screen.dart';

class AppRoutes {
  static const String splash = "/";
  static const String login = "/login";
  static const String dashboard = "/dashboard";
  static const String setting = "/setting";
  static const String notification = "/notification";

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => SplashScreen(),
    login: (context) => LoginScreen(),
    dashboard: (context) => DashboardScreen(),
    setting: (context) => SettingScreen(),
    notification: (context) => const NotificationScreen(),
  };
}
