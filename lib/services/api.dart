import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = "http://192.168.100.169/api/";

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
}
