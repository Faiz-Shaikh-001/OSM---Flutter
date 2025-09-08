import 'package:flutter/material.dart';
import 'package:osm/features/orders/presentation/screens/customer_step/widgets/no_result_found_view.dart';
import 'package:provider/provider.dart';
import 'package:osm/features/customer/viewmodel/customer_viewmodel.dart';
import 'package:osm/features/customer/data/customer_model.dart';

class CustomerSearchResults extends StatelessWidget {
  final Function(CustomerModel) onCustomerSelected;
  final VoidCallback onAddNew;

  const CustomerSearchResults({
    super.key,
    required this.onCustomerSelected,
    required this.onAddNew,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerViewModel>(
      builder: (context, customerViewModel, child) {
        if (customerViewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (customerViewModel.searchResults.isEmpty) {
          return NoResultsFoundView(onAddNew: onAddNew);
        }

        return ListView.builder(
          itemCount: customerViewModel.searchResults.length,
          itemBuilder: (context, index) {
            final customer = customerViewModel.searchResults[index];
            return Card(
              child: ListTile(
                title: Text('${customer.firstName} ${customer.lastName}'),
                subtitle: Text(customer.primaryPhoneNumber),
                onTap: () => onCustomerSelected(customer),
              ),
            );
          },
        );
      },
    );
  }
}
