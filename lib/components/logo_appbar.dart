import 'package:flutter/material.dart';

class LogoAppBar extends StatelessWidget {
  const LogoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[400],
      title: Image.asset(
        'lib/assets/logo.png',
        height: kToolbarHeight * 0.6,
      ),
    );
  }
}
