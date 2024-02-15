import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Validator {
  static validateVendor(BuildContext context, dynamic token) {
    if (token != null && !JwtDecoder.isExpired(token)) {
      var decodedToken = JwtDecoder.decode(token);
      debugPrint(decodedToken.toString());
      if (decodedToken['accounttype'] == 'V') {
        return decodedToken;
      }
    } else {
      return null;
    }
  }

  static validateCustomer(BuildContext context, dynamic token) {
    if (token != null && !JwtDecoder.isExpired(token)) {
      var decodedToken = JwtDecoder.decode(token);
      if (decodedToken['accounttype'] == 'C') {
        return decodedToken;
      }
    } else {
      return null;
    }
  }
}
