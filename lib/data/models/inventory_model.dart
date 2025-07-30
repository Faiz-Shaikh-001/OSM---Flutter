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
  final IsarLink<FrameModel> frame; // Initialized in constructor

  final IsarLink<LensModel> lens; // Initialized in constructor

  InventoryModel({
    required this.quantityOnHand,
    required this.lastRestockDate,
    required this.minStockLevel,
    IsarLink<FrameModel>? frame, // Add to constructor
    IsarLink<LensModel>? lens, // Add to constructor
  }) : frame = frame ?? IsarLink<FrameModel>(),
       lens = lens ?? IsarLink<LensModel>();

  InventoryModel copyWith({
    Id? id,
    int? quantityOnHand,
    DateTime? lastRestockDate,
    int? minStockLevel,
    IsarLink<FrameModel>? frame,
    IsarLink<LensModel>? lens,
  }) {
    return InventoryModel(
      quantityOnHand: quantityOnHand ?? this.quantityOnHand,
      lastRestockDate: lastRestockDate ?? this.lastRestockDate,
      minStockLevel: minStockLevel ?? this.minStockLevel,
      frame: frame ?? this.frame,
      lens: lens ?? this.lens,
    )..id = id ?? this.id;
  }
}
