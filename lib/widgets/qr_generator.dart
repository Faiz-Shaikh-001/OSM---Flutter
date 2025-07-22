import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/rendering.dart';

import '../models/frame_model.dart';
import 'custom_button.dart';

class QrGeneratorWidget extends StatelessWidget {
<<<<<<< HEAD
  final FrameModel frame;
  final FrameVariant variant;
  final GlobalKey qrKey = GlobalKey();

  QrGeneratorWidget({super.key, required this.frame, required this.variant});
=======
  final Frame frame;
  final GlobalKey qrKey = GlobalKey();

  QrGeneratorWidget({super.key, required this.frame});
>>>>>>> 376ec89504a7769a91a0771f6a84244fdf219659

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
      print("Error capturing QR for print: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final barcode = Barcode.qrCode();
<<<<<<< HEAD
    final productCode = variant.getProductCode(frame.frameType);

    final code = frame.id + productCode;

    final svg = barcode.toSvg(code, width: 150, height: 150, drawText: false);
=======
    final productCode = frame.getProductCode();

    final svg = barcode.toSvg(
      productCode,
      width: 150,
      height: 150,
      drawText: false,
    );
>>>>>>> 376ec89504a7769a91a0771f6a84244fdf219659

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
<<<<<<< HEAD
                                  "${frame.companyName} - ${frame.name}",
=======
                                  frame.name,
>>>>>>> 376ec89504a7769a91a0771f6a84244fdf219659
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
<<<<<<< HEAD
                                  "Size: ${variant.size}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "Color: ${variant.colorName}",
=======
                                  "Size: ${frame.size}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "Color: ${frame.colorName}",
>>>>>>> 376ec89504a7769a91a0771f6a84244fdf219659
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "SKU: $productCode",
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
