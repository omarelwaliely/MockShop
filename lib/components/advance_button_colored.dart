import 'package:flutter/material.dart';

class AdvanceButtonColored extends StatelessWidget {
  final String displayText;
  final VoidCallback onPressed;
  final Color color;

  const AdvanceButtonColored({
    Key? key,
    required this.displayText,
    required this.color,
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
          backgroundColor: color,
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
