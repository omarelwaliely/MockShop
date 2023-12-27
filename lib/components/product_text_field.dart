import 'package:flutter/material.dart';

class ProductTextField extends StatelessWidget {
  final dynamic controller;
  final String hintText;
  const ProductTextField(
      {super.key, required this.controller, required this.hintText});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.all(10),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade800)),
            fillColor: Colors.grey[200],
            filled: true,
            hintText: hintText),
      ),
    );
  }
}
