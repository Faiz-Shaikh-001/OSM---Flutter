import 'package:flutter/material.dart';
import 'package:osm/features/customer/data/customer_model.dart';
import 'package:osm/features/customer/presentation/widgets/customer_card.dart';

class CustomerList extends StatelessWidget {
  final List<CustomerModel> customers;

  const CustomerList({super.key, required this.customers});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: customers.length,
      itemBuilder: (context, index) {
        return CustomerCard(customer: customers[index]);
      },
    );
  }
}
