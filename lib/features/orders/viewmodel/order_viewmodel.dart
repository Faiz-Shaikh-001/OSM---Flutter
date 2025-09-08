// Imports
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:osm/features/inventory/data/models/product_model.dart';
import 'package:osm/features/customer/viewmodel/customer_viewmodel.dart';

// Model imports
import '../data/models/order_model.dart';
import '../../customer/data/customer_model.dart';
import '../../prescription/data/models/prescription_model.dart';
import '../../inventory/data/models/store_location_model.dart';

// Repository imports
import '../data/repositories/order_repository.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderRepository _orderRepository;
  final CustomerViewModel _customerViewModel;

  // State variables
  List<OrderModel> _orders = [];
  bool _isLoading = false;
  String? _errorMessage;
  CustomerModel? _selectedCustomer;

  // Getters to expose state to the UI
  List<OrderModel> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  CustomerModel? get selectedCustomer => _selectedCustomer;

  OrderViewModel(this._orderRepository, this._customerViewModel);

  // Fetches all orders from the repository and updates the state
  Future<void> loadOrders() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _orders = await _orderRepository.getAll();
    } catch (e) {
      _errorMessage = 'Failed to load orders: ${e.toString()}';
      _orders = [];
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Adds a new order via the repository and reloads the list.
  Future<void> addOrder(
    OrderModel order, {
    required CustomerModel customer,
    required PrescriptionModel prescription,
    StoreLocationModel? storeLocation,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _orderRepository.add(
        order,
        customer: customer,
        prescription: prescription,
        storeLocation: storeLocation,
      );
      await loadOrders(); // Reload to reflect the new order
    } catch (e) {
      _errorMessage = 'Failed to add order: ${e.toString()}';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Updates an existing order via the repository and reloads the list.
  Future<void> updateOrder(OrderModel order) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _orderRepository.update(order);
      await loadOrders(); // Reload to reflect the update
    } catch (e) {
      _errorMessage = 'Failed to update order: ${e.toString()}';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Deletes an order by its ID via the repository and reloads the list.
  Future<void> deleteOrder(Id orderId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final deleted = await _orderRepository.delete(orderId);
      if (deleted) {
        await loadOrders(); // Reload to reflect the deletion
      } else {
        _errorMessage = 'Order not found or could not be deleted.';
      }
    } catch (e) {
      _errorMessage = 'Failed to delete order: ${e.toString()}';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Retrieves orders for a specific customer.
  Future<List<OrderModel>> getOrdersByCustomer(Id customerId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    List<OrderModel> customerOrders = [];
    try {
      customerOrders = await _orderRepository.getOrdersForCustomer(customerId);
    } catch (e) {
      _errorMessage =
          'Failed to get orders for customer $customerId: ${e.toString()}';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return customerOrders;
  }

  void selectCustomer(CustomerModel customer) {
    _selectedCustomer = customer;
    _customerViewModel.clearSearchResults();
    notifyListeners();
  }

  void resetForm() {
    _selectedCustomer = null;
    _selectedProducts.clear();
    _customerViewModel.clearSearchResults();
    notifyListeners();
  }

  // NEW: To manage the products in the current order
  final Map<Product, int> _selectedProducts = {};
  Map<Product, int> get selectedProducts => _selectedProducts;

  // Method to add or increase the quantity of a product
  void addProduct(Product product) {
    _selectedProducts[product] = (_selectedProducts[product] ?? 0) + 1;
    notifyListeners();
  }

  // Method to decrease the quantity of a product
  void removeProduct(Product product) {
    if (_selectedProducts.containsKey(product) &&
        _selectedProducts[product]! > 1) {
      _selectedProducts[product] = _selectedProducts[product]! - 1;
    } else {
      _selectedProducts.remove(product);
    }
    notifyListeners();
  }

  // Calculated property for the total price
  double get totalPrice {
    if (_selectedProducts.isEmpty) return 0.0;
    return _selectedProducts.entries
        .map((entry) => entry.key.price * entry.value)
        .reduce((value, element) => value + element);
  }

  // Calculated property for the total number of items
  int get totalItems {
    if (_selectedProducts.isEmpty) return 0;
    return _selectedProducts.values.reduce((value, element) => value + element);
  }
}
