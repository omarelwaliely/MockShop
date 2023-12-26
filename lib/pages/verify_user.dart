import 'package:flutter/material.dart';
import 'package:mockshop/services/api.dart';

class VerifyUser extends StatelessWidget {
  final Map<String, String> data;
  const VerifyUser({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: Api.getuser({
        'username': data['username'],
        'password': data['password'],
        'accounttype': data['accounttype']
      }),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final user = snapshot.data;
          return Text(user.accountType);
        }
      },
    ));
  }
}
