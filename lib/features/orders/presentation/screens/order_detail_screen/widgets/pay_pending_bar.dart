import 'package:flutter/material.dart';
import 'package:osm/core/value_objects/money.dart';

class PayPendingBar extends StatelessWidget {
  final Money pendingAmount;
  final VoidCallback onPayPressed;

  const PayPendingBar({
    super.key,
    required this.pendingAmount,
    required this.onPayPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Pending Amount",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  "₹${pendingAmount.toString()}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: onPayPressed,
              icon: const Icon(Icons.payment),
              label: const Text("Pay Balance"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
