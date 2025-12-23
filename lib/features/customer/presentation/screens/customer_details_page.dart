import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/customer/data/repositories/customer_repository_impl.dart';
import 'package:osm/features/customer/domain/usecases/delete_customer.dart';
import 'package:osm/features/customer/domain/usecases/get_customer_details.dart';
import 'package:osm/features/customer/presentation/bloc/customer_details/customer_details_bloc.dart';
import 'package:osm/features/customer/presentation/screens/customer_details_screen.dart';
import 'package:osm/features/orders/data/repositories/order_repository_impl.dart';
import 'package:osm/features/prescription/data/repositories/prescription_repository.dart';

class CustomerDetailsPage extends StatelessWidget {
  final CustomerId customerId;
  const CustomerDetailsPage({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final customerRepo = context.read<CustomerRepositoryImpl>();
        final orderRepo = context.read<OrderRepositoryImpl>();
        final prescriptionRepo = context.read<PrescriptionRepositoryImpl>();

        return CustomerDetailsBloc(
          getCustomerDetails: GetCustomerDetails(
            customerRepo,
            orderRepo,
            prescriptionRepo,
          ),
          deleteCustomer: DeleteCustomer(customerRepo),
        );
      },
      child: CustomerDetailsScreen(customerId: customerId),
    );
  }
}
