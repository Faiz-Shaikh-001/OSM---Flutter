import 'package:flutter/material.dart';

class ColorDropDownWidget extends StatefulWidget {
  final String initialColor;
  final ValueChanged<String>? onColorChanged;
  const ColorDropDownWidget({
    super.key,
    this.initialColor = 'Red',
    this.onColorChanged,
  });

  @override
  State<ColorDropDownWidget> createState() => _ColorDropDownWidgetState();
}

class _ColorDropDownWidgetState extends State<ColorDropDownWidget> {
  final Map<String, Color> colorMap = {
    'Red': Colors.red,
    'Green': Colors.green,
    'Blue': Colors.blue,
    'Black': Colors.black,
    'Yellow': Colors.yellow,
  };

  late String selectedColorName = 'Red';

  @override
  void initState() {
    super.initState();
    selectedColorName = colorMap.containsKey(widget.initialColor)
        ? widget.initialColor
        : colorMap.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Color', style: TextStyle(fontSize: 15, color: Colors.blueGrey)),
        DropdownButton(
          value: selectedColorName,
          icon: Icon(Icons.arrow_drop_down),
          borderRadius: BorderRadius.circular(8.0),
          onChanged: (String? newValue) {
            if (newValue == null) return;
            setState(() => selectedColorName = newValue);
            widget.onColorChanged?.call(newValue);
          },
          items: colorMap.entries.map((entry) {
            return DropdownMenuItem(
              value: entry.key,
              child: Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: entry.value,
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(entry.key),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
