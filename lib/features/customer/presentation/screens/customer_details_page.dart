import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/customer/domain/repositories/customer_repository.dart';
import 'package:osm/features/customer/domain/usecases/delete_customer.dart';
import 'package:osm/features/customer/domain/usecases/get_customer_details.dart';
import 'package:osm/features/customer/presentation/bloc/customer_details/customer_details_bloc.dart';
import 'package:osm/features/customer/presentation/screens/customer_details_screen.dart';
import 'package:osm/features/orders/domain/repositories/order_repository.dart';
import 'package:osm/features/prescription/domain/repositories/prescription_repository.dart';
import 'package:osm/features/prescription/domain/usecases/get_prescription_history.dart';
import 'package:osm/features/prescription/presentation/bloc/prescription_timeline/bloc/prescription_timeline_bloc.dart';

class CustomerDetailsPage extends StatelessWidget {
  final CustomerId customerId;
  const CustomerDetailsPage({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    final customerRepo = context.read<CustomerRepository>();
    final orderRepo = context.read<OrderRepository>();
    final prescriptionRepo = context.read<PrescriptionRepository>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CustomerDetailsBloc(
            getCustomerDetails: GetCustomerDetails(
              customerRepo,
              orderRepo,
              prescriptionRepo,
            ),
            deleteCustomer: DeleteCustomer(customerRepo),
          ),
        ),

        BlocProvider(
          create: (_) => PrescriptionTimelineBloc(
            getPrescriptionHistory: context.read<GetPrescriptionHistory>(),
          )..add(LoadPrescriptionTimeline(customerId)),
        ),
      ],
      child: CustomerDetailsScreen(customerId: customerId),
    );
  }
}
