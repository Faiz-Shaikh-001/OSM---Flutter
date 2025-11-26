import 'package:isar/isar.dart';

part 'store_model.g.dart';

@Collection()
class Store {
  Id id = Isar.autoIncrement;

  final String name;
  final String address;
  final String city;
  final String phone;

  // --- NEW: Store-Specific Inventory Settings ---
  // We set default values so existing code doesn't break
  int stockThreshold;
  double taxRate;
  double discountRate;
  String invoiceFooterMessage;

  Store({
    required this.name,
    required this.address,
    required this.city,
    required this.phone,
    // Initialize defaults
    this.stockThreshold = 5,
    this.taxRate = 0.0,
    this.discountRate = 0.0,
    this.invoiceFooterMessage = '',
  });
}