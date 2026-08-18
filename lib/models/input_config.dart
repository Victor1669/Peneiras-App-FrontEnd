import 'package:flutter/material.dart';

class InputConfig {
  final String key;
  final String label;
  final String? placeholder;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final IconData? icon;

  InputConfig({
    required this.key,
    required this.label,
    this.placeholder,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.icon,
  });
}
