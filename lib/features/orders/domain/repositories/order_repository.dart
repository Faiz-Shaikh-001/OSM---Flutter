import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/core/value_objects/money.dart';
import 'package:osm/features/orders/domain/entities/order_enums.dart';
import 'package:osm/features/orders/domain/entities/payment.dart';
import 'package:osm/features/orders/domain/failures/order_failure.dart';
import '../entities/order.dart';

abstract class OrderRepository {
  Future<Either<OrderFailure, Order>> getById(OrderId id);

  Future<Either<OrderFailure, List<Order>>> getAll();

  Future<Either<OrderFailure, List<Order>>> getByCustomer(
    CustomerId customerId,
  );

  Stream<Either<OrderFailure, List<Order>>> watchAll();

  Future<Either<OrderFailure, OrderId>> create(Order order);

  Future<Either<OrderFailure, Order>> addPayment(
    OrderId orderId,
    Payment payment,
  );

  Future<Either<OrderFailure, void>> updateStatus(
    OrderId orderId,
    OrderStatus status,
  );

  Future<Either<OrderFailure, Order>> delete(OrderId orderId);

  Stream<Money> watchTodaysSale();

  Stream<int> watchActiveOrderCount();

  Stream<Money> watchPendingPayments();
}
