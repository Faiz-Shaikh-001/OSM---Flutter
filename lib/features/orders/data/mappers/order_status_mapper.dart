import '../../domain/entities/order_enums.dart';
import '../enums/order_status_model.dart';

class OrderStatusMapper {
  static OrderStatusModel toModel(OrderStatus status) {
    switch (status) {
      case OrderStatus.pendingPayment:
        return OrderStatusModel.pendingPayment;
      case OrderStatus.completed:
        return OrderStatusModel.completed;
      case OrderStatus.cancelled:
        return OrderStatusModel.cancelled;
      case OrderStatus.draft:
        return OrderStatusModel.draft;
    }
  }

  static OrderStatus toDomain(OrderStatusModel model) {
    switch (model) {
      case OrderStatusModel.pendingPayment:
        return OrderStatus.pendingPayment;
      case OrderStatusModel.completed:
        return OrderStatus.completed;
      case OrderStatusModel.cancelled:
        return OrderStatus.cancelled;
      case OrderStatusModel.draft:
      return OrderStatus.draft;
    }
  }
}
