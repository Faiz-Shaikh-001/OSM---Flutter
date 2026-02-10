import 'package:flutter/material.dart';
import 'package:osm/features/orders/domain/entities/order.dart';

class PaymentSummarySection extends StatelessWidget {
  final Order order;
  const PaymentSummarySection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    double progress = 0;
    if (order.totalAmount.value > 0) {
      progress = (order.paidAmount.value / order.totalAmount.value).clamp(
        0.0,
        1.0,
      );
    }

    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildRow(
              "Total Amount",
              "₹${order.totalAmount.toString()}",
              isBold: true,
            ),
            const SizedBox(height: 8),
            _buildRow(
              "Paid Amount",
              "- ₹${order.paidAmount.toString()}",
              color: Colors.green,
            ),
            const Divider(height: 24),
            _buildRow(
              "Balance Due",
              "₹${order.pendingAmount.toString()}",
              isBold: true,
              color: order.pendingAmount.value > 0 ? Colors.red : Colors.green,
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[200],
                color: progress == 1 ? Colors.green : Colors.orange,
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "${(progress * 100).toInt()}% Paid",
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(
    String label,
    String value, {
    bool isBold = false,
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
            color: color,
          ),
        ),
      ],
    );
  }
}
