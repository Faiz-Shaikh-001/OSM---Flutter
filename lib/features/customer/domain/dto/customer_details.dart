import 'package:osm/features/orders/domain/entities/order.dart';
import 'package:osm/features/prescription/domain/entities/prescription.dart';

import '../entities/customer.dart';

class CustomerDetails {
  final Customer customer;
  final List<Order> orders;
  final List<Prescription> prescriptions;

  const CustomerDetails({
    required this.customer,
    required this.orders,
    required this.prescriptions,
  });
}
