import 'package:flutter/material.dart'; // For debugPrint, Color
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/features/customer/data/customer_repository.dart';
import 'package:osm/features/doctors/data/repositories/doctor_repository.dart';
import 'package:osm/features/prescription/data/repositories/prescription_repository.dart';
import 'package:osm/features/inventory/data/repositories/store_location_repository.dart';
import 'package:osm/features/inventory/data/repositories/frame_repository.dart'; // New
import 'package:osm/features/inventory/data/repositories/lens_repository.dart'; // New
import 'package:osm/features/inventory/data/repositories/inventory_repository.dart'; // New
import 'package:osm/features/orders/data/repositories/order_repository.dart'; // New
import 'package:osm/features/orders/data/repositories/order_item_repository.dart'; // New
import 'package:osm/features/orders/data/repositories/payment_repository.dart'; // New

// Import all models needed for dummy data
import 'package:osm/features/customer/data/customer_model.dart';
import 'package:osm/features/doctors/data/models/doctor_model.dart';
import 'package:osm/features/prescription/data/models/prescription_model.dart';
import 'package:osm/features/inventory/data/models/store_location_model.dart';
import 'package:osm/features/inventory/data/models/frame_model.dart';
import 'package:osm/features/inventory/data/models/frame_enums.dart';
import 'package:osm/features/inventory/data/models/lens_model.dart';
import 'package:osm/features/inventory/data/models/lens_enums.dart';
import 'package:osm/features/inventory/data/models/inventory_model.dart';
import 'package:osm/features/orders/data/models/order_model.dart';
import 'package:osm/features/orders/data/models/order_item_model.dart';
import 'package:osm/features/orders/data/models/payment_model.dart';

/// A utility class to generate and populate dummy data into the Isar database.
class DummyDataGenerator {
  /// Populates the database with sample data if the customer collection is empty.
  static Future<void> generate(IsarService isarService) async {
    final customerRepo = CustomerRepository(isarService);
    final doctorRepo = DoctorRepository(isarService);
    final prescriptionRepo = PrescriptionRepository(isarService);
    final storeLocationRepo = StoreLocationRepository(isarService);
    final frameRepo = FrameRepository(isarService); // New
    final lensRepo = LensRepository(isarService); // New
    final inventoryRepo = InventoryRepository(isarService); // New
    final orderRepo = OrderRepository(isarService); // New
    final orderItemRepo = OrderItemRepository(isarService); // New
    final paymentRepo = PaymentRepository(isarService); // New

    // Check if customers exist, if not, add dummy data
    if ((await customerRepo.getAll()).isEmpty) {
      debugPrint('Adding comprehensive dummy data...');

      // --- Customers ---
      final customer1 = CustomerModel(
        firstName: 'Alice',
        lastName: 'Smith',
        city: 'Opticsville',
        primaryPhoneNumber: '9876543210',
        gender: 'Female',
        age: 30,
        profileImageUrl: 'https://placehold.co/100x100/FFDDC1/000000?text=AS',
      );
      final customer2 = CustomerModel(
        firstName: 'Bob',
        lastName: 'Johnson',
        city: 'Lensburg',
        primaryPhoneNumber: '1234567890',
        gender: 'Male',
        age: 45,
        profileImageUrl: 'https://placehold.co/100x100/C1DFFF/000000?text=BJ',
      );
      final customer3 = CustomerModel(
        firstName: 'Charlie',
        lastName: 'Brown',
        city: 'Frame City',
        primaryPhoneNumber: '5551234567',
        gender: 'Male',
        age: 25,
        profileImageUrl: 'https://placehold.co/100x100/D1FFC1/000000?text=CB',
      );
      final customer4 = CustomerModel(
        firstName: 'Charlie',
        lastName: 'Schnagger',
        city: 'Frame City',
        primaryPhoneNumber: '9012930112',
        gender: 'male',
        age: 30,
        profileImageUrl: 'https://placehold.co/100x100/D1FFC1/000000?text=CS',
      );
      final customer5 = CustomerModel(
        firstName: 'Faiz',
        lastName: 'Shaikh',
        city: 'Mumbai',
        primaryPhoneNumber: '9773446197',
        gender: 'Male',
        age: 22,
        profileImageUrl: 'https://placehold.co/100x100/DD1FF1/000000?text=FS',
      );

      final addedCustomer1Id = await customerRepo.add(customer1);
      final addedCustomer2Id = await customerRepo.add(customer2);
      final addedCustomer3Id = await customerRepo.add(customer3);
      final addedCustomer4Id = await customerRepo.add(customer4);
      final addedCustomer5Id = await customerRepo.add(customer5);

      final addedCustomer1 = await customerRepo.getById(addedCustomer1Id);
      final addedCustomer2 = await customerRepo.getById(addedCustomer2Id);
      final addedCustomer3 = await customerRepo.getById(addedCustomer3Id);
      final addedCustomer4 = await customerRepo.getById(addedCustomer4Id);
      final addedCustomer5 = await customerRepo.getById(addedCustomer5Id);
      debugPrint(
        "$addedCustomer3 \n\n\n\n $addedCustomer4 \n\n\n\n $addedCustomer5\n\n\n\n",
      );

      // --- Doctors ---
      final doctor1 = DoctorModel(
        designation: 'Ophthalmologist',
        doctorName: 'Dr. Emily White',
        hospital: 'City Eye Clinic',
        city: 'Opticsville',
      );
      final doctor2 = DoctorModel(
        designation: 'Optometrist',
        doctorName: 'Dr. David Green',
        hospital: 'Vision Care Center',
        city: 'Lensburg',
      );

      final addedDoctor1Id = await doctorRepo.add(doctor1);
      final addedDoctor2Id = await doctorRepo.add(doctor2);

      final addedDoctor1 = await doctorRepo.getById(addedDoctor1Id);
      final addedDoctor2 = await doctorRepo.getById(addedDoctor2Id);

      // --- Prescriptions ---
      PrescriptionModel? addedPrescription1;
      PrescriptionModel? addedPrescription2;

      if (addedCustomer1 != null && addedDoctor1 != null) {
        final prescription1 = PrescriptionModel(
          prescriptionDate: DateTime.now().subtract(const Duration(days: 30)),
          sphereRight: -2.5,
          cylinderRight: -0.75,
          axisRight: 180,
          addRight: 1.5,
          sphereLeft: -2.0,
          cylinderLeft: -0.50,
          axisLeft: 170,
          addLeft: 1.5,
          pd: 62,
          notes: 'For daily use, progressive lenses.',
        );
        final id = await prescriptionRepo.add(
          prescription1,
          customer: addedCustomer1,
          doctor: addedDoctor1,
        );
        addedPrescription1 = await prescriptionRepo.getById(id);
      }

      if (addedCustomer2 != null && addedDoctor2 != null) {
        final prescription2 = PrescriptionModel(
          prescriptionDate: DateTime.now().subtract(const Duration(days: 10)),
          sphereRight: -1.0,
          cylinderRight: 0,
          axisRight: 0,
          addRight: 0,
          sphereLeft: -1.25,
          cylinderLeft: 0,
          axisLeft: 0,
          addLeft: 0,
          pd: 60,
          notes: 'Single vision for distance.',
        );
        final id = await prescriptionRepo.add(
          prescription2,
          customer: addedCustomer2,
          doctor: addedDoctor2,
        );
        addedPrescription2 = await prescriptionRepo.getById(id);
      }

      // --- Store Locations ---
      final storeLocation1 = StoreLocationModel(
        name: 'Main Street Optics',
        address: '123 Main St, Opticsville',
        phoneNumber: '111-222-3333',
        operatingHours: 'Mon-Sat: 9AM-6PM',
      );
      final storeLocation2 = StoreLocationModel(
        name: 'Downtown Vision',
        address: '456 Oak Ave, Lensburg',
        phoneNumber: '444-555-6666',
        operatingHours: 'Mon-Fri: 10AM-7PM',
      );
      final addedStoreLocation1Id = await storeLocationRepo.add(storeLocation1);
      final addedStoreLocation2Id = await storeLocationRepo.add(storeLocation2);

      final addedStoreLocation1 = await storeLocationRepo.getById(
        addedStoreLocation1Id,
      );
      final addedStoreLocation2 = await storeLocationRepo.getById(
        addedStoreLocation2Id,
      );

      // --- Frames ---
      final frame1Variants = [
        FrameVariant(
          code: 'RB3025',
          color: Colors.black,
          colorName: 'Black',
          size: 58,
          quantity: 10,
          purchasePrice: 1000.0,
          salesPrice: 2500.0,
          imageUrls: [
            'https://placehold.co/400x400/000000/FFFFFF?text=RB+Black',
          ],
          localImagesPaths: ['path/to/local/rb_black.png'],
          productCode: FrameVariant.generateProductCode(
            FrameType.fullMetal,
            'Ray-Ban',
            'Aviator',
            'RB3025',
            'Black',
            58,
          ),
        ),
        FrameVariant(
          code: 'RB3025',
          color: Colors.brown,
          colorName: 'Brown',
          size: 55,
          quantity: 5,
          purchasePrice: 950.0,
          salesPrice: 2400.0,
          imageUrls: [
            'https://placehold.co/400x400/8B4513/FFFFFF?text=RB+Brown',
          ],
          localImagesPaths: ['path/to/local/rb_brown.png'],
          productCode: FrameVariant.generateProductCode(
            FrameType.fullMetal,
            'Ray-Ban',
            'Aviator',
            'RB3025',
            'Brown',
            55,
          ),
        ),
      ];
      final frame1 = FrameModel(
        companyName: 'Ray-Ban',
        frameType: FrameType.fullMetal,
        name: 'Aviator Classic',
        variants: frame1Variants,
      );
      final addedFrame1Id = await frameRepo.add(frame1);
      final addedFrame1 = await frameRepo.getById(addedFrame1Id);

      final frame2Variants = [
        FrameVariant(
          code: 'GUCCI001',
          color: Colors.red,
          colorName: 'Red',
          size: 52,
          quantity: 3,
          purchasePrice: 1500.0,
          salesPrice: 4000.0,
          imageUrls: [
            'https://placehold.co/400x400/FF0000/FFFFFF?text=Gucci+Red',
          ],
          localImagesPaths: ['path/to/local/gucci_red.png'],
          productCode: FrameVariant.generateProductCode(
            FrameType.fullShell,
            'Gucci',
            'Fashion',
            'GUCCI001',
            'Red',
            52,
          ),
        ),
      ];
      final frame2 = FrameModel(
        companyName: 'Gucci',
        frameType: FrameType.fullShell,
        name: 'Bold Frame',
        variants: frame2Variants,
      );
      final addedFrame2Id = await frameRepo.add(frame2);
      final addedFrame2 = await frameRepo.getById(addedFrame2Id);

      // --- Lenses ---
      final lens1Variants = [
        LensVariant(
          spherical: -1.0,
          cylindrical: -0.5,
          diameter: 65,
          materialType: LensMaterialType.plastic,
          index: 150,
          axis: 180,
          add: 0,
          baseCurve: 0,
          side: null,
          pair: 5,
          purchasePrice: 200.0,
          salesPrice: 500.0,
          imageUrls: [
            'https://placehold.co/400x400/ADD8E6/000000?text=SV+Plastic',
          ],
          localImagesPaths: ['path/to/local/sv_plastic.png'],
          productCode: LensVariant.generateProductCode(
            'Zeiss',
            'ClearView',
            LensType.singleVision,
            -1.0,
            -0.5,
            65,
            LensMaterialType.plastic,
            150,
            180,
            0,
            0,
            null,
          ),
        ),
      ];
      final lens1 = LensModel(
        companyName: 'Zeiss',
        productName: 'ClearView SV',
        lensType: LensType.singleVision,
        variants: lens1Variants,
        imageUrls: ['https://placehold.co/400x400/ADD8E6/000000?text=Zeiss+SV'],
      );
      final addedLens1Id = await lensRepo.add(lens1);
      final addedLens1 = await lensRepo.getById(addedLens1Id);

      final lens2Variants = [
        LensVariant(
          spherical: -3.0,
          cylindrical: 0,
          diameter: 70,
          materialType: LensMaterialType.polycarbonate,
          index: 167,
          axis: 0,
          add: 2.0,
          baseCurve: 8,
          side: ProgressiveLensSide.right,
          pair: 2,
          purchasePrice: 800.0,
          salesPrice: 2000.0,
          imageUrls: [
            'https://placehold.co/400x400/90EE90/000000?text=PG+Poly',
          ],
          localImagesPaths: ['path/to/local/pg_poly.png'],
          productCode: LensVariant.generateProductCode(
            'Essilor',
            'Varilux',
            LensType.progressive,
            -3.0,
            0,
            70,
            LensMaterialType.polycarbonate,
            167,
            0,
            2.0,
            8,
            ProgressiveLensSide.right,
          ),
        ),
      ];
      final lens2 = LensModel(
        companyName: 'Essilor',
        productName: 'Varilux Progressive',
        lensType: LensType.progressive,
        variants: lens2Variants,
        imageUrls: [
          'https://placehold.co/400x400/90EE90/000000?text=Essilor+PG',
        ],
      );
      final addedLens2Id = await lensRepo.add(lens2);
      final addedLens2 = await lensRepo.getById(addedLens2Id);

      // --- Inventory ---
      if (addedFrame1 != null) {
        await inventoryRepo.add(
          InventoryModel(
            quantityOnHand: addedFrame1.variants.first.quantity ?? 0,
            lastRestockDate: DateTime.now(),
            minStockLevel: 3,
          ),
          frame: addedFrame1,
        );
      }
      if (addedLens1 != null) {
        await inventoryRepo.add(
          InventoryModel(
            quantityOnHand: addedLens1.variants.first.pair ?? 0,
            lastRestockDate: DateTime.now(),
            minStockLevel: 2,
          ),
          lens: addedLens1,
        );
      }

      // --- Orders (linked to existing customers, prescriptions, store locations) ---
      OrderModel? addedOrder1;
      OrderModel? addedOrder2;

      if (addedCustomer1 != null &&
          addedPrescription1 != null &&
          addedStoreLocation1 != null) {
        final order1 = OrderModel(
          orderDate: DateTime.now().subtract(const Duration(days: 5)),
          totalAmount: 2750.0,
          status: 'Completed',
        );
        final id = await orderRepo.add(
          order1,
          customer: addedCustomer1,
          prescription: addedPrescription1,
          storeLocation: addedStoreLocation1,
        );
        addedOrder1 = await orderRepo.getOrderWithDetails(id);
      }

      if (addedCustomer2 != null &&
          addedPrescription2 != null &&
          addedStoreLocation2 != null) {
        final order2 = OrderModel(
          orderDate: DateTime.now().subtract(const Duration(days: 1)),
          totalAmount: 2500.0,
          status: 'Pending',
        );
        final id = await orderRepo.add(
          order2,
          customer: addedCustomer2,
          prescription: addedPrescription2,
          storeLocation: addedStoreLocation2,
        );
        addedOrder2 = await orderRepo.getOrderWithDetails(id);
      }

      // --- Order Items (linked to orders and products) ---
      if (addedOrder1 != null && addedFrame1 != null && addedLens1 != null) {
        final orderItem1 = OrderItemModel(
          productName: '${addedFrame1.companyName} ${addedFrame1.name}',
          quantity: 1,
          unitPrice: addedFrame1.variants.first.salesPrice ?? 0.0,
        );
        await orderItemRepo.add(
          orderItem1,
          order: addedOrder1,
          frame: addedFrame1,
        );

        final orderItem2 = OrderItemModel(
          productName: '${addedLens1.companyName} ${addedLens1.productName}',
          quantity: 1,
          unitPrice: addedLens1.variants.first.salesPrice ?? 0.0,
        );
        await orderItemRepo.add(
          orderItem2,
          order: addedOrder1,
          lens: addedLens1,
        );
      }

      if (addedOrder2 != null && addedFrame2 != null) {
        final orderItem3 = OrderItemModel(
          productName: '${addedFrame2.companyName} ${addedFrame2.name}',
          quantity: 1,
          unitPrice: addedFrame2.variants.first.salesPrice ?? 0.0,
        );
        await orderItemRepo.add(
          orderItem3,
          order: addedOrder2,
          frame: addedFrame2,
        );
      }

      // --- Payments (linked to orders) ---
      if (addedOrder1 != null) {
        final payment1 = PaymentModel(
          paymentDate: DateTime.now().subtract(const Duration(days: 4)),
          amountPaid: 2750.0,
          paymentMethod: 'Credit Card',
          status: 'Paid',
          transactionId: 'TRX12345',
        );
        await paymentRepo.add(payment1, order: addedOrder1);
      }

      if (addedOrder2 != null) {
        final payment2 = PaymentModel(
          paymentDate: DateTime.now().subtract(const Duration(hours: 10)),
          amountPaid: 1000.0, // Partial payment
          paymentMethod: 'Cash',
          status: 'Partial',
          transactionId: 'TRX67890',
        );
        await paymentRepo.add(payment2, order: addedOrder2);
      }

      debugPrint('Comprehensive dummy data added successfully.');
    } else {
      debugPrint(
        'Database already contains data. Skipping dummy data generation.',
      );
    }
  }
}
