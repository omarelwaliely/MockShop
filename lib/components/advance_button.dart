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
      width: double.infinity, // Make the button stretch to the right
      padding: const EdgeInsets.symmetric(
          horizontal: 16.0), // Add padding around the button
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, // Set background color to black
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
