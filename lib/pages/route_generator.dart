import 'package:flutter/material.dart';
import 'package:mockshop/pages/add_products.dart';
import 'package:mockshop/pages/edit_product.dart';
import 'package:mockshop/pages/login.dart';
import 'package:mockshop/pages/manage_products.dart';
import 'package:mockshop/pages/signup.dart';
import 'package:mockshop/pages/verify_user.dart';
import 'package:mockshop/pages/products_page.dart';
import 'package:mockshop/pages/view_product.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/login':
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
        if (args is String) {
          return MaterialPageRoute(builder: (_) => AddProducts(token: args));
        } else {
          debugPrint('Arg type of: ${args.runtimeType} is not correct');
          return _errorRoute();
        }
      case '/products_page':
        if (args is String) {
          return MaterialPageRoute(builder: (_) => ProductsPage(token: args));
        } else {
          debugPrint('Arg type of: ${args.runtimeType} is not correct');
          return _errorRoute();
        }
      case '/edit_product':
        if (args is List<dynamic>) {
          return MaterialPageRoute(
              builder: (_) => EditProduct(id: args[1], token: args[0]));
        } else {
          debugPrint('Arg type of: ${args.runtimeType} is not correct');
          return _errorRoute();
        }
      case '/view_product':
        if (args is List<dynamic>) {
          return MaterialPageRoute(
              builder: (_) => ViewProduct(id: args[1], token: args[0]));
        } else {
          debugPrint('Arg type of: ${args.runtimeType} is not correct');
          return _errorRoute();
        }
      case '/manage_products':
        if (args is String) {
          return MaterialPageRoute(builder: (_) => ManageProducts(token: args));
        } else {
          debugPrint('Arg type of: ${args.runtimeType} is not correct');
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
