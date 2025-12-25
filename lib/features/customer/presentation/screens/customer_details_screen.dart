import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/core/value_objects/money.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/customer/presentation/bloc/customer/customer_bloc.dart';
import 'package:osm/features/customer/presentation/bloc/customer_details/customer_details_bloc.dart';
import 'package:osm/features/customer/presentation/screens/add_new_customer_form.dart';
import 'package:osm/features/customer/services/build_customer_image.dart';
import 'package:osm/features/prescription/domain/usecases/add_prescription.dart';
import 'package:osm/features/prescription/presentation/bloc/add_prescription/bloc/add_prescription_bloc.dart';
import 'package:osm/features/prescription/presentation/bloc/prescription_timeline/bloc/prescription_timeline_bloc.dart';
import 'package:osm/features/prescription/presentation/screens/add_prescription_screen.dart';
import 'package:osm/features/prescription/presentation/widgets/prescription_timeline_section.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final CustomerId customerId;

  const CustomerDetailsScreen({super.key, required this.customerId});

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CustomerDetailsBloc>().add(
      LoadCustomerDetails(widget.customerId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerBloc, CustomerState>(
      listener: (context, state) {
        if (state is CustomerUpdated) {
          context.read<CustomerDetailsBloc>().add(
            LoadCustomerDetails(widget.customerId),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Customer Details'),
          actions: [
            BlocBuilder<CustomerDetailsBloc, CustomerDetailsState>(
              builder: (context, state) {
                if (state is! CustomerDetailsLoaded) {
                  return const SizedBox.shrink();
                }
                return IconButton(
                  onPressed: () async {
                    final updated = await showModalBottomSheet<Customer>(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => AddNewCustomerForm(
                        initialCustomer: state.details.customer,
                      ),
                    );

                    if (updated != null && context.mounted) {
                      context.read<CustomerBloc>().add(
                        UpdateCustomerEvent(updated),
                      );
                    }
                  },
                  icon: const Icon(Icons.edit),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<CustomerDetailsBloc, CustomerDetailsState>(
          builder: (context, state) {
            if (state is CustomerDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CustomerDetailsError) {
              return Center(child: Text(state.message));
            }

            if (state is CustomerDetailsLoaded) {
              final customer = state.details.customer;
              final orders = state.details.orders;

              final totalSpend = orders.fold<Money>(
                Money(0),
                (sum, o) => sum + o.totalAmount,
              );

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: buildCustomerImage(
                        customer.profileImageUrl,
                      ),
                      child: customer.profileImageUrl == null
                          ? const Icon(Icons.person, size: 40)
                          : null,
                    ),
                    const SizedBox(height: 12),

                    Text(
                      customer.fullName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 8,
                      children: [
                        Chip(label: Text(customer.gender.name.capitalize)),
                        Chip(
                          label: Text(customer.customerType.name.capitalize),
                        ),
                        if (customer.dateOfBirth != null)
                          Chip(label: Text('Age ${customer.age}')),
                      ],
                    ),

                    const SizedBox(height: 20),

                    _InfoCard(
                      title: 'Contact',
                      children: [
                        ListTile(
                          leading: const Icon(Icons.phone),
                          title: Text(customer.primaryPhoneNumber),
                        ),
                        if (customer.secondaryPhoneNumber != null)
                          ListTile(
                            leading: const Icon(Icons.settings_phone),
                            title: Text(customer.secondaryPhoneNumber!),
                          ),
                        if (customer.email != null)
                          ListTile(
                            leading: const Icon(Icons.email),
                            title: Text(customer.email!),
                          ),
                        if (customer.dateOfBirth != null)
                          ListTile(
                            leading: const Icon(Icons.cake),
                            title: Text(
                              'DOB: ${customer.dateOfBirth!.toLocal().toString().split(' ').first}',
                            ),
                          ),
                      ],
                    ),

                    _InfoCard(
                      title: "Address",
                      children: [
                        if (customer.streetAddress != null)
                          ListTile(
                            leading: const Icon(Icons.home),
                            title: Text(customer.streetAddress!),
                          ),
                        if (customer.city != null)
                          ListTile(
                            leading: const Icon(Icons.location_city),
                            title: Text(
                              "${customer.city!}, ${customer.state!}, ${customer.country!}",
                            ),
                          ),
                      ],
                    ),

                    if (customer.tags.isNotEmpty)
                      _InfoCard(
                        title: 'Tags',
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: customer.tags
                                  .map(
                                    (tag) => Chip(
                                      label: Text(tag),
                                      backgroundColor: Theme.of(
                                        context,
                                      ).colorScheme.secondaryContainer,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),

                    if (customer.notes != null && customer.notes!.isNotEmpty)
                      _InfoCard(
                        title: 'Notes',
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              customer.notes!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),

                    PrescriptionTimelineSection(
                      customerId: CustomerId(customer.id!),
                    ),

                    _InfoCard(
                      title: 'Orders',
                      children: orders.isEmpty
                          ? const [ListTile(title: Text('No orders yet'))]
                          : orders.map((o) {
                              return ListTile(
                                leading: const Icon(Icons.shopping_bag),
                                title: Text('Order #${o.id}'),
                                subtitle: Text('₹${o.totalAmount}'),
                              );
                            }).toList(),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _Metric(label: 'Total Spend', value: '₹$totalSpend'),
                        _Metric(
                          label: 'Orders',
                          value: orders.length.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (context) => AddPrescriptionBloc(
                    addPrescription: context.read<AddPrescription>(),
                  ),
                  child: AddPrescriptionScreen(customerId: widget.customerId),
                ),
              ),
            );

            if (context.mounted) {
              context.read<PrescriptionTimelineBloc>().add(
                LoadPrescriptionTimeline(widget.customerId),
              );
            }
          },
          tooltip: 'Add Prescription',
          child: const Icon(Icons.medical_information),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _InfoCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          ListTile(
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;

  const _Metric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }
}
