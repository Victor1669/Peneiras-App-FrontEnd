import 'package:flutter/material.dart';
import 'package:peneiras/models/input_config.dart';
import 'package:peneiras/widgets/transparent_button.dart';

class FormHelpers {
  static Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text =
          "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  static Future<void> selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      controller.text =
          "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
    }
  }

  static Future<void> showMultiSelectDialog({
    required BuildContext context,
    required InputConfig config,
    required List<String> currentSelected,
    required Function(List<String>) onConfirm,
  }) async {
    final List<String> tempSelected = List.from(currentSelected);

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(config.label),
              content: SizedBox(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: ListBody(
                    children: config.items?.map((item) {
                          final isChecked = tempSelected.contains(item.value);
                          return CheckboxListTile(
                            value: isChecked,
                            title: Text(item.label),
                            onChanged: (bool? checked) {
                              setDialogState(() {
                                if (checked == true) {
                                  tempSelected.add(item.value);
                                } else {
                                  tempSelected.remove(item.value);
                                }
                              });
                            },
                          );
                        }).toList() ??
                        [],
                  ),
                ),
              ),
              actions: [
                Row(
                  children: [
                    Expanded(
                        child: TransparentButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancelar"))),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          onConfirm(tempSelected);
                          Navigator.pop(context, tempSelected);
                        },
                        child: const Text("Confirmar"),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }
}
