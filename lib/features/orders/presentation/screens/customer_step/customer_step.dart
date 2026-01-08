import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/customer/presentation/bloc/customer/customer_bloc.dart';
import 'package:osm/features/customer/presentation/screens/add_new_customer_form.dart';
import 'package:osm/features/orders/presentation/blocs/order_draft/order_draft_bloc.dart';
import 'package:osm/features/orders/presentation/screens/customer_step/widgets/customer_search.dart';
import 'package:osm/features/orders/presentation/screens/customer_step/widgets/customer_search_results.dart';
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

          return Column(
            children: [
              Expanded(
                child: selectedCustomerId == null
                    ? _CustomerSearchSection()
                    : _SelectedCustomerSection(
                        customerId: selectedCustomerId,
                        onNext: onNext,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CustomerSearchSection extends StatefulWidget {
  @override
  State<_CustomerSearchSection> createState() => _CustomerSearchSectionState();
}

class _CustomerSearchSectionState extends State<_CustomerSearchSection> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomerSearch(
          controller: _controller,
          onChanged: (query) {
            context.read<CustomerBloc>().add(SearchCustomersEvent(query));
          },
        ),
        Expanded(
          child: BlocBuilder<CustomerBloc, CustomerState>(
            builder: (context, state) {
              return CustomerSearchResults(
                isLoading: state is CustomerLoading,
                results: state is CustomerLoaded ? state.customers : const [],
                onCustomerSelected: (customer) {
                  context.read<OrderDraftBloc>().add(
                    CustomerSelected(customer.id!),
                  );
                },
                onAddNew: () async {
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
                    context.read<CustomerBloc>().add(
                      AddCustomerEvent(customer),
                    );
                    context.read<OrderDraftBloc>().add(
                      CustomerSelected(customer.id!),
                    );
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SelectedCustomerSection extends StatelessWidget {
  final CustomerId customerId;
  final VoidCallback onNext;

  const _SelectedCustomerSection({
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

        final customer = state.customers.firstWhere(
          (c) => c.id == customerId,
        );

        return SelectedCustomerView(
          customer: customer,
          onRemove: () {
            context.read<OrderDraftBloc>().add(CustomerRemoved());
          },
          onNext: onNext,
        );
      },
    );
  }
}
