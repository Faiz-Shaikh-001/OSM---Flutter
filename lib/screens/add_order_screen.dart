import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
// Upgraded to Material 3 premium UI styling
import 'package:osm/data/models/customer_model.dart';
import 'package:osm/data/models/product_model.dart';
import 'package:osm/services/save_image_to_app_directory.dart';
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
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _secondaryPhoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _cityController = TextEditingController();
  final _genderController = TextEditingController();
  final List<File> _customerSelectedImages = [];

  // NEW: State for the product step
  ProductType _selectedCategory = ProductType.frame; // Default category

  // NEW: Dummy data for demonstration purposes
  final List<Product> _dummyProducts = [
    Product(
      id: 'p1',
      name: 'Aviator Gold',
      imageUrl: 'https://placehold.co/300x200/E5D1B8/000000?text=Aviator',
      price: 4500,
      category: ProductType.frame,
    ),
    Product(
      id: 'p2',
      name: 'Wayfarer Black',
      imageUrl: 'https://placehold.co/300x200/333333/FFFFFF?text=Wayfarer',
      price: 3200,
      category: ProductType.frame,
    ),
    Product(
      id: 'p3',
      name: 'Anti-Glare Lenses',
      imageUrl: 'https://placehold.co/300x200/E0F7FA/000000?text=Lenses',
      price: 1800,
      category: ProductType.lens,
    ),
    Product(
      id: 'p4',
      name: 'Blue-Cut Lenses',
      imageUrl: 'https://placehold.co/300x200/D1C4E9/000000?text=Lenses',
      price: 2500,
      category: ProductType.lens,
    ),
    Product(
      id: 'p5',
      name: 'Classic Sunglasses',
      imageUrl: 'https://placehold.co/300x200/795548/FFFFFF?text=Sunglass',
      price: 5500,
      category: ProductType.frame,
    ),
    Product(
      id: 'p8',
      name: 'Round Vintage',
      imageUrl: 'https://placehold.co/300x200/F5F5F5/000000?text=Round',
      price: 3800,
      category: ProductType.frame,
    ),
  ];

  @override
  void dispose() {
    _customerSearchController.dispose();
    _debounce?.cancel();

    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _secondaryPhoneController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _cityController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      context.read<CustomerViewModel>().searchCustomers(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final customerViewModel = context.watch<CustomerViewModel>();
    final orderViewModel = context.watch<OrderViewModel>();

    Widget bodyContent;

    if (_currentStep == 1) {
      if (orderViewModel.selectedCustomer != null) {
        bodyContent = Column(
          children: [
            Expanded(
              // The card is in a scroll view in case it's too tall for the screen
              child: SingleChildScrollView(
                child: _buildSelectedCustomerCard(
                  orderViewModel.selectedCustomer!,
                  () {
                    orderViewModel.resetForm();
                    _customerSearchController.clear();
                    // Also clear the search results in the view model
                    context.read<CustomerViewModel>().searchCustomers('');
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            // The "Next" button is anchored to the bottom
            CustomButton(
              label: 'Next Step',
              onPressed: () {
                setState(() {
                  _currentStep = 2; // Move to the products step
                });
              },
            ),
          ],
        );
      } else {
        bodyContent = _buildCustomerSearchStep(customerViewModel);
      }
    } else if (_currentStep == 2) {
      bodyContent = _buildProductsStep();
    } else {
      bodyContent = _buildPaymentStep();
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        title: const Center(child: Text("New Order")),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            if (_currentStep > 1) {
              setState(() {
                _currentStep -= 1;
              });
            } else if (orderViewModel.selectedCustomer != null) {
              orderViewModel.resetForm();
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OrderStepper(currentStep: _currentStep),
            ),
            Expanded(
              child: Padding(padding: EdgeInsets.all(16.0), child: bodyContent),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerSearchStep(CustomerViewModel customerViewModel) {
    if (_isAddingNewCustomer) {
      return SingleChildScrollView(child: _buildAddNewCustomerForm());
    }

    final bool showNoCustomerFoundView =
        _customerSearchController.text.isNotEmpty &&
        customerViewModel.searchResults.isEmpty &&
        !customerViewModel.isLoading;

    if (showNoCustomerFoundView) {
      return _buildNoCustomerFoundLayout();
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Search for a customer',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildCustomerSearchBar(),
          const SizedBox(height: 20),
          if (customerViewModel.isLoading)
            const Center(child: CircularProgressIndicator())
          else if (customerViewModel.searchResults.isNotEmpty)
            // Use ListView.builder for the search results
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: customerViewModel.searchResults.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final customer = customerViewModel.searchResults[index];
                // Upgraded ListTile with M3 styling
                return Card(
                  elevation: 2.0, // Controls the size of the shadow.
                  shadowColor: Colors.black.withOpacity(
                    0.5,
                  ), // Optional: customize shadow color.
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  clipBehavior: Clip
                      .antiAlias, // Ensures the ListTile's ripple effect stays within the card's rounded corners.
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundImage:
                          customer.profileImageUrl.startsWith('http')
                          ? NetworkImage(customer.profileImageUrl)
                          : FileImage(File(customer.profileImageUrl))
                                as ImageProvider,
                      onBackgroundImageError: (_, __) {},
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      child:
                          customer.profileImageUrl.isEmpty ||
                              customer.profileImageUrl.contains('placehold.co')
                          ? Icon(
                              Icons.person,
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                            )
                          : null,
                    ),
                    title: Text(
                      "${customer.firstName} ${customer.lastName}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      customer.primaryPhoneNumber,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    onTap: () {
                      context.read<OrderViewModel>().selectCustomer(customer);
                    },
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildCustomerSearchBar() {
    return TextField(
      controller: _customerSearchController,
      decoration: InputDecoration(
        hintText: 'Search customer by first-name or phone no.',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onChanged: _onSearchChanged,
    );
  }

  Widget _buildNoCustomerFoundLayout() {
    return Column(
      children: [
        const Text(
          'Search for a customer',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildCustomerSearchBar(),
        const Spacer(),
        const Icon(Icons.person_search, size: 60, color: Colors.grey),
        const SizedBox(height: 16),
        const Text(
          'No Customer Found',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'You can add a new customer to continue.',
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        CustomButton(
          onPressed: () {
            setState(() {
              _isAddingNewCustomer = true;
            });
          },
          label: 'Add New Customer',
        ),
      ],
    );
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
            selectedImages: _customerSelectedImages,
            onImagesChanged: (imgs) => setState(
              () => _customerSelectedImages
                ..clear()
                ..addAll(imgs),
            ),
          ),
          BuildTextFieldWidget(
            controller: _firstNameController,
            label: 'First Name',
          ),
          BuildTextFieldWidget(
            controller: _lastNameController,
            label: 'Last Name',
          ),
          BuildTextFieldWidget(
            controller: _phoneController,
            label: 'Phone Number',
          ),
          BuildTextFieldWidget(
            controller: _secondaryPhoneController,
            label: 'Secondary Phone Number (Optional)',
            isOptional: true,
          ),
          BuildTextFieldWidget(
            controller: _emailController,
            label: 'Email (Optional)',
            isOptional: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .40,
                child: BuildTextFieldWidget(
                  controller: _ageController,
                  label: 'Age',
                  isNumeric: true,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .50,
                child: BuildTextFieldWidget(
                  controller: _genderController,
                  label: 'Gender',
                ),
              ),
            ],
          ),
          BuildTextFieldWidget(controller: _cityController, label: 'City'),
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
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      String profileImageUrl =
                          'https://placehold.co/100x100?text=Profile';

                      if (_customerSelectedImages.isNotEmpty) {
                        profileImageUrl = await saveImageToAppDirectory(
                          _customerSelectedImages.first,
                        );
                      }

                      final newCustomer = CustomerModel(
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        city: _cityController.text,
                        primaryPhoneNumber: _phoneController.text,
                        secondaryPhoneNumber: _secondaryPhoneController.text,
                        email: _emailController.text,
                        gender: _genderController.text,
                        age: int.parse(_ageController.text),
                        profileImageUrl: profileImageUrl,
                      );

                      await context.read<CustomerViewModel>().addCustomer(
                        newCustomer,
                      );
                      debugPrint(
                        'Adding new customer: ${_firstNameController.text} ${_lastNameController.text}',
                      );

                      setState(() {
                        _isAddingNewCustomer = false;
                        _customerSearchController.clear();
                        _customerSelectedImages.clear();
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

  // New, detailed card to display all customer information.
  Widget _buildSelectedCustomerCard(
    CustomerModel customer,
    VoidCallback onRemove,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top section: Picture, Name, ID, and Deselect Button
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: colorScheme.primaryContainer,
                  // Handles both network images and local file images
                  backgroundImage: customer.profileImageUrl.startsWith('http')
                      ? NetworkImage(customer.profileImageUrl)
                      : FileImage(File(customer.profileImageUrl))
                            as ImageProvider,
                  // Fallback icon if the image fails to load
                  onBackgroundImageError: (_, _) {},
                  child:
                      customer.profileImageUrl.isEmpty ||
                          customer.profileImageUrl.contains('placehold.co')
                      ? const Icon(Icons.person, size: 30, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 16),
                // Name and ID
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${customer.firstName} ${customer.lastName}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                      ),
                      Text(
                        'ID: ${customer.id}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                // Deselect Button
                IconButton(
                  onPressed: onRemove,
                  icon: Icon(Icons.close),
                  style: IconButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: colorScheme.errorContainer,
                    foregroundColor: colorScheme.onErrorContainer,
                  ),
                ),
              ],
            ),
            const Divider(height: 24, thickness: 1),

            // Details Section
            _buildDetailRow(Icons.cake, 'Age', '${customer.age}'),
            _buildDetailRow(Icons.person_outline, 'Gender', customer.gender),
            _buildDetailRow(Icons.location_city, 'City', customer.city),
            _buildDetailRow(
              Icons.phone_outlined,
              'Phone',
              customer.primaryPhoneNumber,
            ),

            // Optional Fields: Only show them if they have data.
            if (customer.email != null && customer.email!.isNotEmpty)
              _buildDetailRow(Icons.email_outlined, 'Email', customer.email!),

            if (customer.secondaryPhoneNumber != null &&
                customer.secondaryPhoneNumber!.isNotEmpty)
              _buildDetailRow(
                Icons.phone_iphone_outlined,
                'Secondary Phone',
                customer.secondaryPhoneNumber!,
              ),
          ],
        ),
      ),
    );
  }

  // Helper widget to create consistent rows for each piece of detail.
  Widget _buildDetailRow(IconData icon, String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(icon, size: 30, color: colorScheme.primary),
          const SizedBox(width: 16),
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          // Using Expanded to handle long text gracefully
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsStep() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final orderViewModel = context.watch<OrderViewModel>();

    // Filter products based on the selected category
    final filteredProducts = _dummyProducts
        .where((p) => p.category == _selectedCategory)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Products', style: textTheme.titleLarge),
        const SizedBox(height: 16),

        // Category Selector
        SizedBox(
          width: double.infinity,
          child: SegmentedButton<ProductType>(
            segments: const [
              ButtonSegment(
                value: ProductType.frame,
                label: Text('Frames'),
                icon: Icon(Icons.style_outlined),
              ),
              ButtonSegment(
                value: ProductType.lens,
                label: Text('Lenses'),
                icon: Icon(Icons.lens_blur_outlined),
              ),
              ButtonSegment(
                value: ProductType.frame,
                label: Text('Sunglasses'),
                icon: Icon(Icons.wb_sunny_outlined),
              ),
            ],
            selected: {_selectedCategory},
            onSelectionChanged: (Set<ProductType> newSelection) {
              setState(() {
                _selectedCategory = newSelection.first;
              });
            },
          ),
        ),
        const SizedBox(height: 20),

        // Product Grid
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 cards per row
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75, // Adjust for desired card height
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              final quantity = orderViewModel.selectedProducts[product] ?? 0;
              return _buildProductCard(product, quantity, orderViewModel);
            },
          ),
        ),

        const SizedBox(height: 16),

        // Sticky Bottom Summary Bar and Button
        _buildOrderSummaryBar(orderViewModel, textTheme, colorScheme),
      ],
    );
  }

  // Helper method to build a single product card
  Widget _buildProductCard(
    Product product,
    int quantity,
    OrderViewModel viewModel,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainer,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Product Image
          Expanded(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Center(child: Icon(Icons.broken_image)),
            ),
          ),
          // Product Details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '₹${product.price.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Add Button or Quantity Stepper
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: quantity == 0
                ? FilledButton.tonal(
                    onPressed: () => viewModel.addProduct(product),
                    child: const Text('Add'),
                  )
                : _buildQuantityStepper(product, quantity, viewModel),
          ),
        ],
      ),
    );
  }

  // Helper for the +/- quantity stepper
  Widget _buildQuantityStepper(
    Product product,
    int quantity,
    OrderViewModel viewModel,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () => viewModel.removeProduct(product),
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
        ),
        Expanded(
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => viewModel.addProduct(product),
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
        ),
      ],
    );
  }

  // Helper for the bottom summary bar
  Widget _buildOrderSummaryBar(
    OrderViewModel orderViewModel,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    return Card(
      color: colorScheme.surfaceContainerHighest,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${orderViewModel.totalItems} Items',
                  style: textTheme.labelLarge,
                ),
                Text(
                  'Total: ₹${orderViewModel.totalPrice.toStringAsFixed(0)}',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            FilledButton(
              onPressed: orderViewModel.selectedProducts.isEmpty
                  ? null
                  : () {
                      setState(() {
                        _currentStep = 3;
                      });
                    },
              child: const Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentStep() {
    return Center(child: Text('Payment details'));
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
