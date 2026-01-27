import 'package:osm/core/value_objects/money.dart';
import 'package:osm/features/orders/domain/entities/order_item_type.dart';

enum ProductSearchType { frame, lens, accessory }

extension ProductSearchTypeX on ProductSearchType {
  OrderItemType toOrderItemType() {
    switch (this) {
      case ProductSearchType.frame:
        return OrderItemType.frame;
      case ProductSearchType.lens:
        return OrderItemType.lens;
      case ProductSearchType.accessory:
        return OrderItemType.accessory;
    }
  }
}

class ProductSearchResult {
  final String id;
  final String name;
  final String code;
  final ProductSearchType type;
  final Money price;
  final Object raw;

  const ProductSearchResult({
    required this.id,
    required this.name,
    required this.code,
    required this.type,
    required this.price,
    required this.raw,
  });
}

