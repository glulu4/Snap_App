import 'package:app/view_models/task_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskUtils {

  // date picker function
  static Future<void> selectDate(
    BuildContext context, 
    TextEditingController controller, 
    TaskViewModel? taskViewModel // Make this parameter optional
  ) async {
    // Use a default date if taskViewModel is null or use its dueDate
    DateTime initialDate = taskViewModel?.dueDate ?? DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );

    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  // input function
  static TextFormField createTextFormField({
    required TextEditingController controller,
    required String labelText,
    required FormFieldValidator<String> validator,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
      readOnly: readOnly,
      onTap: onTap,
    );
  }

  // dropdown input function
  static DropdownButtonFormField<int> createDropdownButtonFormField({
    required int? value,
    required List<int> options,
    required String labelText,
    required ValueChanged<int?> onChanged,
    required FormFieldValidator<int?> validator,
  }) {
    return DropdownButtonFormField<int>(
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      value: value,
      onChanged: onChanged,
      validator: validator,
      items: options.map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }
}
