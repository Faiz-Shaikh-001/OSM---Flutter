import 'package:flutter/material.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/orders/presentation/screens/customer_step/widgets/no_result_found_view.dart';

class CustomerSearchResults extends StatelessWidget {
  final bool isLoading;
  final List<Customer> results;
  final ValueChanged<Customer> onCustomerSelected;
  final VoidCallback onAddNew;

  const CustomerSearchResults({
    super.key,
    required this.isLoading,
    required this.results,
    required this.onCustomerSelected,
    required this.onAddNew,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (results.isEmpty) {
      return NoResultsFoundView(onAddNew: onAddNew);
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final customer = results[index];
        return Card(
          child: ListTile(
            title: Text(customer.fullName),
            subtitle: Text(customer.primaryPhoneNumber),
            onTap: () => onCustomerSelected(customer),
          ),
        );
      },
    );
  }
}
