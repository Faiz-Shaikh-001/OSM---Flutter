import 'package:flutter/material.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/customer/presentation/widgets/customer_card.dart';

class CustomerList extends StatelessWidget {
  final List<Customer> customers;

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
