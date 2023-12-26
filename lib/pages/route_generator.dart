import 'package:flutter/material.dart';
import 'package:mockshop/pages/login.dart';
import 'package:mockshop/pages/signup.dart';
import 'package:mockshop/pages/verify_user.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignupPage());
      case '/verify_user':
        if (args is Map<String, String>) {
          return MaterialPageRoute(
            builder: (_) => VerifyUser(data: args),
          );
        } else {
          return _errorRoute();
        }
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(body: Text("ERROR IN PAGE CREATION."));
    });
  }
}
