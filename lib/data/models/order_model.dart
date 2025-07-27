import 'package:isar/isar.dart';
import 'package:osm/data/models/customer_model.dart';
import 'package:osm/data/models/order_item_model.dart';
import 'package:osm/data/models/payment_model.dart';
import 'package:osm/data/models/prescription_model.dart';
import 'package:osm/data/models/store_location_model.dart';

part 'order_model.g.dart';

@collection
class OrderModel {
  Id id = Isar.autoIncrement;

  final DateTime orderDate;
  final double totalAmount;
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
       items = items ?? IsarLinks<OrderItemModel>(),
       payments = payments ?? IsarLinks<PaymentModel>(),
       storeLocation = storeLocation ?? IsarLink<StoreLocationModel>();

  OrderModel copyWith({
    Id? id,
    DateTime? orderDate,
    double? totalAmount,
    String? status,
    IsarLink<CustomerModel>? customer,
    IsarLink<PrescriptionModel>? prescription,
    IsarLinks<OrderItemModel>? items,
    IsarLinks<PaymentModel>? payments,
    IsarLink<StoreLocationModel>? storeLocation,
  }) {
    return OrderModel(
      orderDate: orderDate ?? this.orderDate,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
    )..id = id ?? this.id;
  }
}
