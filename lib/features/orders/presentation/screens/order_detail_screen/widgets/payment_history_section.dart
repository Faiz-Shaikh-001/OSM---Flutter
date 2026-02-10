import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osm/features/orders/domain/entities/payment.dart';
import 'package:osm/features/orders/domain/entities/payment_enums.dart';

class PaymentHistorySection extends StatelessWidget {
  final List<Payment> payments;
  const PaymentHistorySection({super.key, required this.payments});

  @override
  Widget build(BuildContext context) {
    if (payments.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            "Payment History",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        const SizedBox(height: 8),
        ...payments.map(
          (p) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            elevation: 0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green[50],
                child: Icon(
                  _getMethodIcon(p.method),
                  color: Colors.green,
                  size: 20,
                ),
              ),
              title: Text(
                "₹${p.amountPaid.toString()}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              subtitle: Text(
                "${DateFormat.yMMMd().format(p.paymentDate)} • ${p.method.name.capitalize}",
              ),
              trailing: const Icon(
                Icons.check_circle,
                size: 16,
                color: Colors.green,
              ),
            ),
          ),
        ),
      ],
    );
  }

  IconData _getMethodIcon(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return Icons.money;
      case PaymentMethod.card:
        return Icons.credit_card;
      case PaymentMethod.upi:
        return Icons.qr_code;
      default:
        return Icons.payment;
    }
  }
}