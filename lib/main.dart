import 'package:flutter/material.dart';
import 'package:mockshop/pages/route_generator.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        initialRoute: '/edit_product',
        onGenerateRoute: RouteGenerator.generateRoute);
  }
}
