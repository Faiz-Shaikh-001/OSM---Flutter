import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:osm/features/inventory/data/models/lens_model.dart';
import 'package:osm/features/inventory/data/models/lens_enums.dart';
import 'package:osm/core/utils/product_type.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';

import '../../features/inventory/data/models/frame_model.dart';
import '../../features/inventory/data/models/frame_enums.dart';
import 'custom_button.dart';

class QrGeneratorWidget extends StatelessWidget {
  final dynamic product;
  final ProductType productType;
  final GlobalKey qrKey = GlobalKey();

  QrGeneratorWidget({
    super.key,
    required this.product,
    required this.productType,
  });

  // Helper method to get the product name
  String _getProductName(dynamic prod, ProductType type) {
    if (type == ProductType.frame) {
      final frame = prod as FrameModel;
      return "${frame.companyName} - ${frame.name}";
    } else if (type == ProductType.lens) {
      final lens = prod as LensModel;
      return "${lens.companyName} - ${lens.productName}";
    }
    return "Unknown Product";
  }

  // Helper method to get the product SKU/Code
  String _getProductCode(dynamic prod, ProductType type) {
    if (type == ProductType.frame) {
      final frame = prod as FrameModel;
      return frame.variants.isNotEmpty
          ? frame.variants.first.productCode ?? 'N/A'
          : 'N/A';
    } else if (type == ProductType.lens) {
      final lens = prod as LensModel;
      return lens.variants.isNotEmpty
          ? lens.variants.first.productCode ?? 'N/A'
          : 'N/A';
    }
    return 'N/A';
  }

  Map<String, String> _getProductSpecificDetails(
    dynamic prod,
    ProductType type,
  ) {
    if (type == ProductType.frame) {
      final frame = prod as FrameModel;
      final variant = frame.variants.isNotEmpty ? frame.variants.first : null;
      return {
        "Size": variant?.size?.toString() ?? 'N/A',
        "Color": variant?.colorName ?? 'N/A',
      };
    } else if (type == ProductType.lens) {
      final lens = prod as LensModel;
      final variant = lens.variants.isNotEmpty ? lens.variants.first : null;
      return {
        "Type": lens.lensType.displayName,
        "Material": variant?.materialType?.displayName ?? 'N/A',
        "Sph": variant?.spherical?.toString() ?? 'N/A',
        "Cyl": variant?.cylindrical?.toString() ?? 'N/A',
      };
    }
    return {};
  }

  Future<void> _printQrWithDetails() async {
    final pdf = pw.Document();

    try {
      RenderRepaintBoundary boundary =
          qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(child: pw.Image(pw.MemoryImage(pngBytes)));
          },
        ),
      );

      await Printing.layoutPdf(onLayout: (format) async => pdf.save());
    } catch (e) {
      debugPrint("Error capturing QR for print: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final String qrData =
        "${product.id}_${_getProductCode(product, productType)}";

    final barcode = Barcode.qrCode();
    final svg = barcode.toSvg(qrData, width: 150, height: 150, drawText: false);

    final productSpecificDetails = _getProductSpecificDetails(
      product,
      productType,
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Product QR")),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: RepaintBoundary(
                      key: qrKey,
                      child: Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // QR Code
                            Container(
                              height: 150,
                              width: 150,
                              padding: const EdgeInsets.all(8),
                              child: SvgPicture.string(svg),
                            ),
                            const SizedBox(width: 12),
                            // Product Info
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getProductName(product, productType),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ...productSpecificDetails.entries.map(
                                  (entry) => Text(
                                    "${entry.key}: ${entry.value}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                Text(
                                  "SKU: ${_getProductCode(product, productType)}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: CustomButton(
              onPressed: _printQrWithDetails,
              label: "Print QR Code",
              icon: Icons.print,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
