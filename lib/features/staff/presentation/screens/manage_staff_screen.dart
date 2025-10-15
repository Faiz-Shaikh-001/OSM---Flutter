import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/features/staff/models/staff_model.dart';
import 'package:osm/features/staff/presentation/screens/invite_staff_screen.dart';

class ManageStaffScreen extends StatefulWidget {
  const ManageStaffScreen({super.key});

  @override
  State<ManageStaffScreen> createState() => _ManageStaffScreenState();
}

class _ManageStaffScreenState extends State<ManageStaffScreen> {
  final IsarService isarService = IsarService();
  late Isar isar;
  List<Staff> _staffList = [];
  bool _isDbReady = false;

  @override
  void initState() {
    super.initState();
    _initializeDbAndListen();
  }

  Future<void> _initializeDbAndListen() async {
    isar = await isarService.db;
    setState(() => _isDbReady = true);
    _listenForStaffChanges();
  }

  void _listenForStaffChanges() {
    isar.staffs.watchLazy(fireImmediately: true).listen((_) {
      if (mounted) _loadStaff();
    });
  }

  Future<void> _loadStaff() async {
    final staff = await isar.staffs.where().findAll();
    if (mounted) setState(() => _staffList = staff);
  }

  Future<void> _addOrUpdateStaff(Staff staff) async {
    await isar.writeTxn(() async => await isar.staffs.put(staff));
  }

  Future<void> _deleteStaff(int staffId) async {
    await isar.writeTxn(() async => await isar.staffs.delete(staffId));
  }

  void _navigateAndInviteStaff() async {
    final newStaff = await Navigator.of(context).push<Staff>(
      MaterialPageRoute(builder: (context) => const InviteStaffScreen()),
    );
    if (newStaff != null && mounted) await _addOrUpdateStaff(newStaff);
  }

  void _navigateAndEditStaff(Staff staff) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => InviteStaffScreen(staffToEdit: staff)),
    );

    if (!mounted) return;

    if (result is Staff) {
      await _addOrUpdateStaff(result);
    } else if (result == true) {
      await _deleteStaff(staff.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Staff'),
      ),
      body: !_isDbReady
          ? const Center(child: CircularProgressIndicator())
          : _staffList.isEmpty
              ? _buildEmptyState()
              : _buildStaffList(),
      floatingActionButton: _staffList.isEmpty
          ? null
          : FloatingActionButton(
              onPressed: _navigateAndInviteStaff,
              tooltip: 'Invite Staff',
              child: const Icon(Icons.add),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.people_outline, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          const Text('No staff members have been added yet.', style: TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Invite First Staff Member'),
            onPressed: _navigateAndInviteStaff,
          ),
        ],
      ),
    );
  }

  Widget _buildStaffList() {
    return ListView.builder(
      itemCount: _staffList.length,
      itemBuilder: (context, index) {
        final staff = _staffList[index];
        final roleName = staff.role.name[0].toUpperCase() + staff.role.name.substring(1);
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(staff.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(staff.email), // Subtitle is now just the email
            // --- NEW: A Row widget to hold both the Chip and the Button ---
            trailing: Row(
              mainAxisSize: MainAxisSize.min, // Keeps the Row compact
              children: [
                Chip(
                  label: Text(roleName),
                  backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  tooltip: 'Edit Staff Member',
                  onPressed: () => _navigateAndEditStaff(staff),
                ),
              ],
            ),
            // The whole tile is still tappable as a larger, convenient touch area
            onTap: () => _navigateAndEditStaff(staff),
          ),
        );
      },
    );
  }
}

