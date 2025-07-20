import 'package:flutter/material.dart';

class BuildTextFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isNumeric;
  final bool isDecimal;

  const BuildTextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.isNumeric = false,
    this.isDecimal = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: isDecimal
          ? const TextInputType.numberWithOptions(decimal: true)
          : isNumeric
          ? TextInputType.number
          : TextInputType.text,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value == null || value.trim().isEmpty) return 'Enter $label';
        if (isNumeric && int.tryParse(value) == null) return 'Invalid number';
        if (isDecimal && double.tryParse(value) == null) return 'Invalid price';
        return null;
      },
    );
  }
}
