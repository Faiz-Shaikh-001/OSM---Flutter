import 'package:osm/features/orders/data/mappers/order_enums_mapper.dart';
import 'package:osm/features/orders/data/models/order_item/order_item_model.dart';
import 'package:osm/features/orders/data/models/payment/payment_model.dart';
import 'package:osm/features/orders/domain/entities/order_enums.dart';
import 'package:osm/core/value_objects/id.dart';

import '../../domain/entities/order.dart';

import '../models/order/order_model.dart';
import 'order_item_mapper.dart';
import 'payment_mapper.dart';

class OrderMapper {
  static Order toEntity(
    OrderModel model, {
    required List<OrderItemModel> items,
    required List<PaymentModel> payments,
  }) {
    return Order.rehydrate(
      id: OrderId(model.id.toString()),
      createdAt: model.createdAt,
      completedAt: model.completedAt,
      status: OrderEnumsMapper.toOrderStatus(model.status),
      customerId: CustomerId(model.customer.value?.id.toString() ?? '0'),
      prescriptionId: PrescriptionId(model.prescription.value?.id.toString() ?? '0'),
      storeLocationId: StoreLocationId(model.storeLocation.value?.id.toString() ?? '0'),

      items: items.map(OrderItemMapper.toEntity).toList(),
      payments: payments.map(PaymentMapper.toEntity).toList(),
    );
  }

  static OrderModel toModel(Order order) {
    final model = OrderModel(
      createdAt: order.createdAt,
      completedAt: order.status == OrderStatus.completed
          ? DateTime.now()
          : null,
      status: OrderEnumsMapper.toOrderStatusModel(order.status),
    );

    return model;
  }
}
