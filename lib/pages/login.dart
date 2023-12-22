import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'lib/assets/logo.png',
                  width: 200,
                  height: 200,
                ),
              ],
            ),
          ),
        ));
  }
}
