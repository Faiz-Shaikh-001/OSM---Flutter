import 'package:flutter/material.dart';
import 'package:osm/features/customer/data/customer_model.dart';
import 'package:osm/features/customer/presentation/screens/add_new_customer_form.dart';
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
            onPressed: () {
              Navigator.of(context).push<CustomerModel>(
                MaterialPageRoute(
                  builder: (context) => const AddNewCustomerForm(),
                ),
              );
            },
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
