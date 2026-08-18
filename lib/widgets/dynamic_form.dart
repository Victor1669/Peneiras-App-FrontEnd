import 'package:flutter/material.dart';
import 'package:peneiras/layout/responsive_width.dart';
import '../models/input_config.dart';

class DynamicForm extends StatefulWidget {
  final List<InputConfig> inputs;
  final String submitText;
  final Function(Map<String, String>) onSubmit;
  const DynamicForm({
    super.key,
    required this.inputs,
    required this.onSubmit,
    this.submitText = "Enviar",
  });
  @override
  State<DynamicForm> createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  @override
  void initState() {
    super.initState();
    for (var input in widget.inputs) {
      _controllers[input.key] = TextEditingController();
    }
  }

  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      final Map<String, String> formData = {};
      _controllers.forEach((key, controller) {
        formData[key] = controller.text;
      });
      widget.onSubmit(formData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidth(
        child: Form(
      key: _formKey,
      child: Column(
        spacing: 30,
        children: [
          ...widget.inputs.map((config) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextFormField(
                  controller: _controllers[config.key],
                  obscureText: config.isPassword,
                  keyboardType: config.keyboardType,
                  decoration: InputDecoration(
                    labelText: config.label,
                    hintText: config.placeholder,
                    helperText: " ",
                    prefixIcon: config.icon != null
                        ? Icon(
                            config.icon,
                            size: 22,
                          )
                        : null,
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  validator: config.validator,
                ));
          }),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _handleSave,
            child: Text(widget.submitText),
          ),
        ],
      ),
    ));
  }
}
