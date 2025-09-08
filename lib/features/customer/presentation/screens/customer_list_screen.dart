import 'package:flutter/material.dart';
import 'package:osm/features/customer/data/customer_model.dart';
import 'package:osm/features/customer/presentation/widgets/customer_list.dart';
import 'package:osm/features/customer/presentation/widgets/error_message.dart';
import 'package:osm/features/customer/presentation/widgets/loading_indicator.dart';
import 'package:osm/features/customer/viewmodel/customer_viewmodel.dart';
import 'package:provider/provider.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CustomerViewModel>().loadCustomers();
    });
  }

  // Add a sample customer to customer list screen
  Future<void> _addSampleCustomer() async {
    final newCustomer = CustomerModel(
      firstName: 'Sample',
      lastName: 'User ${DateTime.now().second}',
      city: 'Optics City',
      primaryPhoneNumber: '123-456-${DateTime.now().millisecond}',
      gender: "Male",
      age: 30,
      profileImageUrl: "https://placehold.co/100x100/ng?text=Customer",
    );

    await context.read<CustomerViewModel>().addCustomer(newCustomer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
        actions: [
          IconButton(
            onPressed: () => context.read<CustomerViewModel>().loadCustomers(),
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: _addSampleCustomer,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<CustomerViewModel>(
        builder: (context, customerViewModel, child) {
          if (customerViewModel.isLoading) {
            return const LoadingIndicator();
          } else if (customerViewModel.errorMessage != null) {
            return ErrorMessage(message: customerViewModel.errorMessage!);
          } else {
            return CustomerList(customers: customerViewModel.customers);
          }
        },
      ),
    );
  }
}
