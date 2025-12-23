import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/orders/data/mappers/order_mapper.dart';
import 'package:osm/features/orders/data/mappers/order_status_mapper.dart';
import 'package:osm/features/orders/data/mappers/payment_mapper.dart';
import 'package:osm/features/orders/data/models/order/order_model.dart';
import 'package:osm/features/orders/data/repositories/order_local_repository.dart';
import 'package:osm/features/orders/data/repositories/payment_local_repository.dart';
import 'package:osm/features/orders/domain/entities/order.dart';
import 'package:osm/features/orders/domain/entities/order_enums.dart';
import 'package:osm/features/orders/domain/entities/payment.dart';
import 'package:osm/features/orders/domain/failures/order_failure.dart';
import 'package:osm/features/orders/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderLocalRepository orderLocal;
  final PaymentLocalRepository paymentLocal;

  OrderRepositoryImpl({required this.orderLocal, required this.paymentLocal});

  @override
  Future<Either<OrderFailure, Order>> getById(OrderId id) async {
    try {
      final model = await orderLocal.getById(int.parse(id.value));
      if (model == null) {
        return const Left(OrderNotFoundFailure());
      }

      await _loadRelations(model);
      return Right(
        OrderMapper.toEntity(
          model,
          items: model.items.toList(),
          payments: model.payments.toList(),
        ),
      );
    } catch (e) {
      return Left(OrderStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<OrderFailure, List<Order>>> getAll() async {
    try {
      final models = await orderLocal.getAll();

      for (final m in models) {
        await _loadRelations(m);
      }

      return Right(
        models
            .map(
              (m) => OrderMapper.toEntity(
                m,
                items: m.items.toList(),
                payments: m.payments.toList(),
              ),
            )
            .toList(),
      );
    } catch (e) {
      return Left(OrderStorageFailure(e.toString()));
    }
  }

  @override
  Stream<Either<OrderFailure, List<Order>>> watchAll() async* {
    yield* orderLocal.watchAll().asyncMap((models) async {
      try {
        for (final m in models) {
          await _loadRelations(m);
        }
        return Right(
          models
              .map(
                (m) => OrderMapper.toEntity(
                  m,
                  items: m.items.toList(),
                  payments: m.payments.toList(),
                ),
              )
              .toList(),
        );
      } catch (e) {
        return Left(OrderStorageFailure(e.toString()));
      }
    });
  }

  @override
  Future<Either<OrderFailure, OrderId>> create(Order order) async {
    try {
      final model = OrderMapper.toModel(order);

      final id = await orderLocal.insert(model);
      return Right(OrderId(id.toString()));
    } catch (e) {
      return Left(OrderStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<OrderFailure, Order>> updateStatus(
    OrderId orderId,
    OrderStatus status,
  ) async {
    try {
      final existing = await orderLocal.getById(int.parse(orderId.value));
      if (existing == null) {
        return const Left(OrderNotFoundFailure());
      }

      final updated = OrderModel(
        createdAt: existing.createdAt,
        status: OrderStatusMapper.toModel(status),
        customer: existing.customer,
        prescription: existing.prescription,
        storeLocation: existing.storeLocation,
        items: existing.items,
        payments: existing.payments,
      )..id = existing.id;

      await orderLocal.save(updated);

      await _loadRelations(updated);
      return Right(
        OrderMapper.toEntity(
          updated,
          items: updated.items.toList(),
          payments: updated.payments.toList(),
        ),
      );
    } catch (e) {
      return Left(OrderStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<OrderFailure, Order>> addPayment(
    OrderId orderId,
    Payment payment,
  ) async {
    try {
      final order = await orderLocal.getById(int.parse(orderId.value));
      if (order == null) {
        return const Left(OrderNotFoundFailure());
      }

      final paymentModel = PaymentMapper.toModel(payment);

      await paymentLocal.insert(payment: paymentModel, order: order);

      await _loadRelations(order);

      return Right(
        OrderMapper.toEntity(
          order,
          items: order.items.toList(),
          payments: order.payments.toList(),
        ),
      );
    } catch (e) {
      return Left(PaymentFailure(e.toString()));
    }
  }

  Future<void> _loadRelations(OrderModel order) async {
    await order.customer.load();
    await order.prescription.load();
    await order.storeLocation.load();
    await order.items.load();
    await order.payments.load();
  }

  @override
  Future<Either<OrderFailure, List<Order>>> getByCustomer(
    CustomerId customerId,
  ) async {
    try {
      final models = await orderLocal.getByCustomer(
        int.parse(customerId.value),
      );

      for (final model in models) {
        await _loadRelations(model);
      }

      final orders = models
          .map(
            (model) => OrderMapper.toEntity(
              model,
              items: model.items.toList(),
              payments: model.payments.toList(),
            ),
          )
          .toList();

      return Right(orders);
    } catch (e) {
      return Left(OrderStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<OrderFailure, Order>> delete(OrderId orderId) async {
    try {
      final id = int.parse(orderId.value);

      final model = await orderLocal.getById(id);
      if (model == null) {
        return const Left(OrderNotFoundFailure());
      }

      await _loadRelations(model);

      final deletedOrder = OrderMapper.toEntity(
        model,
        items: model.items.toList(),
        payments: model.payments.toList(),
      );

      await orderLocal.delete(id);

      return Right(deletedOrder);
    } catch (e) {
      return Left(OrderStorageFailure(e.toString()));
    }
  }
}
