import 'package:flutter/material.dart';

class InputConfig {
  final String label;
  final String? placeholder;
  final String? Function(String?)? validator;
  final bool isPassword;
  final TextInputType keyboardType;
  final String key;

  InputConfig({
    required this.key,
    required this.label,
    this.placeholder,
    this.validator,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });
}
