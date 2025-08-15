// lib/screens/customer_step_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:osm/data/models/customer_model.dart';
import 'package:osm/screens/addOrderScreens/add_new_customer_form.dart';
import 'package:osm/screens/addOrderScreens/selected_customer_card.dart';
import 'package:osm/viewmodels/customer_viewmodel.dart';
import 'package:osm/viewmodels/order_viewmodel.dart';
import 'package:osm/widgets/custom_button.dart'; // Assuming you have this
import 'package:provider/provider.dart';

class CustomerStepScreen extends StatefulWidget {
  final VoidCallback onNext;
  const CustomerStepScreen({super.key, required this.onNext});

  @override
  State<CustomerStepScreen> createState() => _CustomerStepScreenState();
}

class _CustomerStepScreenState extends State<CustomerStepScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    // Add a listener to rebuild the widget when the search text changes
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(() {
      setState(() {});
    });
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        context.read<CustomerViewModel>().searchCustomers(query);
      }
    });
  }

  void _navigateToAddCustomer() async {
    final newCustomer = await Navigator.of(context).push<CustomerModel>(
      MaterialPageRoute(builder: (context) => const AddNewCustomerForm()),
    );
    if (newCustomer != null && mounted) {
      context.read<OrderViewModel>().selectCustomer(newCustomer);
      _searchController.clear(); // Clear search to show the new customer
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search customer or add new...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),

        Expanded(child: _buildContentArea()),
      ],
    );
  }

  /// Determines which widget to show below the search bar.
  Widget _buildContentArea() {
    final orderViewModel = context.watch<OrderViewModel>();

    // Priority 1: If the user is typing, always show search results.
    if (_searchController.text.isNotEmpty) {
      return _buildSearchResultsView();
    }

    // Priority 2: If not searching, show the selected customer if there is one.
    if (orderViewModel.selectedCustomer != null) {
      return _buildSelectedCustomerView(orderViewModel);
    }

    // Priority 3: Default view when nothing is searched or selected.
    return _buildInitialPromptView();
  }

  /// Shows the list of search results.
  Widget _buildSearchResultsView() {
    return Consumer<CustomerViewModel>(
      builder: (context, customerViewModel, child) {
        if (customerViewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (customerViewModel.searchResults.isEmpty) {
          return _buildNoResultsFound();
        }

        return ListView.builder(
          itemCount: customerViewModel.searchResults.length,
          itemBuilder: (context, index) {
            final customer = customerViewModel.searchResults[index];
            return Card(
              child: ListTile(
                title: Text('${customer.firstName} ${customer.lastName}'),
                subtitle: Text(customer.primaryPhoneNumber),
                onTap: () {
                  context.read<OrderViewModel>().selectCustomer(customer);
                  // Clearing the search bar is key to revealing the selected customer view
                  _searchController.clear();
                  context.read<CustomerViewModel>().clearSearchResults();
                },
              ),
            );
          },
        );
      },
    );
  }

  /// Shows the card for the currently selected customer.
  Widget _buildSelectedCustomerView(OrderViewModel orderViewModel) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: SelectedCustomerCard(
              customer: orderViewModel.selectedCustomer!,
              onRemove: () {
                context.read<OrderViewModel>().resetForm();
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        CustomButton(label: 'Next Step', onPressed: widget.onNext),
        const SizedBox(height: 16),
      ],
    );
  }

  /// Shows a prompt to the user when the screen is empty.
  Widget _buildInitialPromptView() {
    return const Center(
      child: Text(
        'Search for a customer to begin.',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  /// Shows a message when a search yields no results.
  Widget _buildNoResultsFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person_search, size: 50, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'No customers found.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          FilledButton.tonal(
            onPressed: _navigateToAddCustomer,
            child: const Text('Add New Customer'),
          ),
        ],
      ),
    );
  }
}
