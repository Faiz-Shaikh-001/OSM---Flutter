import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osm/data/models/customer_model.dart';
import 'package:osm/utils/product_type.dart';
import 'package:osm/viewmodels/customer_viewmodel.dart';
import 'package:osm/viewmodels/order_viewmodel.dart';
import 'package:osm/widgets/build_text_field_widget.dart';
import 'package:osm/widgets/custom_button.dart';
import 'package:osm/widgets/image_selector_widget.dart';
import 'package:provider/provider.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  int _currentStep = 1;
  ProductType? _selectedProductType;
  final TextEditingController _customerSearchController =
      TextEditingController();
  bool _isAddingNewCustomer = false;
  Timer? _debounce;

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  final cityController = TextEditingController();
  final genderController = TextEditingController();
  final List<File> selectedImages = [];

  @override
  void dispose() {
    _customerSearchController.dispose();
    _debounce?.cancel();

    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    ageController.dispose();
    cityController.dispose();
    genderController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    if (_isAddingNewCustomer) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      context.read<CustomerViewModel>().searchCustomers(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("New Order")),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            if (_currentStep > 1) {
              setState(() {
                _currentStep -= 1;
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            OrderStepper(currentStep: _currentStep),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(child: _buildBodyForStep()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyForStep() {
    switch (_currentStep) {
      case 1:
        return _buildCustomerDetailStep();
      case 2:
        return _buildProductsStep();
      case 3:
        return _buildPaymentStep();
      default:
        return const SizedBox();
    }
  }

  // In _AddOrderScreenState class
  Widget _buildAddNewCustomerForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const Text(
            'Add a New Customer',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ImageSelectorWidget(
            selectedImages: selectedImages,
            onImagesChanged: (imgs) => setState(
              () => selectedImages
                ..clear()
                ..addAll(imgs),
            ),
          ),
          BuildTextFieldWidget(
            controller: firstNameController,
            label: 'First Name',
          ),
          BuildTextFieldWidget(
            controller: lastNameController,
            label: 'Last Name',
          ),
          BuildTextFieldWidget(
            controller: phoneController,
            label: 'Phone Number',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .40,
                child: BuildTextFieldWidget(
                  controller: ageController,
                  label: 'Age',
                  isNumeric: true,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .50,
                child: BuildTextFieldWidget(
                  controller: genderController,
                  label: 'Gender',
                ),
              ),
            ],
          ),
          BuildTextFieldWidget(controller: cityController, label: 'City'),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Go back to the search view without adding a customer
                    setState(() {
                      _isAddingNewCustomer = false;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),

                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final customer = CustomerModel(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        city: cityController.text,
                        primaryPhoneNumber: phoneController.text,
                        gender: genderController.text,
                        age: int.parse(ageController.text),
                        profileImageUrl:
                            'https://placehold.co/100x100/FFDDC1/000000?text=DD',
                      );

                      context.read<CustomerViewModel>().addCustomer(customer);
                      debugPrint(
                        'Adding new customer: ${firstNameController.text} ${lastNameController.text}',
                      );

                      setState(() {
                        _isAddingNewCustomer = false;
                      });
                    }
                  },
                  label: 'Save Customer',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerDetailStep() {
    return Consumer2<OrderViewModel, CustomerViewModel>(
      builder: (context, orderViewModel, customerViewModel, child) {
        if (_isAddingNewCustomer) {
          return _buildAddNewCustomerForm();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search for a customer',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _customerSearchController,
              decoration: InputDecoration(
                hintText: 'Search customer by name or phone no.',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: _onSearchChanged,
            ),
            const SizedBox(height: 20),
            if (orderViewModel.selectedCustomer != null)
              Card(
                child: ListTile(
                  title: Text(
                    "${orderViewModel.selectedCustomer!.firstName} ${orderViewModel.selectedCustomer!.lastName}",
                  ),
                  subtitle: Text(
                    orderViewModel.selectedCustomer!.primaryPhoneNumber,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      orderViewModel.resetForm();
                      _customerSearchController.clear();
                    },
                    icon: Icon(Icons.cancel, color: Colors.red),
                  ),
                ),
              )
            else if (customerViewModel.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (customerViewModel.searchResults.isNotEmpty)
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: customerViewModel.searchResults.length,
                  itemBuilder: (context, index) {
                    final customer = customerViewModel.searchResults[index];
                    return ListTile(
                      title: Text("${customer.firstName} ${customer.lastName}"),
                      subtitle: Text(customer.primaryPhoneNumber),
                      onTap: () {
                        orderViewModel.selectCustomer(customer);
                      },
                    );
                  },
                ),
              )
            else if (_customerSearchController.text.isNotEmpty)
              _noCustomerFound(),
          ],
        );
      },
    );
  }

  Widget _buildProductsStep() {
    return Center(child: Text("Product Details"));
  }

  Widget _buildPaymentStep() {
    return Center(child: Text('Payment details'));
  }

  Widget _noCustomerFound() {
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          Expanded(child: Center(child: Text('No Customer found'))),
          CustomButton(
            onPressed: () {
              setState(() {
                _isAddingNewCustomer = true;
              });
            },
            label: 'Add New Customer',
          ),
        ],
      ),
    );
  }
}

class OrderStepper extends StatelessWidget {
  final int currentStep;
  const OrderStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return _buildOrderSteps();
  }

  Widget _buildOrderSteps() {
    return Row(
      children: [
        _buildStep(stepNumber: 1, label: 'Customer'),
        _buildStepConnector(1),
        _buildStep(stepNumber: 2, label: 'Products'),
        _buildStepConnector(2),
        _buildStep(stepNumber: 3, label: 'Payment'),
        _buildStepConnector(3),
      ],
    );
  }

  Widget _buildStep({required int stepNumber, required String label}) {
    bool isCompleted = stepNumber < currentStep;
    bool isCurrent = stepNumber == currentStep;

    Color stepColor = isCurrent
        ? Colors.blue
        : (isCompleted ? Colors.blue.shade200 : Colors.grey);
    Color textColor = isCurrent ? Colors.blue : Colors.grey;
    FontWeight fontWeight = isCurrent ? FontWeight.bold : FontWeight.normal;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(color: stepColor, shape: BoxShape.circle),
            child: Center(
              child: Text(
                '$stepNumber',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: textColor, fontWeight: fontWeight),
          ),
        ],
      ),
    );
  }

  Widget _buildStepConnector(int stepNumber) {
    bool isActive = currentStep >= stepNumber;

    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        height: 2.0,
        color: isActive ? Colors.blue : Colors.grey.shade200,
      ),
    );
  }
}
