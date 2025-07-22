import 'package:flutter/material.dart';

class SizeDropdownWidget extends StatefulWidget {
<<<<<<< HEAD
  const SizeDropdownWidget({super.key});
=======
  final Map<String, dynamic>? initialSize;
  final Function(Map<String, dynamic>)? onSizeChanged;

  const SizeDropdownWidget({
    super.key,
    this.initialSize,
    this.onSizeChanged,
  });
>>>>>>> 376ec89504a7769a91a0771f6a84244fdf219659

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
<<<<<<< HEAD
    selectedSize = frameSizes[0];
=======
    selectedSize = widget.initialSize ?? frameSizes[0];
>>>>>>> 376ec89504a7769a91a0771f6a84244fdf219659
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
<<<<<<< HEAD
        Text('Size', style: TextStyle(fontSize: 15, color: Colors.blueGrey)),
=======
        const Text('Size', style: TextStyle(fontSize: 15, color: Colors.blueGrey)),
>>>>>>> 376ec89504a7769a91a0771f6a84244fdf219659
        DropdownButton<Map<String, dynamic>>(
          value: selectedSize,
          borderRadius: BorderRadius.circular(8.0),
          onChanged: (Map<String, dynamic>? newValue) {
            if (newValue != null) {
              setState(() {
                selectedSize = newValue;
              });
<<<<<<< HEAD
=======
              if (widget.onSizeChanged != null) {
                widget.onSizeChanged!(newValue);
              }
>>>>>>> 376ec89504a7769a91a0771f6a84244fdf219659
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
