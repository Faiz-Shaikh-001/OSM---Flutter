import 'package:flutter/material.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/features/customer/data/customer_model.dart';
import 'package:osm/features/customer/services/build_customer_image.dart';
import 'package:osm/features/orders/data/models/order_model.dart';
import 'package:osm/features/orders/data/repositories/order_repository.dart';
import 'package:provider/provider.dart';

class CustomerDetailsScreen extends StatelessWidget {
  final CustomerModel customer;

  const CustomerDetailsScreen({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Detail"),
        actions: [IconButton(icon: const Icon(Icons.edit), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header - Avatar + Name + Chips
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: buildCustomerImage(
                      customer.profileImageUrl,
                    ),
                    onBackgroundImageError: (exception, stackTrace) {
                      debugPrint('Error loading image: $exception');
                    },
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "${customer.firstName} ${customer.lastName}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(label: Text("Age ${customer.age}")),
                      Chip(label: Text(customer.gender)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Personal Info Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Personal Info",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text("+91 ${customer.primaryPhoneNumber}"),
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text(customer.email ?? "No Email"),
                    ),
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text(customer.city ?? 'Unknown'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Prescription Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: ExpansionTile(
                leading: const Icon(Icons.visibility),
                title: const Text("Latest Prescription"),
                subtitle: Text(
                  customer.prescriptions.isNotEmpty
                      ? "Latest: ${customer.prescriptions.last.prescriptionDate.toLocal().toString().split(" ").first}"
                      : "No prescriptions yet",
                ),
                children: customer.prescriptions.isNotEmpty
                    ? customer.prescriptions.map((p) {
                        return ListTile(
                          title: Text(
                            p.prescriptionDate
                                .toLocal()
                                .toString()
                                .split(" ")
                                .first,
                          ),
                          subtitle: Text(
                            "OD: ${p.sphereRight} | OS: ${p.sphereLeft}",
                          ),
                        );
                      }).toList()
                    : [const ListTile(title: Text("No prescription history"))],
              ),
            ),

            const SizedBox(height: 16),

            // Orders Card
            FutureBuilder(
              future: context.read<OrderRepository>().getOrdersForCustomer(customer.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "Orders",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.error, color: Colors.red),
                          title: Text("No orders yet."),
                        ),
                      ],
                    ),
                  );
                }

                final orders = snapshot.data!;
                return Column(
                  children: orders.map((o) {
                    return ListTile(
                      leading: Icon(
                        o.status == "Completed"
                            ? Icons.check_circle
                            : Icons.pending_actions,
                        color: o.status == "Completed"
                            ? Colors.green
                            : Colors.orange,
                      ),
                      title: Text("Order #${o.id}"),
                      subtitle: Text(
                        "₹${o.totalAmount} | ${o.orderDate.toLocal().toString().split(" ").first}",
                      ),
                      trailing: Text(
                        o.status,
                        style: TextStyle(
                          color: o.status == "Completed"
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            const SizedBox(height: 16),
            FutureBuilder(
              future: Future.wait([
                context.read<OrderRepository>().getOrdersForCustomer(customer.id),
                context.read<OrderRepository>().getLastVisitDate(customer.id),
              ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return const Text("No insights available");
                }

                final orders = snapshot.data![0] as List<OrderModel>;
                final lastVisit = snapshot.data![1] as DateTime?;

                final totalSpend = orders.fold(
                  0.0,
                  (sum, o) => sum + o.totalAmount,
                );
                final lastVisitText = lastVisit != null
                    ? "${DateTime.now().difference(lastVisit).inDays ~/ 30} months"
                    : "N/A";

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "₹${totalSpend.toStringAsFixed(0)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text("Total Spend"),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          lastVisitText,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text("Last Visit"),
                      ],
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
