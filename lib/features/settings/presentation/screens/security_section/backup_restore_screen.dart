import 'package:flutter/material.dart';
import 'package:osm/core/services/firebase_backup_service.dart';

class BackupRestoreScreen extends StatelessWidget {
  const BackupRestoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Backup & Restore'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ───────────── Create Backup ─────────────
            _BackupCard(
              icon: Icons.cloud_upload_outlined,
              title: 'Create Backup',
              description:
                  'Save a copy of your database and images to Firebase.',
              buttonText: 'Backup Now',
              buttonColor: colorScheme.primary,
              textColor: colorScheme.onPrimary,
              onPressed: () async {
                final service = FirebaseBackupService();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Backup started...')),
                );

                try {
                  await service.uploadBackup();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Backup completed successfully ✅'),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Backup failed ❌: $e'),
                    ),
                  );
                }
              },
            ),

            const SizedBox(height: 16),

            // ───────────── Restore Data ─────────────
            _BackupCard(
              icon: Icons.cloud_download_outlined,
              title: 'Restore Data',
              description:
                  'Restore your data from Firebase backup (coming next).',
              buttonText: 'Restore',
              buttonColor: colorScheme.surfaceContainerHighest,
              textColor: colorScheme.error,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Restore coming soon...'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BackupCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  const _BackupCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.buttonColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 28, color: theme.colorScheme.primary),
            const SizedBox(height: 12),

            Text(
              title,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 8),

            Text(
              description,
              style: theme.textTheme.bodySmall,
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: textColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: onPressed,
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}