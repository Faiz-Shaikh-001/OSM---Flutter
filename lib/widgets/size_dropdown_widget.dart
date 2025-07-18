import 'package:flutter/material.dart';

class SizeDropdownWidget extends StatefulWidget {
  const SizeDropdownWidget({super.key});

  @override
  State<SizeDropdownWidget> createState() => _SizeDropdownWidgetState();
}

class _SizeDropdownWidgetState extends State<SizeDropdownWidget> {
  final List<Map<String, dynamic>> frameSizes = [
    {"label": "Small", "lensWidth": 48, "bridgeWidth": 16, "templeLength": 135},
    {
      "label": "Medium",
      "lensWidth": 52,
      "bridgeWidth": 18,
      "templeLength": 140,
    },
    {
      "label": "Medium-Large",
      "lensWidth": 54,
      "bridgeWidth": 18,
      "templeLength": 145,
    },
    {"label": "Large", "lensWidth": 56, "bridgeWidth": 20, "templeLength": 145},
    {
      "label": "Extra Large",
      "lensWidth": 58,
      "bridgeWidth": 20,
      "templeLength": 150,
    },
  ];

  late Map<String, dynamic> selectedSize;

  @override
  void initState() {
    super.initState();
    selectedSize = frameSizes[0];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Size', style: TextStyle(fontSize: 15, color: Colors.blueGrey)),
        DropdownButton<Map<String, dynamic>>(
          value: selectedSize,
          borderRadius: BorderRadius.circular(8.0),
          onChanged: (Map<String, dynamic>? newValue) {
            if (newValue != null) {
              setState(() {
                selectedSize = newValue;
              });
            }
          },
          items: frameSizes.map((size) {
            String label =
                "${size['label']} (${size['lensWidth']}-${size['bridgeWidth']}-${size['templeLength']})";
            return DropdownMenuItem<Map<String, dynamic>>(
              value: size,
              child: Text(label),
            );
          }).toList(),
        ),
      ],
    );
  }
}
