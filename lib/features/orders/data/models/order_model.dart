import 'package:isar/isar.dart';

import 'package:osm/features/customer/data/customer_model.dart';
import 'package:osm/features/orders/data/models/order_item_model.dart';
import 'package:osm/features/orders/data/models/payment_model.dart';
import 'package:osm/features/prescription/data/models/prescription_model.dart';
import 'package:osm/features/inventory/data/models/store_location_model.dart';

part 'order_model.g.dart';

@collection
class OrderModel {
  Id id = Isar.autoIncrement;

  final DateTime orderDate;
  final double totalAmount;

  @Enumerated(EnumType.name)
  final String status;

  // ---- RelationShips ----
  final IsarLink<CustomerModel> customer;
  final IsarLink<PrescriptionModel> prescription;

  @Backlink(to: 'order')
  final IsarLinks<OrderItemModel> items;
  @Backlink(to: 'order')
  final IsarLinks<PaymentModel> payments;

  final IsarLink<StoreLocationModel> storeLocation;

  OrderModel({
    required this.orderDate,
    required this.totalAmount,
    required this.status,
    IsarLink<CustomerModel>? customer,
    IsarLink<PrescriptionModel>? prescription,
    IsarLinks<OrderItemModel>? items,
    IsarLinks<PaymentModel>? payments,
    IsarLink<StoreLocationModel>? storeLocation,
  }) : customer = customer ?? IsarLink<CustomerModel>(),
       prescription = prescription ?? IsarLink<PrescriptionModel>(),
       payments = payments ?? IsarLinks<PaymentModel>(),
       items = items ?? IsarLinks<OrderItemModel>(),
       storeLocation = storeLocation ?? IsarLink<StoreLocationModel>();

  OrderModel copyWith({
    Id? id,
    DateTime? orderDate,
    double? totalAmount,
    String? status,
    IsarLink<CustomerModel>? customer,
    IsarLinks<OrderItemModel>? items,
    IsarLink<PrescriptionModel>? prescription,
    IsarLinks<PaymentModel>? payments,
    IsarLink<StoreLocationModel>? storeLocation,
  }) {
    return OrderModel(
      orderDate: orderDate ?? this.orderDate,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      customer: customer ?? this.customer,
      items: items ?? this.items,
      payments: payments ?? this.payments,
      prescription: prescription ?? this.prescription,
      storeLocation: storeLocation ?? this.storeLocation,
    )..id = id ?? this.id;
  }
}
