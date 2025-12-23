import 'package:osm/features/orders/data/enums/order_status_model.dart';
import 'package:osm/features/orders/data/enums/payment_method_model.dart';
import 'package:osm/features/orders/data/enums/payment_status_model.dart';
import 'package:osm/features/orders/domain/entities/order_enums.dart';
import 'package:osm/features/orders/domain/entities/payment_enums.dart';

class OrderEnumsMapper {
  static OrderStatusModel toOrderStatusModel(OrderStatus status) {
    switch (status) {
      case OrderStatus.draft:
        return OrderStatusModel.draft;
      case OrderStatus.pendingPayment:
        return OrderStatusModel.pendingPayment;
      case OrderStatus.completed:
        return OrderStatusModel.completed;
      case OrderStatus.cancelled:
        return OrderStatusModel.cancelled;
    }
  }

  static OrderStatus toOrderStatus(OrderStatusModel model) {
    switch (model) {
      case OrderStatusModel.draft:
        return OrderStatus.draft;
      case OrderStatusModel.pendingPayment:
        return OrderStatus.pendingPayment;
      case OrderStatusModel.completed:
        return OrderStatus.completed;
      case OrderStatusModel.cancelled:
        return OrderStatus.cancelled;
    }
  }

  static PaymentMethodModel toPaymentMethodModel(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return PaymentMethodModel.cash;
      case PaymentMethod.card:
        return PaymentMethodModel.card;
      case PaymentMethod.upi:
        return PaymentMethodModel.upi;
      case PaymentMethod.bankTransfer:
        return PaymentMethodModel.bankTransfer;
    }
  }

  static PaymentMethod toPaymentMethod(PaymentMethodModel model) {
    switch (model) {
      case PaymentMethodModel.cash:
        return PaymentMethod.cash;
      case PaymentMethodModel.card:
        return PaymentMethod.card;
      case PaymentMethodModel.upi:
        return PaymentMethod.upi;
      case PaymentMethodModel.bankTransfer:
        return PaymentMethod.bankTransfer;
    }
  }

  static PaymentStatusModel toPaymentStatusModel(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.pending:
        return PaymentStatusModel.pending;
      case PaymentStatus.completed:
        return PaymentStatusModel.completed;
      case PaymentStatus.failed:
        return PaymentStatusModel.failed;
      case PaymentStatus.refunded:
        return PaymentStatusModel.refunded;
    }
  }

  static PaymentStatus toPaymentStatus(PaymentStatusModel model) {
    switch (model) {
      case PaymentStatusModel.pending:
        return PaymentStatus.pending;
      case PaymentStatusModel.completed:
        return PaymentStatus.completed;
      case PaymentStatusModel.failed:
        return PaymentStatus.failed;
      case PaymentStatusModel.refunded:
        return PaymentStatus.refunded;
    }
  }
}