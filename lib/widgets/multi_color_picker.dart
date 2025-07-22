import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class MultiColorPicker extends StatefulWidget {
  final List<Color> initialColors;
  final Function(List<Color>) onColorsChanged;

  const MultiColorPicker({
    super.key,
    required this.initialColors,
    required this.onColorsChanged,
  });

  @override
  State<MultiColorPicker> createState() => _MultiColorPickerState();
}

class _MultiColorPickerState extends State<MultiColorPicker> {
  late List<Color> selectedColors;

  @override
  void initState() {
    super.initState();
    selectedColors = List<Color>.from(widget.initialColors);
  }

  void _addColor(Color color) {
    if (!selectedColors.contains(color)) {
      setState(() => selectedColors.add(color));
      widget.onColorsChanged(selectedColors);
    }
  }

  void _removeColor(Color color) {
    setState(() => selectedColors.remove(color));
    widget.onColorsChanged(selectedColors);
  }

  void _showColorPicker() {
    Color pickerColor = Colors.blue;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Pick a Color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            color: pickerColor,
            onColorChanged: (color) => pickerColor = color,
            pickersEnabled: <ColorPickerType, bool>{
              ColorPickerType.wheel: true,
              // ColorPickerType.both: true,
              ColorPickerType.primary: false,
              ColorPickerType.accent: false,
            },
            enableShadesSelection: true,
            showColorName: true,
            showColorCode: true,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _addColor(pickerColor);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Model Colors', style: TextStyle(fontSize: 16)),
            ActionChip(
              label: const Text('+ Add Color'),
              onPressed: _showColorPicker,
              backgroundColor: Colors.grey.shade200,
            ),
          ],
        ),
        Wrap(
          spacing: 8,
          children: [
            ...selectedColors.map(
              (color) => Chip(
                label: Text(
                  '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: color,
                deleteIconColor: Colors.white,
                onDeleted: () => _removeColor(color),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
