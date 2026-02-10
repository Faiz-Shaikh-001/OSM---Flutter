import 'package:osm/core/either.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/customer/data/models/customer_model.dart';
import 'package:osm/features/customer/data/repositories/customer_local_repository.dart';
import 'package:osm/features/orders/data/mappers/order_enums_mapper.dart';
import 'package:osm/features/orders/data/mappers/order_item_mapper.dart';
import 'package:osm/features/orders/data/mappers/order_mapper.dart';
import 'package:osm/features/orders/data/mappers/order_status_mapper.dart';
import 'package:osm/features/orders/data/mappers/payment_mapper.dart';
import 'package:osm/features/orders/data/models/order/order_model.dart';
import 'package:osm/features/orders/data/repositories/order_item_local_repository.dart';
import 'package:osm/features/orders/data/repositories/order_local_repository.dart';
import 'package:osm/features/orders/data/repositories/payment_local_repository.dart';
import 'package:osm/features/orders/domain/entities/order.dart';
import 'package:osm/features/orders/domain/entities/order_enums.dart';
import 'package:osm/features/orders/domain/entities/payment.dart';
import 'package:osm/features/orders/domain/failures/order_failure.dart';
import 'package:osm/features/orders/domain/repositories/order_repository.dart';
import 'package:osm/features/prescription/data/models/prescription_model.dart';
import 'package:osm/features/prescription/data/repositories/prescription_local_repository.dart';
import 'package:osm/features/store/data/repositories/store_location_local_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final IsarService _isarService;
  final OrderLocalRepository orderLocal;
  final PaymentLocalRepository paymentLocal;
  final CustomerLocalRepository customerLocal;
  final StoreLocationLocalRepository storeLocal;
  final PrescriptionLocalRepository prescriptionLocal;
  final OrderItemLocalRepository orderItemLocal;

  OrderRepositoryImpl(
    this._isarService,
    this.orderLocal,
    this.paymentLocal,
    this.customerLocal,
    this.storeLocal,
    this.prescriptionLocal,
    this.orderItemLocal,
  );
  @override
  Future<Either<OrderFailure, Order>> getById(OrderId id) async {
    try {
      final isar = await _isarService.db;
      final model = await orderLocal.getById(int.parse(id.value), isar);
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
      final isar = await _isarService.db;
      final models = await orderLocal.getAll(isar);

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
    final isar = await _isarService.db;
    yield* orderLocal.watchAll(isar).asyncMap((models) async {
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
      final isar = await _isarService.db;
      final model = OrderMapper.toModel(order);

      final customer = await customerLocal.getById(
        int.parse(order.customerId.value),
        isar,
      );

      if (customer == null) {
        return Left(OrderStorageFailure("Customer not found to attach order"));
      }

      final store = await storeLocal.getById(
        int.parse(order.storeLocationId.value),
        isar,
      );

      if (store == null) {
        return Left(OrderStorageFailure("Store not found to attach order"));
      }

      PrescriptionModel? prescription;
      if (order.prescriptionId != null) {
        prescription = await prescriptionLocal.getById(
          int.parse(order.prescriptionId!.value),
          isar: isar,
        );

        if (prescription == null) {
          return Left(
            OrderStorageFailure("Prescription not found to attach order"),
          );
        }
      }

      final items = order.items.map(OrderItemMapper.toModel).toList();

      final payments = order.payments.map(PaymentMapper.toModel).toList();

      final id = await isar.writeTxn(() async {
        final id = await orderLocal.insert(
          model,
          customer,
          prescription,
          items,
          payments,
          store,
          isar,
        );

        await isar.customerModels.put(customer);

        return id;
      });

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
      final isar = await _isarService.db;
      final existing = await orderLocal.getById(int.parse(orderId.value), isar);
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

      await orderLocal.save(updated, isar);

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
      final isar = await _isarService.db;
      final orderModel = await orderLocal.getById(
        int.parse(orderId.value),
        isar,
      );
      
      if (orderModel == null) {
        return const Left(OrderNotFoundFailure());
      }

      await _loadRelations(orderModel);

      final orderEntity = OrderMapper.toEntity(
        orderModel,
        items: orderModel.items.toList(),
        payments: orderModel.payments.toList(),
      );

      final updatedOrderEntity = orderEntity.addPayment(payment);

      await isar.writeTxn(() async {
        final newPaymentModel = PaymentMapper.toModel(payment);
        await paymentLocal.insert(
          payment: newPaymentModel,
          order: orderModel,
          isar: isar,
        );

        orderModel.status = OrderEnumsMapper.toOrderStatusModel(
          updatedOrderEntity.status,
        );

        orderModel.completedAt = updatedOrderEntity.completedAt;

        await orderLocal.save(orderModel, isar);
      });

      return Right(updatedOrderEntity);
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
      final isar = await _isarService.db;
      final models = await orderLocal.getByCustomer(
        int.parse(customerId.value),
        isar,
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
      final isar = await _isarService.db;
      final id = int.parse(orderId.value);

      final model = await orderLocal.getById(id, isar);
      if (model == null) {
        return const Left(OrderNotFoundFailure());
      }

      await _loadRelations(model);

      final deletedOrder = OrderMapper.toEntity(
        model,
        items: model.items.toList(),
        payments: model.payments.toList(),
      );

      await orderLocal.delete(id, isar);

      return Right(deletedOrder);
    } catch (e) {
      return Left(OrderStorageFailure(e.toString()));
    }
  }
}
