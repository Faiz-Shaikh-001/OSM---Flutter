import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:osm/data/models/customer_model.dart';
import 'package:osm/viewmodels/customer_viewmodel.dart'; // Import your ViewModel

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  @override
  void initState() {
    super.initState();
    // When the screen initializes, tell the ViewModel to load customers
    // Using context.read here because we don't need to rebuild the widget
    // just when the ViewModel itself is created.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CustomerViewModel>().loadCustomers();
    });
  }

  // Method to add a new sample customer
  Future<void> _addSampleCustomer() async {
    final newCustomer = CustomerModel(
      firstName: 'Sample',
      lastName: 'User ${DateTime.now().second}',
      city: 'Optics City',
      primaryPhoneNumber: '123-456-${DateTime.now().millisecond}',
      gender: 'Male',
      age: 30,
      profileImageUrl: 'https://placehold.co/100x100/png?text=Customer',
    );

    // Call the addCustomer method on the ViewModel
    await context.read<CustomerViewModel>().addCustomer(newCustomer);
  }

  @override
  Widget build(BuildContext context) {
    // Use Consumer or context.watch to listen for changes in CustomerViewModel
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                context.read<CustomerViewModel>().loadCustomers(), // Refresh
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addSampleCustomer, // Add new customer
          ),
        ],
      ),
      body: Consumer<CustomerViewModel>(
        // Listen to CustomerViewModel
        builder: (context, customerViewModel, child) {
          if (customerViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (customerViewModel.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error: ${customerViewModel.errorMessage}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            );
          } else if (customerViewModel.customers.isEmpty) {
            return const Center(child: Text('No customers found. Add some!'));
          } else {
            final customers = customerViewModel.customers;
            return ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customer = customers[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(customer.profileImageUrl),
                      onBackgroundImageError: (exception, stackTrace) {
                        print('Error loading image: $exception');
                      },
                    ),
                    title: Text('${customer.firstName} ${customer.lastName}'),
                    subtitle: Text(
                      'City: ${customer.city} | Phone: ${customer.primaryPhoneNumber}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await customerViewModel.deleteCustomer(customer.id);
                      },
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Tapped on ${customer.firstName}'),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
