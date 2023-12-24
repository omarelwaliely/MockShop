import 'package:flutter/material.dart';

class AdvanceButton extends StatelessWidget {
  final String displayText;
  final VoidCallback onPressed;

  const AdvanceButton({
    Key? key,
    required this.displayText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Text(
          displayText,
          style: TextStyle(color: Colors.grey[300]),
        ),
      ),
    );
  }
}
