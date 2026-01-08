import 'package:flutter/material.dart';
import 'package:osm/core/widgets/custom_button.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/orders/presentation/screens/customer_step/widgets/prescription_section.dart';
import 'package:osm/features/orders/presentation/screens/customer_step/widgets/selected_customer_card.dart';

class SelectedCustomerView extends StatelessWidget {
  final Customer customer;
  final VoidCallback onRemove;
  final VoidCallback onNext;

  const SelectedCustomerView({
    super.key,
    required this.customer,
    required this.onRemove,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SelectedCustomerCard(customer: customer, onRemove: onRemove),
                const SizedBox(height: 20),
                PrescriptionSection(customer: customer),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        CustomButton(label: 'Next Step', onPressed: onNext),
        const SizedBox(height: 16),
      ],
    );
  }
}
