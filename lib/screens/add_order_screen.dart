import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:osm/data/models/customer_model.dart';
import 'package:osm/data/models/prescription_model.dart';
import 'package:osm/data/models/store_location_model.dart';
import 'package:osm/data/models/order_model.dart'; // For creating the order

import 'package:osm/viewmodels/customer_viewmodel.dart';
import 'package:osm/viewmodels/prescription_viewmodel.dart';
import 'package:osm/viewmodels/store_location_viewmodel.dart';
import 'package:osm/viewmodels/order_viewmodel.dart'; // For submitting the order

import 'package:osm/widgets/build_text_field_widget.dart'; // Reusable text field
import 'package:osm/widgets/custom_button.dart'; // Reusable button

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final _formKey = GlobalKey<FormState>();

  // Order Details
  DateTime _orderDate = DateTime.now();
  final TextEditingController _totalAmountController = TextEditingController(
    text: '0.0',
  );
  String? _selectedStatus; // For order status

  // Selected Models for Relationships
  CustomerModel? _selectedCustomer;
  PrescriptionModel? _selectedPrescription;
  StoreLocationModel? _selectedStoreLocation;

  // List of available statuses (you might want an enum for this later)
  final List<String> _orderStatuses = [
    'Pending',
    'Processing',
    'Completed',
    'Cancelled',
  ];

  @override
  void initState() {
    super.initState();
    // Load data for dropdowns
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CustomerViewModel>().loadCustomers();
      context.read<PrescriptionViewModel>().loadPrescriptions();
      context.read<StoreLocationViewModel>().loadStoreLocations();
    });
  }

  @override
  void dispose() {
    _totalAmountController.dispose();
    super.dispose();
  }

  Future<void> _selectOrderDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _orderDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _orderDate) {
      setState(() {
        _orderDate = picked;
      });
    }
  }

  void _submitOrder() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields.')),
      );
      return;
    }

    if (_selectedCustomer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a customer.')),
      );
      return;
    }

    if (_selectedPrescription == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a prescription.')),
      );
      return;
    }

    if (_selectedStatus == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an order status.')),
      );
      return;
    }

    // Parse total amount
    final double? totalAmount = double.tryParse(_totalAmountController.text);
    if (totalAmount == null || totalAmount < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid total amount.')),
      );
      return;
    }

    // Create the OrderModel instance
    final newOrder = OrderModel(
      orderDate: _orderDate,
      totalAmount: totalAmount,
      status: _selectedStatus!,
      // Relationships will be set in the repository's add method
    );

    try {
      // Call the ViewModel to add the order
      await context.read<OrderViewModel>().addOrder(
        newOrder,
        customer: _selectedCustomer!,
        prescription: _selectedPrescription!,
        storeLocation: _selectedStoreLocation, // Optional
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order added successfully!')),
        );
        Navigator.pop(context); // Go back after successful addition
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add order: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Order'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Order Details Section ---
              Text(
                'Order Details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Order Date'),
                trailing: Text(
                  DateFormat.yMMMd().format(_orderDate),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                onTap: _selectOrderDate,
              ),
              const SizedBox(height: 16),
              BuildTextFieldWidget(
                controller: _totalAmountController,
                label: 'Total Amount',
                isDecimal: true,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Order Status',
                  border: OutlineInputBorder(),
                ),
                value: _selectedStatus,
                items: _orderStatuses.map((status) {
                  return DropdownMenuItem(value: status, child: Text(status));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value;
                  });
                },
                validator: (value) => value == null ? 'Select status' : null,
              ),
              const SizedBox(height: 32),

              // --- Customer Selection Section ---
              Text(
                'Customer',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Consumer<CustomerViewModel>(
                builder: (context, customerViewModel, child) {
                  if (customerViewModel.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (customerViewModel.errorMessage != null) {
                    return Text(
                      'Error loading customers: ${customerViewModel.errorMessage}',
                    );
                  }
                  if (customerViewModel.customers.isEmpty) {
                    return const Text(
                      'No customers available. Add customers first.',
                    );
                  }
                  return DropdownButtonFormField<CustomerModel>(
                    decoration: const InputDecoration(
                      labelText: 'Select Customer',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedCustomer,
                    onChanged: (customer) {
                      setState(() {
                        _selectedCustomer = customer;
                        // Optionally, filter prescriptions based on selected customer here
                        _selectedPrescription =
                            null; // Reset prescription when customer changes
                      });
                    },
                    items: customerViewModel.customers.map((customer) {
                      return DropdownMenuItem(
                        value: customer,
                        child: Text(
                          '${customer.firstName} ${customer.lastName} (${customer.primaryPhoneNumber})',
                        ),
                      );
                    }).toList(),
                    validator: (value) =>
                        value == null ? 'Select a customer' : null,
                  );
                },
              ),
              const SizedBox(height: 32),

              // --- Prescription Selection Section ---
              Text(
                'Prescription',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Consumer<PrescriptionViewModel>(
                builder: (context, prescriptionViewModel, child) {
                  // Filter prescriptions by selected customer if a customer is selected
                  final List<PrescriptionModel> filteredPrescriptions =
                      _selectedCustomer != null
                      ? prescriptionViewModel.prescriptions
                            .where(
                              (p) =>
                                  p.customer.value?.id == _selectedCustomer!.id,
                            )
                            .toList()
                      : prescriptionViewModel.prescriptions;

                  if (prescriptionViewModel.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (prescriptionViewModel.errorMessage != null) {
                    return Text(
                      'Error loading prescriptions: ${prescriptionViewModel.errorMessage}',
                    );
                  }
                  if (filteredPrescriptions.isEmpty) {
                    return const Text(
                      'No prescriptions available for this customer or in general.',
                    );
                  }
                  return DropdownButtonFormField<PrescriptionModel>(
                    decoration: const InputDecoration(
                      labelText: 'Select Prescription',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedPrescription,
                    onChanged: (prescription) {
                      setState(() {
                        _selectedPrescription = prescription;
                      });
                    },
                    items: filteredPrescriptions.map((prescription) {
                      return DropdownMenuItem(
                        value: prescription,
                        child: Text(
                          'Prescription #${prescription.id} - ${DateFormat.yMMMd().format(prescription.prescriptionDate)}',
                        ),
                      );
                    }).toList(),
                    validator: (value) =>
                        value == null ? 'Select a prescription' : null,
                  );
                },
              ),
              const SizedBox(height: 32),

              // --- Store Location Selection Section (Optional) ---
              Text(
                'Store Location (Optional)',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Consumer<StoreLocationViewModel>(
                builder: (context, storeLocationViewModel, child) {
                  if (storeLocationViewModel.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (storeLocationViewModel.errorMessage != null) {
                    return Text(
                      'Error loading store locations: ${storeLocationViewModel.errorMessage}',
                    );
                  }
                  if (storeLocationViewModel.storeLocations.isEmpty) {
                    return const Text('No store locations available.');
                  }
                  return DropdownButtonFormField<StoreLocationModel>(
                    decoration: const InputDecoration(
                      labelText: 'Select Store Location',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedStoreLocation,
                    onChanged: (location) {
                      setState(() {
                        _selectedStoreLocation = location;
                      });
                    },
                    items: storeLocationViewModel.storeLocations.map((
                      location,
                    ) {
                      return DropdownMenuItem(
                        value: location,
                        child: Text(location.name),
                      );
                    }).toList(),
                    // This is optional, so no validator needed
                  );
                },
              ),
              const SizedBox(height: 32),

              // TODO: Order Items Section (Will be added in Part 2)
              Text(
                'Order Items (Coming Soon)',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),

              // Placeholder for future order items list/form
              const SizedBox(height: 32),

              // TODO: Payments Section (Will be added in Part 3)
              Text(
                'Payments (Coming Soon)',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),

              // Placeholder for future payments list/form
              const SizedBox(height: 32),

              CustomButton(
                onPressed: _submitOrder,
                label: 'Create Order',
                icon: Icons.check,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
