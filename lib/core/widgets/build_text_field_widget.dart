import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BuildTextFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isNumeric;
  final bool isDecimal;
  final bool isOptional;

  const BuildTextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.isNumeric = false,
    this.isDecimal = false,
    this.isOptional = false,
  });

  @override
  Widget build(BuildContext context) {
    // Give precedence to `isDecimal` for keyboard type
    final keyboardType = isDecimal
        ? const TextInputType.numberWithOptions(decimal: true)
        : isNumeric
        ? TextInputType.number
        : TextInputType.text;

    // Use InputFormatters for a better UX, preventing invalid input.
    final inputFormatters = <TextInputFormatter>[
      if (isNumeric && !isDecimal) FilteringTextInputFormatter.digitsOnly,
      if (isDecimal)
        // This regex allows numbers and a single decimal point.
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
    ];

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        final trimmedValue = value?.trim() ?? '';

        // 1. Check if the field is empty.
        if (trimmedValue.isEmpty) {
          // Return an error only if it's NOT optional.
          return isOptional ? null : 'Please enter $label';
        }

        // 2. If not empty, perform numeric validation.
        if (isDecimal && double.tryParse(trimmedValue) == null) {
          return 'Please enter a valid decimal number';
        }
        // Use `else if` to avoid conflicting validation with isDecimal.
        else if (isNumeric && int.tryParse(trimmedValue) == null) {
          return 'Please enter a valid whole number';
        }

        // 3. If all checks pass, the value is valid.
        return null;
      },
    );
  }
}
