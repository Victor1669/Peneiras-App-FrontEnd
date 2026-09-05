import 'package:flutter/material.dart';
import 'package:peneiras/models/input_config.dart';

class DynamicInput extends StatelessWidget {
  final InputConfig config;
  final TextEditingController? controller;
  final String? singleValue;
  final List<String>? multipleValues;
  final ValueChanged<String?>? onSingleChanged;
  final VoidCallback? onMultiTap;
  final VoidCallback? onTapAction;

  const DynamicInput({
    super.key,
    required this.config,
    this.controller,
    this.singleValue,
    this.multipleValues,
    this.onSingleChanged,
    this.onMultiTap,
    this.onTapAction,
  });

  InputDecoration _buildDecoration() {
    return InputDecoration(
      labelText: config.label,
      hintText: config.placeholder,
      helperText: " ",
      prefixIcon: config.icon != null ? Icon(config.icon, size: 22) : null,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (config.type == InputType.select) {
      if (config.isMultiple) {
        String displayLabel = config.placeholder ?? "Selecione...";
        if (multipleValues != null && multipleValues!.isNotEmpty) {
          displayLabel = multipleValues!.map((val) {
            final option = config.items?.firstWhere(
              (item) => item.value == val,
              orElse: () => SelectOption(label: val, value: val),
            );
            return option?.label ?? val;
          }).join(', ');
        }

        return InkWell(
          onTap: onMultiTap,
          child: InputDecorator(
            decoration: _buildDecoration(),
            child: Text(
              displayLabel,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      } else {
        return DropdownButtonFormField<String>(
          initialValue: singleValue,
          decoration: _buildDecoration(),
          items: config.items?.map((item) {
            return DropdownMenuItem(
              value: item.value,
              child: Text(item.label),
            );
          }).toList(),
          onChanged: onSingleChanged,
          validator: config.validator,
        );
      }
    } else {
      return TextFormField(
        controller: controller,
        obscureText: config.isPassword,
        keyboardType: config.keyboardType,
        readOnly:
            config.type == InputType.date || config.type == InputType.time,
        onTap: onTapAction,
        decoration: _buildDecoration(),
        validator: config.validator,
      );
    }
  }
}
