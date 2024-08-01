import 'package:fit4try/constants/fonts.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final ValueChanged<String>? onChanged; // onChanged added
  final bool enabled;
  final int? maxLines;
  final bool showBorder; // Optional border display
  final Color borderColor; // Optional border color
  final double borderWidth; // Optional border width

  // Constructor with named parameters and required annotation where necessary
  const MyTextField({
    super.key, // key parameter added
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    this.suffixIcon,
    this.onTap,
    this.prefixIcon,
    this.validator,
    this.focusNode,
    this.errorMsg,
    this.onChanged,
    required this.enabled,
    this.maxLines,
    this.showBorder = false, // Default to false
    this.borderColor = Colors.black, // Default to black
    this.borderWidth = 1.0, // Default border width
  }); // key parameter passed to super constructor

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onTap: onTap,
      maxLines: maxLines,
      textInputAction: TextInputAction.next,
      onChanged: onChanged, // onChanged directly assigned here
      enabled: enabled,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor, width: borderWidth),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: borderWidth),
          borderRadius: BorderRadius.circular(16),
        ),
        fillColor: AppColors.backgroundColor1,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        errorText: errorMsg,
      ),
    );
  }
}
