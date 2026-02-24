import 'package:isar/isar.dart';

import 'package:osm/features/customer/data/models/customer_model.dart';
import 'package:osm/features/orders/data/enums/order_status_model.dart';
import 'package:osm/features/orders/data/models/order_item/order_item_model.dart';
import 'package:osm/features/orders/data/models/payment/payment_model.dart';
import 'package:osm/features/prescription/data/models/prescription_model.dart';
import 'package:osm/features/store/data/model/store_location_model.dart';

part 'order_model.g.dart';

@collection
class OrderModel {
  Id id = Isar.autoIncrement;

  final DateTime createdAt;
  DateTime? completedAt;

  @Enumerated(EnumType.name)
  OrderStatusModel status;

  // ---- Relations ----
  final IsarLink<CustomerModel> customer;
  final IsarLink<PrescriptionModel> prescription;

  @Backlink(to: 'order')
  final IsarLinks<OrderItemModel> items;

  @Backlink(to: 'order')
  final IsarLinks<PaymentModel> payments;

  final IsarLink<StoreLocationModel> storeLocation;

  OrderModel({
    required this.createdAt,
    this.completedAt,
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
}
