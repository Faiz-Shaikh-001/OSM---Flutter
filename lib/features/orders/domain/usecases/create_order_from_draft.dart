import 'package:flutter/material.dart';
import 'package:osm/core/either.dart';

import '../entities/order.dart';
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
      final order = Order.newOrder(
        createdAt: DateTime.now(),
        customerId: draft.customerId!,
        prescriptionId: draft.prescriptionId,
        storeLocationId: draft.storeLocationId!,
        items: draft.items,
        initialPayments: draft.payments,
      );

      final result = await repository.create(order);

      return await result.fold((failure) => Left(failure), (orderId) async {
        return await repository.getById(orderId);
      });
    } catch (e) {
      return Left(OrderStorageFailure('Failed to create order'));
    }
  }
}
