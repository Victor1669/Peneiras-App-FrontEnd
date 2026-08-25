import 'package:flutter/material.dart';

enum InputType { text, select }

class InputConfig {
  final String key;
  final String label;
  final String? placeholder;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final IconData? icon;

  final InputType type;
  final List<String>? items;

  InputConfig({
    required this.key,
    required this.label,
    this.placeholder,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.icon,
    this.type = InputType.text,
    this.items,
  });
}
