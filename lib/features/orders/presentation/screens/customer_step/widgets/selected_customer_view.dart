import 'package:flutter/material.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Profile card
                SelectedCustomerCard(customer: customer, onRemove: onRemove),

                const SizedBox(height: 24),

                // Prescription Section Header
                const Padding(
                  padding: EdgeInsets.only(left: 4, bottom: 12),
                  child: Text(
                    "Prescription Details",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),

                // The Prescription Widget (Your existing widget)
                PrescriptionSection(customer: customer),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
