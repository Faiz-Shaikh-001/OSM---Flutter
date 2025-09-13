import 'package:flutter/material.dart';
import 'package:osm/features/customer/data/customer_model.dart';
import 'package:osm/features/customer/data/customer_repository.dart';
import 'package:osm/features/customer/presentation/screens/customer_details_screen.dart';
import 'package:osm/features/customer/services/build_customer_image.dart';
import 'package:osm/features/customer/viewmodel/customer_viewmodel.dart';
import 'package:provider/provider.dart';

class CustomerCard extends StatelessWidget {
  final CustomerModel customer;

  const CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: buildCustomerImage(customer.profileImageUrl),
          onBackgroundImageError: (exception, stackTrace) {
            debugPrint('Error loading image: $exception');
          },
        ),
        title: Text("${customer.firstName} ${customer.lastName}"),
        subtitle: Text(
          "City: ${customer.city} | Phone: ${customer.primaryPhoneNumber}",
        ),
        trailing: IconButton(
          onPressed: () async {
            await context.read<CustomerViewModel>().deleteCustomer(customer.id);
          },
          icon: const Icon(Icons.delete, color: Colors.red),
        ),
        onTap: () async {
          final repo = context.read<CustomerRepository>();
          final fullCustomer = await repo.getCustomerWithRelations(customer.id);

          if (fullCustomer != null && context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CustomerDetailsScreen(customer: fullCustomer),
              ),
            );
          }
        },
      ),
    );
  }
}
