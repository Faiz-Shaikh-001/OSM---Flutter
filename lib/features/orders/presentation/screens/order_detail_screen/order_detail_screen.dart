// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:osm/features/orders/domain/entities/order.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Order order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final List<String> _statuses = ["Pending", "Completed", "Cancelled"];
  late Order order;

  @override
  void initState() {
    super.initState();
    order = widget.order;
  }

  Future<void> _downloadReceipt() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Order Receipt",
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text("Order ID: ${order.id}"),
              pw.Text(
                // "Customer: ${customer.name} ${order.customer.value?.lastName}",
                "Customer: "
              ),
              pw.Text("Date: ${order.createdAt.toLocal()}"),
              pw.Text("Status: ${order.status}"),
              pw.SizedBox(height: 20),
              pw.Text(
                "Items:",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.TableHelper.fromTextArray(
                headers: ["Product", "Qty", "Price"],
                data: order.items
                    .map(
                      (item) => [
                        item.productName,
                        item.quantity.toString(),
                        "₹${item.unitPrice}",
                      ],
                    )
                    .toList(),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                "Total: ₹${order.payments.first.amountPaid}",
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Receipt downloaded successfully")),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case "Completed":
        return Colors.green;
      case "Cancelled":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Details")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _downloadReceipt,
        icon: const Icon(Icons.download),
        label: const Text("Download"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Order Info Card
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order #${order.id}",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Date: ${order.createdAt.toLocal().toString().split(' ').first}",
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        "Status:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      DropdownButton<String>(
                        value: _statuses.contains(order.status.toString())
                            ? order.status.toString()
                            : _statuses.first,
                        items: _statuses
                            .map(
                              (s) => DropdownMenuItem(
                                value: s,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: _statusColor(s),
                                      size: 12,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(s),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (newStatus) async {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Status updated to $newStatus"),
                            ),
                          );
                        },
                        // onChanged: (newStatus) async {
                        //   if (newStatus != null) {
                        //     setState(() {
                        //       order = order.copyWith(status: newStatus);
                        //     });
                        //     final isar = Isar.getInstance()!;
                        //     await isar.writeTxn(() async {
                        //       await isar.orderModels.put(order);
                        //     });

                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(
                        //         content: Text("Status updated to $newStatus"),
                        //       ),
                        //     );
                        //   }
                        // },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Customer Info Card
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Customer",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    order.customerId.value,
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Items Card
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Items",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Divider(),
                  ...order.items.map(
                    (item) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(item.productName),
                      subtitle: Text("Qty: ${item.quantity}"),
                      trailing: Text("₹${item.unitPrice}"),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Total Summary
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Total: ₹${order.totalAmount}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
