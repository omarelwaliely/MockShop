import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mockshop/model/user.dart';

class Api {
  static const baseUrl = "http://10.5.50.251/api/";

  static createuser(Map userdata) async {
    var url = Uri.parse("${baseUrl}create_user");
    try {
      final res = await http.post(url, body: userdata);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        debugPrint(data.toString());
      } else {
        debugPrint("Failed to get response");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static getuser(Map checkData) async {
    var url = Uri.parse("${baseUrl}get_user").replace(queryParameters: {
      'username': checkData['username'],
      'password': checkData['password'],
      'accounttype': checkData['accounttype']
    });
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        var user = User(
            username: data['username'],
            password: data['password'],
            accountType: data['accounttype']);
        return user;
      } else {
        return User(username: "ERROR", password: "ERROR", accountType: "ERROR");
      }
    } catch (e) {
      debugPrint(e.toString());
      return User(username: "ERROR", password: "ERROR", accountType: "ERROR");
    }
  }

  static addproduct(Map productdata) async {
    var url = Uri.parse("${baseUrl}add_product");
    try {
      final res = await http.post(url, body: productdata);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        debugPrint(data.toString());
      } else {
        debugPrint("Failed to get response");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
