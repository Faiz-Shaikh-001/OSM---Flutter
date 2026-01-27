import 'package:osm/core/value_objects/money.dart';
import 'package:osm/features/orders/domain/entities/order_item_type.dart';

class SearchResultProduct {
  final String id;
  final String name;
  final String code;
  final Money price;
  final OrderItemType type;

  final bool? requiresPrescription;

  const SearchResultProduct({
    required this.id,
    required this.name,
    required this.code,
    required this.price,
    required this.type,
    this.requiresPrescription,
  });
}
