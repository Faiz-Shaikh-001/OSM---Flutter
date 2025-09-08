import 'package:flutter/material.dart';

class ButtonCounter extends StatelessWidget {
  final TextEditingController controller;
  final int minValue;
  final int maxValue;
  final int step;

  const ButtonCounter({
    super.key,
    required this.controller,
    this.minValue = 0,
    this.maxValue = 9999,
    this.step = 1,
  });

  void _changeValue(BuildContext context, int delta) {
    final current = int.tryParse(controller.text) ?? 0;
    final newValue = (current + delta).clamp(minValue, maxValue);
    controller.text = newValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.grey),
            borderRadius: BorderRadius.circular(50),
          ),
          height: 40,
          child: IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () => _changeValue(context, -step),
          ),
        ),
        SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.grey),
            borderRadius: BorderRadius.circular(50),
          ),
          height: 40,
          child: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _changeValue(context, step),
          ),
        ),
      ],
    );
  }
}
