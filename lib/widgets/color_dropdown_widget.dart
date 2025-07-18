import 'package:flutter/material.dart';

class ColorDropDownWidget extends StatefulWidget {
  const ColorDropDownWidget({super.key});

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

  String selectedColorName = 'Red';

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
            setState(() {
              selectedColorName = newValue!;
            });
          },
          items: colorMap.keys.map((String colorName) {
            return DropdownMenuItem(
              value: colorName,
              child: Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorMap[colorName],
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(colorName),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
