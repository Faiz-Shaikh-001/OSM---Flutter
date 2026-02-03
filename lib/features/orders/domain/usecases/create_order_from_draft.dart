import 'package:flutter/material.dart';
import 'package:osm/core/either.dart';

import '../entities/order.dart';
import '../entities/order_enums.dart';
import '../failures/order_failure.dart';
import '../repositories/order_repository.dart';
import '../value_objects/order_draft.dart';

class CreateOrderFromDraft {
  final OrderRepository repository;

  CreateOrderFromDraft(this.repository);

  Future<Either<OrderFailure, Order>> call(OrderDraft draft) async {
    debugPrint(draft.isComplete.toString());

    if (!draft.isComplete) {
      return const Left(OrderValidationFailure('Order draft is incomplete'));
    }

    try {
      debugPrint("Order in create Order from draft");
      final status = draft.payments == null ? OrderStatus.pendingPayment : OrderStatus.completed;

      debugPrint("status: $status");
      final order = Order.newOrder(
        createdAt: DateTime.now(),
        status: status,
        customerId: draft.customerId!,
        prescriptionId: draft.prescriptionId,
        storeLocationId: draft.storeLocationId!,
        items: draft.items,
        payments: draft.payments ?? [],
      );

      debugPrint("Order created");

      final result = await repository.create(order);

      return await result.fold(
        (failure) => Left(failure),
        (orderId) => repository.getById(orderId),
      );
    } catch (e) {
      return Left(OrderStorageFailure('Failed to create order'));
    }
  }
}
