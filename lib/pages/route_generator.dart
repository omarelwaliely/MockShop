import 'package:flutter/material.dart';
import 'package:mockshop/pages/login.dart';
import 'package:mockshop/pages/signup.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    // case '/page':
    // if(args is correctdatattypehere){
    // return MaterialPageRoute(
    //  builder: (_) => Page(
    // data: args,
    // ),
    //);

    // }
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignupPage());
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
