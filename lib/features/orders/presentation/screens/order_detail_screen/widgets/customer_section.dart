import 'package:flutter/material.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/orders/domain/entities/order.dart';

class CustomerSection extends StatelessWidget {
  final Order order;
  final Customer? customer;
  final bool isLoading;

  const CustomerSection({
    super.key,
    required this.order,
    this.customer,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person_outline, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  "Customer Details",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),

            if (isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: LinearProgressIndicator(minHeight: 2),
              )
            else if (customer != null)
              Column(
                children: [
                  _buildRow("Name", customer!.fullName, isBold: true),
                  if (customer!.primaryPhoneNumber.isNotEmpty)
                    _buildRow("Phone", customer!.primaryPhoneNumber),
                  if (customer!.email?.isNotEmpty ?? false)
                    _buildRow("Email", customer!.email!),
                  if (customer!.city?.isNotEmpty ?? false)
                    _buildRow("City", customer!.city!),
                ],
              )
            else
              // Fallback if load failed or customer null
              _buildRow("Name", customer!.fullName, isBold: true),

            _buildRow(
              "Customer ID",
              order.customerId.value.length > 8
                  ? "${order.customerId.value}..."
                  : order.customerId.value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}