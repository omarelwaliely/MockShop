import 'package:flutter/material.dart';
import 'package:mockshop/pages/add_products.dart';
import 'package:mockshop/pages/edit_product.dart';
import 'package:mockshop/pages/login.dart';
import 'package:mockshop/pages/signup.dart';
import 'package:mockshop/pages/verify_user.dart';
import 'package:mockshop/pages/products_page.dart';

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
      case '/add_products':
        return MaterialPageRoute(builder: (_) => AddProducts());
      case '/products_page':
        return MaterialPageRoute(builder: (_) => const ProductsPage());
      case '/edit_product':
        return MaterialPageRoute(builder: (_) => EditProduct());
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
