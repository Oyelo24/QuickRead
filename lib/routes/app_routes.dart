import 'package:flutter/material.dart';
import '../views/login_view.dart';
import '../views/signup_view.dart';
import '../views/home_view.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginView(),
    signup: (context) => const SignupView(),
    home: (context) => const HomeView(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (context) => const LoginView());
      case signup:
        return MaterialPageRoute(builder: (context) => const SignupView());
      case home:
        return MaterialPageRoute(builder: (context) => const HomeView());
      default:
        return MaterialPageRoute(builder: (context) => const LoginView());
    }
  }
}