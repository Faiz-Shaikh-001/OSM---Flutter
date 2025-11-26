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
import 'package:osm/features/orders/data/models/store_model.dart';
import 'package:osm/features/settings/staff/models/staff_model.dart';
import 'package:osm/features/settings/profile/models/profile_model.dart';

class IsarService {
  late Future<Isar> db;

  static final IsarService _instance = IsarService._internal();

  factory IsarService() {
    return _instance;
  }

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
        StoreSchema,
        StaffSchema,
        UserProfileSchema,
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

  // --- Getters ---
  
  Future<IsarCollection<Staff>> getStaff() async {
    final isar = await db;
    return isar.staffs;
  }

  Future<IsarCollection<Store>> getStores() async {
    final isar = await db;
    return isar.stores;
  }
  
  Future<IsarCollection<UserProfile>> getUserProfiles() async {
    final isar = await db;
    return isar.userProfiles;
  }

  Future<IsarCollection<CustomerModel>> getCustomers() async {
    final isar = await db;
    return isar.customerModels;
  }

  Future<IsarCollection<DoctorModel>> getDoctors() async {
    final isar = await db;
    return isar.doctorModels;
  }

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

  Future<void> closeDb() async {
    final isar = await db;
    await isar.close(
      deleteFromDisk: false,
    );
    debugPrint('Isar database closed.');
  }

  // --- NEW METHOD: Fixes the error in accounts_screen.dart ---
  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.clear();
    });
    debugPrint('Isar database cleared.');
  }
}