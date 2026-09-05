import 'package:flutter/material.dart';

enum InputType {
  text,
  select,
  date,
  time,
}

class SelectOption {
  final String label;
  final String value;

  const SelectOption({
    required this.label,
    required this.value,
  });
}

class InputConfig {
  final String key;
  final String label;
  final String? placeholder;
  final IconData? icon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final InputType type;
  final List<SelectOption>? items;
  final bool isMultiple;
  final String? Function(String?)? validator;

  const InputConfig({
    required this.key,
    required this.label,
    this.placeholder,
    this.icon,
    this.isPassword = false,
    this.keyboardType,
    this.type = InputType.text,
    this.items,
    this.isMultiple = false,
    this.validator,
  });
}
