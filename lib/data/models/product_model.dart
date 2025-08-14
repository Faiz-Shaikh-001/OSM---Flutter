// A simple model for our products
import 'package:osm/utils/product_type.dart';

class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final ProductType category; // Using the existing ProductType enum

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.category,
  });
}
