import 'package:osm/features/orders/domain/entities/order.dart';

abstract class OrderSearchSource {
  Future<List<Order>> search(String query);
}