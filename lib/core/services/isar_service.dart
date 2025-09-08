import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:osm/features/customer/data/customer_model.dart';
import 'package:osm/features/doctors/data/models/doctor_model.dart';
import 'package:osm/features/inventory/data/models/frame_model.dart';
import 'package:osm/features/inventory/data/models/inventory_model.dart';
import 'package:osm/features/inventory/data/models/lens_model.dart';
import 'package:osm/features/orders/data/models/order_item_model.dart';
import 'package:osm/features/orders/data/models/order_model.dart';
import 'package:osm/features/orders/data/models/payment_model.dart';
import 'package:osm/features/prescription/data/models/prescription_model.dart';
import 'package:osm/features/inventory/data/models/store_location_model.dart';

class IsarService {
  late Future<Isar> db;

  static final IsarService _instance = IsarService._internal();

  factory IsarService() {
    return _instance;
  }

  // Initializes database future in the private constructor
  IsarService._internal() {
    db = openIsar();
  }

  Future<Isar> openIsar() async {
    if (Isar.instanceNames.isNotEmpty) {
      return Isar.getInstance()!;
    }

    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [
        CustomerModelSchema,
        DoctorModelSchema,
        FrameModelSchema,
        LensModelSchema,
        PrescriptionModelSchema,
        OrderModelSchema,
        OrderItemModelSchema,
        PaymentModelSchema,
        StoreLocationModelSchema,
        InventoryModelSchema,
      ],
      directory: dir.path,
      inspector: true,
    );
    debugPrint('Isar database opened successfully at: ${dir.path}');
    return isar;
  }

  // Methods here to get specific collections
  Future<IsarCollection<CustomerModel>> getCustomers() async {
    final isar = await db;
    return isar.customerModels;
  }

  Future<IsarCollection<DoctorModel>> getDoctors() async {
    final isar = await db;
    return isar.doctorModels;
  }

  // Add getters for other collections as needed
  Future<IsarCollection<PrescriptionModel>> getPrescriptions() async {
    final isar = await db;
    return isar.prescriptionModels;
  }

  Future<IsarCollection<OrderModel>> getOrders() async {
    final isar = await db;
    return isar.orderModels;
  }

  Future<IsarCollection<OrderItemModel>> getOrderItems() async {
    final isar = await db;
    return isar.orderItemModels;
  }

  Future<IsarCollection<PaymentModel>> getPayments() async {
    final isar = await db;
    return isar.paymentModels;
  }

  Future<IsarCollection<StoreLocationModel>> getStoreLocations() async {
    final isar = await db;
    return isar.storeLocationModels;
  }

  Future<IsarCollection<InventoryModel>> getInventory() async {
    final isar = await db;
    return isar.inventoryModels;
  }

  Future<IsarCollection<FrameModel>> getFrames() async {
    final isar = await db;
    return isar.frameModels;
  }

  Future<IsarCollection<LensModel>> getLenses() async {
    final isar = await db;
    return isar.lensModels;
  }

  // Method to close the Isar database (optional, usually done on app shutdown or hot restart)
  Future<void> closeDb() async {
    final isar = await db;
    await isar.close(
      deleteFromDisk: false,
    ); // Set to true if you want to delete data on close
    debugPrint('Isar database closed.');
  }
}
