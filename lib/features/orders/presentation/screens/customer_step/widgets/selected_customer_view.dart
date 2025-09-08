import 'package:flutter/material.dart';
import 'package:osm/features/customer/data/customer_model.dart';
import 'package:osm/core/widgets/custom_button.dart';
import 'package:osm/features/orders/presentation/screens/customer_step/widgets/selected_customer_card.dart';

class SelectedCustomerView extends StatelessWidget {
  final CustomerModel customer;
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
            child: SelectedCustomerCard(customer: customer, onRemove: onRemove),
          ),
        ),
        const SizedBox(height: 16),
        CustomButton(label: 'Next Step', onPressed: onNext),
        const SizedBox(height: 16),
      ],
    );
  }
}
