import 'package:flutter/material.dart';

class FormTextFieldWithIcon extends StatelessWidget {
  final dynamic controller;
  final String hintText;
  final bool obscureText;
  final VoidCallback hideTrigger;

  const FormTextFieldWithIcon({
    Key? key,
    required this.hideTrigger,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.all(10),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade800),
            ),
            fillColor: Colors.grey[200],
            filled: true,
            hintText: hintText,
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: hideTrigger,
            )),
      ),
    );
  }
}
