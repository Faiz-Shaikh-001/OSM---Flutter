import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/customer/presentation/bloc/customer/customer_bloc.dart';
import 'package:osm/features/customer/presentation/screens/add_new_customer_form.dart';
import 'package:osm/features/customer/presentation/widgets/customer_list.dart';
import 'package:osm/features/customer/presentation/widgets/error_message.dart';

class CustomerListScreen extends StatelessWidget {
  const CustomerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => context.read<CustomerBloc>()..add(const WatchCustomers()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Customers'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context.read<CustomerBloc>().add(const LoadCustomers());
              },
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                final customer = await showModalBottomSheet<Customer>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => const AddNewCustomerForm(),
                );

                if (customer != null && context.mounted) {
                  context.read<CustomerBloc>().add(AddCustomerEvent(customer));
                }
              },
            ),
          ],
        ),
        body: BlocListener<CustomerBloc, CustomerState>(
          listener: (context, state) {
            if (state is CustomerActionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }

            if (state is CustomerDeleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${state.customer.firstName} deleted',
                  ),
                  behavior: SnackBarBehavior.floating,
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      context
                          .read<CustomerBloc>()
                          .add(UndoDeleteCustomerEvent());
                    },
                  ),
                ),
              );
            }
          },
          child: BlocBuilder<CustomerBloc, CustomerState>(
            builder: (context, state) {
              if (state is CustomerLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is CustomerError) {
                return ErrorMessage(message: state.message);
              }

              if (state is CustomerLoaded) {
                return CustomerList(customers: state.customers);
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
