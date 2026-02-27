import 'package:flutter/material.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';

class AppRoutes{
  static const String splash = "/";
  static const String login = "/login";
  static const String dashboard = "/dashboard";

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => SplashScreen(),
    login: (context) => LoginScreen(),
    dashboard: (context) => DashboardScreen(),
  };
}

