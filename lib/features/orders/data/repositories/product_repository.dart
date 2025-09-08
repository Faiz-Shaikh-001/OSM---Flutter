import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:osm/features/inventory/data/models/inventory_model.dart';
import 'package:osm/features/inventory/data/models/frame_model.dart';
import 'package:osm/features/inventory/data/models/lens_model.dart';
import 'package:osm/features/inventory/data/models/product_model.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/core/utils/product_type.dart';

/// Mapper to convert Frame/Lens variants into generic Product objects
class ProductMapper {
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

/// Repository that exposes Products to the app (UI/ViewModels)
class ProductRepository {
  final IsarService _isarService;

  ProductRepository(this._isarService);

  /// Get all products (flattened from inventory → frame/lens variants)
  Future<List<Product>> getAllProducts() async {
    try {
      final isar = await _isarService.db;
      final allInventory = await isar.inventoryModels.where().findAll();

      final products = <Product>[];
      for (final inventory in allInventory) {
        products.addAll(await ProductMapper.fromInventory(inventory));
      }
      return products;
    } catch (e) {
      debugPrint("Error getting all products: $e");
      rethrow;
    }
  }

  /// Get a single product by its [id] (productCode)
  Future<Product?> getProductById(String id) async {
    final allProducts = await getAllProducts();
    try {
      return allProducts.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Search products by name
  Future<List<Product>> searchProducts(String query) async {
    final allProducts = await getAllProducts();
    return allProducts
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  /// Decrement stock when a product is sold
  Future<void> decrementStock(Product product) async {
    try {
      final isar = await _isarService.db;

      await isar.writeTxn(() async {
        final inventory = await isar.inventoryModels
            .where()
            .findFirst(); // TODO: link properly using product.id → frame/lens

        if (inventory == null) return;

        if (product.category == ProductType.frame &&
            inventory.frame.value != null) {
          final frame = inventory.frame.value!;
          final variant = frame.variants.firstWhere(
            (v) => v.productCode == product.id,
            orElse: () => throw Exception("Variant not found"),
          );

          //   if (variant.quantity != null && variant.quantity! > 0) {
          //     variant.quantity = variant.quantity! - 1;
          //     await isar.frameModels.put(frame);
          //   }
          // } else if (product.category == ProductType.lens &&
          //     inventory.lens.value != null) {
          //   final lens = inventory.lens.value!;
          //   final variant = lens.variants.firstWhere(
          //     (v) => v.productCode == product.id,
          //     orElse: () => throw Exception("Variant not found"),
          //   );

          //   if (variant.quantity != null && variant.quantity! > 0) {
          //     variant.quantity = variant.quantity! - 1;
          //     await isar.lensModels.put(lens);
          //   }
        }
      });
    } catch (e) {
      debugPrint("Error decrementing stock: $e");
      rethrow;
    }
  }
}
