import 'package:fit4try/constants/style.dart';
import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errorMessage),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
    ),
  );
}

void showSuccessSnackBar(BuildContext context, String successMessage) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(successMessage),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.green,
  ));
}

void showAlertSnackBar(BuildContext context, String alertMessage) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      alertMessage,
      textAlign: TextAlign.center,
      style: fontStyle(
        16, // Set the color of the text
        Colors.black, // Set the font size
        FontWeight.bold, // Set the font weight
      ),
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.amber,
  ));
}
