import 'package:flutter/material.dart';
import 'package:osm/features/orders/domain/entities/order_item.dart';
import 'package:osm/features/orders/domain/entities/order_item_type.dart';

class ItemsSection extends StatelessWidget {
  final List<OrderItem> items;
  const ItemsSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.shopping_bag_outlined, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  "Ordered Items",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  "${items.length} Items",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const Divider(height: 24),
            ...items.map((item) => _buildItemRow(context, item)),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRow(BuildContext context, OrderItem item) {
    final isLens = item.type == OrderItemType.lens;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isLens ? Colors.blue[50] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isLens ? Icons.auto_awesome : Icons.sell,
                  size: 20,
                  color: isLens ? Colors.blue[700] : Colors.grey[700],
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.productName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),

                    if (isLens) ...[
                      const SizedBox(height: 4),
                      _buildBreakdownRow("Base Price", item.basePrice.value),
                      if (item.materialType != null)
                        _buildBreakdownRow(
                          "Material: ${item.materialType!.name.toUpperCase()}",
                          item.materialSurcharge,
                        ),
                      if (item.coatings?.isNotEmpty ?? false)
                        _buildBreakdownRow(
                          "Coatings: ${item.coatings!.join(', ')}",
                          item.coatingSurcharges,
                        ),
                    ],

                    const SizedBox(height: 8),

                    if (isLens) _buildPrescriptionBox(item),

                    const SizedBox(height: 4),
                    Text(
                      "Qty: ${item.quantity}  ×  ₹${item.unitPrice.value.toStringAsFixed(0)}",
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
              ),

              Text(
                "₹${item.total.value.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
        ],
      ),
    );
  }

  Widget _buildPrescriptionBox(OrderItem item) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.1)),
      ),
      child: Text(
        "SPH / CYL x AXIS | ADD\n"
        "RE: ${item.rightEye?.sphere ?? '-'} / ${item.rightEye?.cylinder ?? '-'} x ${item.rightEye?.axis ?? '0'}  |  Add: ${item.rightEye?.add ?? '-'}\n"
        "LE: ${item.leftEye?.sphere ?? '-'} / ${item.leftEye?.cylinder ?? '-'} x ${item.leftEye?.axis ?? '0'}  |  Add: ${item.leftEye?.add ?? '-'}\n"
        "PD: ${item.pd?.right ?? '0'} / ${item.pd?.left ?? '0'}",
        style: TextStyle(
          fontSize: 11,
          color: Colors.blue[900],
          height: 1.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildBreakdownRow(String label, double price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          const Spacer(),
          Text(
            "+₹${price.toStringAsFixed(0)}",
            style: TextStyle(fontSize: 11, color: Colors.grey[800]),
          ),
        ],
      ),
    );
  }
}
