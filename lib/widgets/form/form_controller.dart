import 'package:flutter/material.dart';
import 'package:peneiras/models/input_config.dart';

class FormController {
  final Map<String, TextEditingController> textControllers = {};
  final Map<String, String?> singleSelectedValues = {};
  final Map<String, List<String>> multipleSelectedValues = {};

  void init(List<InputConfig> inputs) {
    for (var input in inputs) {
      if (input.type == InputType.select) {
        if (input.isMultiple) {
          multipleSelectedValues[input.key] = [];
        } else {
          singleSelectedValues[input.key] = null;
        }
      } else {
        textControllers[input.key] = TextEditingController();
      }
    }
  }

  void dispose() {
    for (var controller in textControllers.values) {
      controller.dispose();
    }
  }

  Map<String, dynamic> collectData() {
    final Map<String, dynamic> formData = {};
    textControllers.forEach((key, controller) {
      formData[key] = controller.text;
    });
    singleSelectedValues.forEach((key, value) {
      formData[key] = value ?? "";
    });
    multipleSelectedValues.forEach((key, value) {
      formData[key] = value;
    });
    return formData;
  }
}
