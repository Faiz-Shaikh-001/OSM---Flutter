import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/customer/domain/dto/customer_details.dart';
import 'package:osm/features/customer/domain/failures/customer_failure.dart';
import 'package:osm/features/customer/domain/repositories/customer_repository.dart';
import 'package:osm/features/orders/domain/entities/order.dart';
import 'package:osm/features/orders/domain/repositories/order_repository.dart';
import 'package:osm/features/prescription/domain/entities/prescription.dart';
import 'package:osm/features/prescription/domain/repositories/prescription_repository.dart';

class GetCustomerDetails {
  final CustomerRepository customerRepository;
  final OrderRepository orderRepository;
  final PrescriptionRepository prescriptionRepository;

  GetCustomerDetails(
    this.customerRepository,
    this.orderRepository,
    this.prescriptionRepository,
  );

  Future<Either<CustomerFailure, CustomerDetails>> call(CustomerId customerId) async {
    final customerResult = await customerRepository.getById(customerId);

    return customerResult.fold(
      (failure) => Left(failure),
      (customer) async {
        final ordersResult =
            await orderRepository.getByCustomer(customerId);

        final prescriptionsResult =
            await prescriptionRepository.getByCustomer(customerId);

        final orders = ordersResult.fold(
          (_) => <Order>[],
          (data) => data,
        );

        final prescriptions = prescriptionsResult.fold(
          (_) => <Prescription>[],
          (data) => data,
        );

        return Right(
          CustomerDetails(
            customer: customer,
            orders: orders,
            prescriptions: prescriptions,
          ),
        );
      },
    );
  }
}