import "dart:async";
import 'package:flutter/material.dart';
import 'package:osm/features/customer/data/customer_model.dart';
import 'package:osm/features/customer/presentation/screens/add_new_customer_form.dart';
import 'package:osm/features/orders/presentation/screens/customer_step/widgets/customer_search.dart';
import 'package:osm/features/customer/viewmodel/customer_viewmodel.dart';
import 'package:osm/features/orders/presentation/screens/customer_step/widgets/customer_search_results.dart';
import 'package:osm/features/orders/presentation/screens/customer_step/widgets/initial_prompt_view.dart';
import 'package:osm/features/orders/presentation/screens/customer_step/widgets/selected_customer_view.dart';
import 'package:osm/features/orders/viewmodel/order_viewmodel.dart';
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
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (mounted) setState(() {});

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (query.trim().isEmpty) {
      context.read<CustomerViewModel>().clearSearchResults();
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        context.read<CustomerViewModel>().searchCustomers(query);
      }
    });
  }

  void _navigateToAddCustomer() async {
    final newCustomer = await Navigator.of(context).push<CustomerModel>(
      MaterialPageRoute(
        builder: (context) => const AddNewCustomerForm(fromCustomerStep: true),
      ),
    );
    if (newCustomer != null && mounted) {
      context.read<OrderViewModel>().selectCustomer(newCustomer);
      _searchController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderViewModel = context.watch<OrderViewModel>();

    return Column(
      children: [
        CustomerSearch(
          controller: _searchController,
          onChanged: _onSearchChanged,
        ),
        Expanded(child: _buildContentArea(orderViewModel)),
      ],
    );
  }

  Widget _buildContentArea(OrderViewModel orderViewModel) {
    if (_searchController.text.isNotEmpty) {
      return CustomerSearchResults(
        onCustomerSelected: (customer) {
          context.read<OrderViewModel>().selectCustomer(customer);
          _searchController.clear();
          context.read<CustomerViewModel>().clearSearchResults();
        },
        onAddNew: _navigateToAddCustomer,
      );
    }

    if (orderViewModel.selectedCustomer != null) {
      return SelectedCustomerView(
        customer: orderViewModel.selectedCustomer!,
        onRemove: () => context.read<OrderViewModel>().removeCustomer(),
        onNext: widget.onNext,
      );
    }

    return const InitialPromptView();
  }
}
