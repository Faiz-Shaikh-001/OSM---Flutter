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
    if (!draft.isComplete) {
      return const Left(OrderValidationFailure('Order draft is incomplete'));
    }

    try {
      final order = Order.newOrder(
        createdAt: DateTime.now(),
        status: OrderStatus.pendingPayment,
        customerId: draft.customerId!,
        items: draft.items,
        payments: draft.payment != null ? [draft.payment!] : [],
      );

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
