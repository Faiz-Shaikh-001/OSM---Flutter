import 'package:osm/core/services/isar_service.dart';
import 'package:osm/features/dashboard/data/sources/order_search_source.dart';
import 'package:osm/features/orders/data/mappers/order_mapper.dart';
import 'package:osm/features/orders/data/repositories/order_local_repository.dart';
import 'package:osm/features/orders/domain/entities/order.dart';

class OrderSearchSourceImpl implements OrderSearchSource {
  final IsarService _isarService;
  final OrderLocalRepository _localRepository;

  OrderSearchSourceImpl(this._isarService, this._localRepository);

  @override
  Future<List<Order>> search(String query) async {
    final isar = await _isarService.db;
    final models = await _localRepository.searchByCustomerOrOrderId(query, isar);

    final orders = <Order>[];

    for (final model in models) {
      await model.customer.load();
      await model.items.load();
      await model.payments.load();

      orders.add(
        OrderMapper.toEntity(
          model,
          items: model.items.toList(),
          payments: model.payments.toList(),
        ),
      );
    }

    return orders;
  }
}
