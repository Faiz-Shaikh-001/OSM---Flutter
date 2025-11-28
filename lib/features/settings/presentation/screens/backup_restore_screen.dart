import 'package:flutter/material.dart';
import 'package:osm/core/services/isar_service.dart';

class BackupRestoreScreen extends StatefulWidget {
  const BackupRestoreScreen({super.key});

  @override
  State<BackupRestoreScreen> createState() => _BackupRestoreScreenState();
}

class _BackupRestoreScreenState extends State<BackupRestoreScreen> {
  final IsarService _isarService = IsarService();
  bool _isProcessing = false;

  Future<void> _createBackup() async {
    setState(() => _isProcessing = true);
    
    try {
      // 1. Get the DB instance
      final isar = await _isarService.db;
      
      // 2. Define a name for the backup (e.g., with timestamp)
      final DateTime now = DateTime.now();
      final String fileName = 'osm_backup_${now.year}${now.month}${now.day}_${now.hour}${now.minute}.isar';

      // TODO: Implement actual file saving logic here
      // This usually requires 'path_provider' to find a temp dir
      // and 'share_plus' to export the file to the user.
      
      // Simulation delay
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Backup "$fileName" created successfully! (Simulation)')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Backup failed: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  Future<void> _restoreBackup() async {
    // Warning Dialog before proceeding
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restore Backup'),
        content: const Text(
          'Restoring from a backup will OVERWRITE all current data.\n\nAre you sure you want to proceed?',
          style: TextStyle(color: Colors.red),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Restore'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => _isProcessing = true);

    try {
      // TODO: Implement file picker logic here using 'file_picker' package
      // 1. Pick file
      // 2. Validate file
      // 3. Close current Isar instance
      // 4. Overwrite database file
      // 5. Re-open Isar instance

      await Future.delayed(const Duration(seconds: 2)); // Simulation

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data restored successfully! (Simulation)')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Restore failed: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Backup & Restore'),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildBackupCard(
                context,
                icon: Icons.cloud_upload_outlined,
                title: 'Create Backup',
                description: 'Save a copy of your database to your device storage or share it.',
                buttonText: 'Backup Now',
                onTap: _createBackup,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              _buildBackupCard(
                context,
                icon: Icons.cloud_download_outlined,
                title: 'Restore Data',
                description: 'Import a previously saved backup file to restore your data.',
                buttonText: 'Restore from File',
                onTap: _restoreBackup,
                color: Colors.orange,
                isDestructive: true,
              ),
            ],
          ),
          if (_isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBackupCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onTap,
    required Color color,
    bool isDestructive = false,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.1),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(color: Colors.grey[700], height: 1.4),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.tonal(
                style: FilledButton.styleFrom(
                  backgroundColor: isDestructive ? Colors.red.shade50 : color.withOpacity(0.1),
                  foregroundColor: isDestructive ? Colors.red : color,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: onTap,
                child: Text(buttonText, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}