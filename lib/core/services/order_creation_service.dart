import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/features/orders/data/models/order_model.dart';
import 'package:osm/features/orders/data/models/order_item_model.dart';
import 'package:osm/features/orders/data/models/payment_model.dart';
import 'package:osm/features/customer/data/customer_model.dart';
import 'package:osm/features/prescription/data/models/prescription_model.dart';
import 'package:osm/features/inventory/data/models/store_location_model.dart';
import 'package:osm/features/orders/data/models/order_model_enums.dart';

class OrderCreationService {
  final IsarService _isarService;

  OrderCreationService(this._isarService);

  Future<OrderModel> createCompleteOrder({
    required CustomerModel customer,
    required List<OrderItemModel> items,
    required double totalAmount,
    required PaymentModel payment,
    PrescriptionModel? prescription,
    StoreLocationModel? storeLocation,
  }) async {
    final isar = await _isarService.db;

    return await isar.writeTxn(() async {
      // 1. Create prescription if not provided
      final actualPrescription = prescription ?? _createDefaultPrescription();
      
      // 2. Create the order with all data
      final order = OrderModel(
        orderDate: DateTime.now(),
        totalAmount: totalAmount,
        status: OrderStatus.pending.name,
      );

      // 3. Save all entities and get their IDs
      // Save prescription first
      actualPrescription.id = await isar.prescriptionModels.put(actualPrescription);
      
      // Save order to get ID
      order.id = await isar.orderModels.put(order);
      
      // Save payment
      payment.id = await isar.paymentModels.put(payment);

      // 4. Now establish ALL relationships
      // Order -> Customer
      order.customer.value = customer;
      await order.customer.save();
      
      // Order -> Prescription
      order.prescription.value = actualPrescription;
      await order.prescription.save();
      
      // Order -> Store Location (if provided)
      if (storeLocation != null) {
        order.storeLocation.value = storeLocation;
        await order.storeLocation.save();
      }
      
      // Payment -> Order
      payment.order.value = order;
      await payment.order.save();

      // 5. Save order items and establish relationships
      for (final item in items) {
        item.id = await isar.orderItemModels.put(item);
        item.order.value = order;
        await item.order.save();
      }

      // 6. Update backlinks manually
      // Customer -> Orders
      customer.orders.add(order);
      await isar.customerModels.put(customer);

      // Prescription -> Orders
      actualPrescription.orders.add(order);
      await isar.prescriptionModels.put(actualPrescription);

      // Store Location -> Orders (if provided)
      if (storeLocation != null) {
        storeLocation.orders.add(order);
        await isar.storeLocationModels.put(storeLocation);
      }

      // Order -> Payments
      order.payments.add(payment);
      await isar.orderModels.put(order);

      debugPrint('Order created successfully with ID: ${order.id}');
      debugPrint('Customer linked: ${order.customer.value != null}');
      debugPrint('Prescription linked: ${order.prescription.value != null}');
      debugPrint('Items count: ${items.length}');
      debugPrint('Payment linked: ${payment.order.value != null}');

      return order;
    });
  }

  PrescriptionModel _createDefaultPrescription() {
    return PrescriptionModel(
      prescriptionDate: DateTime.now(),
      sphereRight: 0.0,
      sphereLeft: 0.0,
      cylinderRight: 0.0,
      cylinderLeft: 0.0,
      axisRight: 0.0,
      axisLeft: 0.0,
      addRight: 0.0,
      addLeft: 0.0,
      pd: 0.0,
    );
  }

  // Helper method to load order with all relationships
  Future<OrderModel?> getOrderWithRelations(Id orderId) async {
    final isar = await _isarService.db;
    final order = await isar.orderModels.get(orderId);
    
    if (order != null) {
      await order.customer.load();
      await order.prescription.load();
      await order.items.load();
      await order.payments.load();
      await order.storeLocation.load();
      
      // Load nested relations for items
      for (final item in order.items) {
        await item.frame.load();
        await item.lens.load();
      }
      
      // Load nested relations for payments
      for (final payment in order.payments) {
        await payment.order.load();
      }
    }
    
    return order;
  }
}