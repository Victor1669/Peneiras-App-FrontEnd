import 'package:flutter/material.dart';

import 'package:peneiras/layout/responsive_width.dart';
import 'package:peneiras/widgets/form/form_controller.dart';
import 'package:peneiras/widgets/form/form_helpers.dart';
import 'package:peneiras/widgets/form/dynamic_input.dart';

import '../../../models/input_config.dart';

class DynamicForm extends StatefulWidget {
  final List<InputConfig> inputs;
  final String submitText;
  final Function(Map<String, dynamic>) onSubmit;

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
  late final FormController _formController;

  @override
  void initState() {
    super.initState();
    _formController = FormController();
    _formController.init(widget.inputs);
  }

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_formController.collectData());
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
                child: DynamicInput(
                  config: config,
                  controller: _formController.textControllers[config.key],
                  singleValue: _formController.singleSelectedValues[config.key],
                  multipleValues:
                      _formController.multipleSelectedValues[config.key],
                  onSingleChanged: (newValue) {
                    setState(() {
                      _formController.singleSelectedValues[config.key] =
                          newValue;
                    });
                  },
                  onMultiTap: () => FormHelpers.showMultiSelectDialog(
                    context: context,
                    config: config,
                    currentSelected:
                        _formController.multipleSelectedValues[config.key] ??
                            [],
                    onConfirm: (selected) {
                      setState(() {
                        _formController.multipleSelectedValues[config.key] =
                            selected;
                      });
                    },
                  ),
                  onTapAction: () {
                    if (config.type == InputType.date) {
                      FormHelpers.selectDate(context,
                          _formController.textControllers[config.key]!);
                    } else if (config.type == InputType.time) {
                      FormHelpers.selectTime(context,
                          _formController.textControllers[config.key]!);
                    }
                  },
                ),
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleSave,
              child: Text(widget.submitText),
            ),
          ],
        ),
      ),
    );
  }
}
