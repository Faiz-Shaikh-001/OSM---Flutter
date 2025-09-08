import 'package:flutter/material.dart';

class CustomerDetailPage extends StatelessWidget {
  const CustomerDetailPage({super.key});

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
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/avatar.png'),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Faiz Ahmed",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: const [
                      Chip(label: Text("Age 26")),
                      Chip(label: Text("Gold Member")),
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
                  children: const [
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
                      title: Text("+91 9876543210"),
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text("faiz@email.com"),
                    ),
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text("Mumbai, India"),
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
                subtitle: const Text("Progressive | 2025-06-12"),
                children: const [
                  ListTile(
                    title: Text("2025-06-12"),
                    subtitle: Text("Single Vision | OD: -1.5 | OS: -1.75"),
                  ),
                  ListTile(
                    title: Text("2024-03-05"),
                    subtitle: Text("Progressive | OD: -1.0 | OS: -2.0"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Orders Card
            Card(
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
                    leading: Icon(Icons.check_circle, color: Colors.green),
                    title: Text("RayBan Frame"),
                    subtitle: Text("₹4500 | 2025-08-02"),
                    trailing: Text(
                      "Completed",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.pending_actions, color: Colors.orange),
                    title: Text("Acuvue Contact Lenses"),
                    subtitle: Text("₹2200 | 2025-08-18"),
                    trailing: Text(
                      "Pending",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Reminders Card
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
                    const Text(
                      "Reminders",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const ListTile(
                      leading: Icon(Icons.alarm),
                      title: Text("Lens replacement due in 2 weeks"),
                    ),
                    const ListTile(
                      leading: Icon(Icons.calendar_month),
                      title: Text("Next eye test: Apr 2026"),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.send),
                      label: Text("Send Reminder"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size.fromHeight(45),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Insights Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Column(
                      children: [
                        Text(
                          "₹35,000",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Total Spend"),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "2 months",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Last Visit"),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Progressive",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Fav Product"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
