import 'package:flutter/material.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QrGeneratorWidget extends StatelessWidget {
  final String itemName;
  final String sku;
  final String color;
  final String size;

  const QrGeneratorWidget({
    super.key,
    required this.itemName,
    required this.sku,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    // Create QR code
    final barcode = Barcode.qrCode();

    // Generate SVG barcode
    final svg = barcode.toSvg(
      'Item: $itemName\nSKU: $sku\nColor: $color\nSize: $size',
      width: 150,
      height: 150,
      drawText: false,
    );

    return Scaffold(
      appBar: AppBar(title: Text("Product QR")),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Barcode
          Container(
            height: 150,
            width: 150,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.green),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.string(svg),
          ),
          const SizedBox(width: 10),
          // Product Details
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text("Size: $size", style: TextStyle(fontSize: 16)),
              Text("Color: $color", style: TextStyle(fontSize: 16)),
              Text("SKU: $sku", style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}
