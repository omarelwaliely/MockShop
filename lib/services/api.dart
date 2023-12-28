import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
//import 'package:mockshop/model/user.dart';
import 'package:mockshop/model/product.dart';

class Api {
  static const baseUrl = "http://192.168.100.118/api/";

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
        if (data['status']) {
          debugPrint("I am here");
          return data['token'];
        } else {
          return "error";
        }
      } else {
        return "error";
      }
    } catch (e) {
      debugPrint(e.toString());
      return "error";
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

  static getallproducts() async {
    var url = Uri.parse("${baseUrl}get_all_products");
    List<Product> products = [];
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        data.forEach((value) {
          products.add(Product(
              id: value['id'].toString(),
              productName: value['productname'],
              description: value['description'],
              price: value['productname'],
              vendorName: value['vendorusername']));
        });
        return products;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  }

  static getproductsof(vendorUsername) async {
    var url = Uri.parse("${baseUrl}get_products_of")
        .replace(queryParameters: {'vendorusername': vendorUsername});
    List<Product> products = [];
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        data.forEach((value) {
          products.add(Product(
              id: value['id'].toString(),
              productName: value['productname'],
              description: value['description'],
              price: value['productname'],
              vendorName: value['vendorusername']));
        });
        return products;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  }

  static updateproduct(id, newProduct) async {
    var url = Uri.parse("${baseUrl}update_product")
        .replace(queryParameters: {'id': id});
    debugPrint(url.toString());
    try {
      final res = await http.put(url, body: newProduct);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        debugPrint(data.toString());
      } else {
        debugPrint("Failed: ${jsonDecode(res.body).toString()}");
      }
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  }

  static deleteproduct(id) async {
    var url = Uri.parse("${baseUrl}delete_product")
        .replace(queryParameters: {'id': id});
    debugPrint(url.toString());
    try {
      final res = await http.delete(url);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        debugPrint(data.toString());
      } else {
        debugPrint("Failed: ${jsonDecode(res.body).toString()}");
      }
    } catch (e) {
      debugPrint("ERROR: ${e.toString()}");
      return;
    }
  }
}
