import 'package:flutter/material.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/customer/presentation/bloc/customer/customer_bloc.dart';
import 'package:osm/features/customer/presentation/screens/customer_details_page.dart';
import 'package:osm/features/customer/services/build_customer_image.dart';
import 'package:provider/provider.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;

  const CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: customer.profileImageUrl != null
              ? buildCustomerImage(customer.profileImageUrl!)
              : null,
          child: customer.profileImageUrl == null
              ? const Icon(Icons.person)
              : null,
        ),
        title: Text(customer.fullName),
        subtitle: Text(
          "City: ${customer.city ?? '-'} | Phone: ${customer.primaryPhoneNumber}",
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () async {
            // Moving logic outside
            _confirmDelete(context);
          },
        ),
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CustomerDetailsPage(customerId: CustomerId(customer.id!)),
            ),
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Customer'),
        content: const Text('Are you sure you want to delete this customer?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<CustomerBloc>().add(
                DeleteCustomerEvent(customer),
              );
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
