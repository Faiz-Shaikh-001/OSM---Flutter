import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/customer/presentation/bloc/customer/customer_bloc.dart';
import 'package:osm/features/customer/presentation/screens/add_new_customer_form.dart';
import 'package:osm/features/orders/presentation/blocs/order_draft/order_draft_bloc.dart';
import 'package:osm/features/orders/presentation/screens/customer_step/widgets/selected_customer_view.dart';

class CustomerStep extends StatelessWidget {
  final VoidCallback onNext;

  const CustomerStep({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<OrderDraftBloc, OrderDraftState>(
        builder: (context, draftState) {
          final selectedCustomerId = draftState.draft.customerId;

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: selectedCustomerId == null
                ? _CustomerSearchSection(key: const ValueKey('search'))
                : _SelectedCustomerSection(
                    key: const ValueKey('selected'),
                    customerId: selectedCustomerId,
                    onNext: onNext,
                  ),
          );
        },
      ),
    );
  }
}

class _CustomerSearchSection extends StatefulWidget {
  const _CustomerSearchSection({super.key});

  @override
  State<_CustomerSearchSection> createState() => _CustomerSearchSectionState();
}

class _CustomerSearchSectionState extends State<_CustomerSearchSection> {
  final _controller = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  void _onAddNew(BuildContext context) async {
    final customer = await Navigator.push<Customer>(
      context,
      MaterialPageRoute(
        builder: (newContext) => BlocProvider.value(
          value: context.read<CustomerBloc>(),
          child: const AddNewCustomerForm(),
        ),
      ),
    );

    if (customer != null && context.mounted) {
      // Add to global customer list
      context.read<CustomerBloc>().add(AddCustomerEvent(customer));
      // Select it immediately for the order
      context.read<OrderDraftBloc>().add(CustomerSelected(customer.id!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: TextField(
            controller: _controller,
            focusNode: _searchFocus,
            onChanged: (query) {
              context.read<CustomerBloc>().add(SearchCustomersEvent(query));
            },
            decoration: InputDecoration(
              hintText: "Search name or phone...",
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.person_add_alt_1, color: Colors.blue),
                onPressed: () => _onAddNew(context),
                tooltip: "Add new Customer",
              ),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),

        Expanded(
          child: BlocBuilder<CustomerBloc, CustomerState>(
            builder: (context, state) {
              if (state is CustomerLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final customers = state is CustomerLoaded
                  ? state.customers
                  : <Customer>[];

              if (customers.isEmpty) {
                return _buildEmptyState(context);
              }

              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: customers.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final customer = customers[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                    leading: _buildAvatar(customer.firstName),
                    title: Text(
                      customer.fullName,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(customer.primaryPhoneNumber),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onTap: () {
                      context.read<OrderDraftBloc>().add(
                        CustomerSelected(customer.id!),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final isQueryEmpty = _controller.text.isEmpty;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isQueryEmpty ? Icons.person_search : Icons.person_off,
            size: 64,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            isQueryEmpty ? "Find a Customer" : "No customer found",
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          if (!isQueryEmpty) ...[
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () => _onAddNew(context),
              icon: const Icon(Icons.add),
              label: const Text("Create New Customer"),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAvatar(String name) {
    final initials = name.isNotEmpty ? name[0].toUpperCase() : "?";
    return CircleAvatar(
      radius: 24,
      backgroundColor: Colors.blue[100],
      child: Text(
        initials,
        style: TextStyle(color: Colors.blue[800], fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _SelectedCustomerSection extends StatelessWidget {
  final CustomerId customerId;
  final VoidCallback onNext;

  const _SelectedCustomerSection({
    super.key,
    required this.customerId,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerBloc, CustomerState>(
      builder: (context, state) {
        if (state is! CustomerLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        final customer = state.customers.firstWhere((c) => c.id == customerId);

        return Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SelectedCustomerView(
                    customer: customer,
                    onRemove: () {
                      context.read<OrderDraftBloc>().add(CustomerRemoved());
                    },
                    onNext: onNext,
                  ),
                ),
              ),
            ),
            _buildBottomBar(context),
          ],
        );
      },
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black12)),
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: onNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black87,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "Confirm & Continue",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
