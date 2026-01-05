import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:barcode/barcode.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:osm/core/utils/product_type.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame_variant.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';
import 'package:osm/features/inventory/domain/entities/accessory/accessory.dart';

import 'custom_button.dart';

class QrGeneratorWidget extends StatelessWidget {
  final Object product;
  final ProductType productType;
  final FrameVariant? selectedFrameVariant;

  QrGeneratorWidget({
    super.key,
    required this.product,
    required this.productType,
    this.selectedFrameVariant,
  });

  final GlobalKey qrKey = GlobalKey();

  int _availableQuantity() {
    if (product is Frame && selectedFrameVariant != null) {
      return selectedFrameVariant!.quantity;
    }

    if (product is Lens) {
      return 1; // lenses usually not stock-counted per unit
    }

    if (product is Accessory) {
      return (product as Accessory).quantity;
    }

    return 1;
  }

  String _productName() {
    if (product is Frame) {
      final f = product as Frame;
      return '${f.companyName} - ${f.name}';
    }
    if (product is Lens) {
      final l = product as Lens;
      return '${l.companyName} - ${l.productName}';
    }
    if (product is Accessory) {
      final a = product as Accessory;
      return '${a.brand} - ${a.name}';
    }
    return 'Unknown Product';
  }

  Map<String, String> _specificDetails() {
    if (product is Frame && selectedFrameVariant != null) {
      return {
        'Size': selectedFrameVariant!.size.toString(),
        'Color': selectedFrameVariant!.colorName,
        'Price': selectedFrameVariant!.salesPrice.value.toStringAsFixed(2),
      };
    }

    if (product is Lens) {
      final lens = product as Lens;
      return {
        'Type': lens.lensType.name,
        'Index': '${lens.minIndex} - ${lens.maxIndex}',
      };
    }

    return {};
  }

  pw.Widget _withCutGuides(pw.Widget child) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 0.5, style: pw.BorderStyle.dashed),
      ),
      padding: const pw.EdgeInsets.all(6),
      child: child,
    );
  }

  Future<void> _printQr({int? quantity}) async {
    try {
      final boundary =
          qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      final image = await boundary.toImage(pixelRatio: 3);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final int totalLabels = quantity ?? 1;

      const int labelsPerPage = 24;
      final int totalPages = (totalLabels / labelsPerPage).ceil();

      final pdf = pw.Document();

      int printed = 0;

      for (int page = 0; page < totalPages; page++) {
        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            margin: const pw.EdgeInsets.all(20),
            build: (_) {
              return pw.GridView(
                crossAxisCount: 2, // 12 left + 12 right
                childAspectRatio: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: List.generate(labelsPerPage, (index) {
                  if (printed >= totalLabels) {
                    return pw.SizedBox();
                  }
                  printed++;

                  return _withCutGuides(
                    pw.Image(
                      pw.MemoryImage(pngBytes),
                      fit: pw.BoxFit.fitHeight,
                    ),
                  );
                }),
              );
            },
          ),
        );
      }

      await Printing.layoutPdf(onLayout: (_) async => pdf.save());
    } catch (e) {
      debugPrint('QR print failed: $e');
    }
  }

  String _qrData() {
    if (product is Frame) {
      return (product as Frame).qrKey;
    }

    if (product is Lens) {
      return (product as Lens).qrKey;
    }

    if (product is Accessory) {
      return (product as Accessory).qrKey;
    }

    throw Exception('QR data not available');
  }

  String _sku() {
    if (product is Frame && selectedFrameVariant != null) {
      return selectedFrameVariant!.sku;
    }

    if (product is Lens) {
      return (product as Lens).sku;
    }

    if (product is Accessory) {
      return (product as Accessory).sku;
    }

    return 'N/A';
  }

  @override
  Widget build(BuildContext context) {
    final qrData = _qrData();
    final barcode = Barcode.qrCode();
    final svg = barcode.toSvg(qrData, width: 150, height: 150, drawText: false);

    final details = _specificDetails();

    return Scaffold(
      appBar: AppBar(title: const Text('Product QR')),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: RepaintBoundary(
                  key: qrKey,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: SvgPicture.string(svg),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _productName(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...details.entries.map(
                              (e) => Text(
                                '${e.key}: ${e.value}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            Text(
                              'SKU: ${_sku()}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: CustomButton(
              onPressed: () => _showPrintOptions(context),
              label: 'Print QR Code',
              icon: Icons.print,
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  void _showPrintOptions(BuildContext context) {
    final qtyController = TextEditingController();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Print QR Labels',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              ListTile(
                leading: const Icon(Icons.looks_one),
                title: const Text('Print single label'),
                onTap: () {
                  Navigator.pop(context);
                  _printQr(quantity: 1);
                },
              ),

              ListTile(
                leading: const Icon(Icons.inventory_2),
                title: Text('Print equal to stock (${_availableQuantity()})'),
                onTap: () {
                  Navigator.pop(context);
                  _printQr(quantity: _availableQuantity());
                },
              ),

              const Divider(),

              TextFormField(
                controller: qtyController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Custom quantity',
                  hintText: 'Enter number of labels',
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('Print custom quantity'),
                  onPressed: () {
                    final value = int.tryParse(qtyController.text);
                    if (value == null || value <= 0) return;

                    Navigator.pop(context);
                    _printQr(quantity: value);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
