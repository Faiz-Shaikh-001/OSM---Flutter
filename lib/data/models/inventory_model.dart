import 'package:isar/isar.dart';
import 'frame_model.dart';
import 'lens_model.dart';

part 'inventory_model.g.dart';

@Collection()
class InventoryModel {
  Id id = Isar.autoIncrement;

  @Index()
  final int quantityOnHand;
  final DateTime lastRestockDate;
  final int minStockLevel;

  // --- Relationships ---
  final frame = IsarLink<FrameModel>();

  final lens = IsarLink<LensModel>();

  InventoryModel({
    required this.quantityOnHand,
    required this.lastRestockDate,
    required this.minStockLevel,
  });

  InventoryModel copyWith({
    Id? id,
    int? quantityOnHand,
    DateTime? lastRestockDate,
    int? minStockLevel,
  }) {
    return InventoryModel(
      quantityOnHand: quantityOnHand ?? this.quantityOnHand,
      lastRestockDate: lastRestockDate ?? this.lastRestockDate,
      minStockLevel: minStockLevel ?? this.minStockLevel,
    )..id = id ?? this.id;
  }
}
