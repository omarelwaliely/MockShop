import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mockshop/pages/login.dart';
import 'package:mockshop/pages/manage_products.dart';
import 'package:mockshop/pages/products_page.dart';
import 'package:mockshop/pages/route_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MainApp(token: prefs.getString('token')));
}

class MainApp extends StatelessWidget {
  final dynamic token;
  const MainApp({required this.token, super.key});
  Widget choosePage() {
    if (token == null || JwtDecoder.isExpired(token)) {
      return const LoginPage();
    } else {
      var decodedToken = JwtDecoder.decode(token);
      if (decodedToken['accounttype'] == 'C') {
        return const ProductsPage();
      } else {
        return ManageProducts(token: token);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: choosePage(), onGenerateRoute: RouteGenerator.generateRoute);
  }
}
