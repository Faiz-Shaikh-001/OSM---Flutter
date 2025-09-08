import 'package:osm/features/inventory/data/models/inventory_model.dart';
import 'package:osm/features/inventory/data/models/frame_model.dart';
import 'package:osm/features/inventory/data/models/lens_model.dart';
import 'package:osm/core/utils/product_type.dart';
import 'package:osm/features/inventory/data/models/product_model.dart';

class ProductMapper {
  /// Converts a [FrameVariant] into a [Product]
  static Product fromFrame(FrameModel frame, FrameVariant variant) {
    return Product(
      id: variant.productCode ?? frame.modelProductCode,
      name:
          "${frame.name} (${variant.size ?? ''}${variant.colorName != null ? ' - ${variant.colorName}' : ''})",
      imageUrl: variant.imageUrls.isNotEmpty ? variant.imageUrls.first : "",
      price: variant.salesPrice ?? 0.0,
      category: ProductType.frame,
    );
  }

  /// Converts a [LensVariant] into a [Product]
  static Product fromLens(LensModel lens, LensVariant variant) {
    return Product(
      id: variant.productCode ?? lens.modelProductCode,
      name: "${lens.productName} (${lens.lensType.name})",
      imageUrl: variant.imageUrls?.isNotEmpty == true
          ? variant.imageUrls!.first
          : "",
      price: variant.salesPrice ?? 0.0,
      category: ProductType.lens,
    );
  }

  /// Converts an [InventoryModel] (frame OR lens) into a list of [Product]s
  static Future<List<Product>> fromInventory(InventoryModel inventory) async {
    final products = <Product>[];

    if (inventory.frame.value != null) {
      final frame = inventory.frame.value!;
      for (final variant in frame.variants) {
        products.add(fromFrame(frame, variant));
      }
    }

    if (inventory.lens.value != null) {
      final lens = inventory.lens.value!;
      for (final variant in lens.variants) {
        products.add(fromLens(lens, variant));
      }
    }

    return products;
  }
}
