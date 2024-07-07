import 'package:flutter/material.dart';
import 'package:fit4try/constants/style.dart'; // Ensure correct path to your constants file

enum ButtonWidth {
  small, // e.g., 100.0
  medium, // e.g., 150.0
  large, // e.g., 200.0
  xLarge, // e.g., 250.0
  xxLarge, // e.g., 300.0
}

class MyButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Color buttonTextColor;
  final double buttonTextSize;
  final FontWeight buttonTextWeight;
  final VoidCallback onPressed;
  final BorderRadius borderRadius;
  final ButtonWidth buttonWidth; // Added ButtonWidth parameter

  const MyButton({
    super.key,
    required this.text,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.buttonTextSize,
    required this.buttonTextWeight,
    required this.onPressed,
    this.borderRadius = BorderRadius.zero, // Default value for BorderRadius
    required this.buttonWidth,
    // Button width is now required
  });

  // Helper method to convert ButtonWidth enum to actual width
  double _getWidth(ButtonWidth width) {
    switch (width) {
      case ButtonWidth.small:
        return 100.0;
      case ButtonWidth.medium:
        return 150.0;
      case ButtonWidth.large:
        return 200.0;
      case ButtonWidth.xLarge:
        return 250.0;
      case ButtonWidth.xxLarge:
        return 300.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _getWidth(buttonWidth), // Set width based on enum value
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
        child: Text(
          text,
          style: fontStyle(buttonTextSize, buttonTextColor, buttonTextWeight),
        ),
      ),
    );
  }
}
