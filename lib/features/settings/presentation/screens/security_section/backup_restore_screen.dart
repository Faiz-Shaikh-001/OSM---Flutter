import 'dart:async';
import 'package:flutter/material.dart';
import 'package:osm/core/services/backup_preview_service.dart';
import 'package:osm/core/services/backup_zip_service.dart';
import 'package:osm/core/services/google_drive_backup_service.dart';

class BackupRestoreScreen extends StatefulWidget {
  const BackupRestoreScreen({super.key});

  @override
  State<BackupRestoreScreen> createState() => _BackupRestoreScreenState();
}

class _BackupRestoreScreenState extends State<BackupRestoreScreen> {
  bool _isBackingUp = false;
  double _progress = 0.0;
  Timer? _progressTimer;

  Future<void> _handleBackup() async {
    setState(() {
      _isBackingUp = true;
      _progress = 0.0;
    });

    _startFakeProgress();

    try {
      // Step 1: Create ZIP
      final zipFile = await BackupZipService().createBackupZip();

      final zipSize = await zipFile.length();

      debugPrint('ZIP PATH: ${zipFile.path}');
      debugPrint('ZIP SIZE: $zipSize bytes');

      // move progress near completion
      setState(() {
        _progress = 0.92;
      });

      // Step 2: Upload to Google Drive
      await GoogleDriveBackupService().uploadBackup(zipFile);

      _progressTimer?.cancel();

      if (!mounted) return;

      setState(() {
        _progress = 1.0;
      });

      await Future.delayed(const Duration(milliseconds: 400));

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            zipSize > 0
                ? 'Backup uploaded to Google Drive!'
                : 'Warning: ZIP file size is 0 bytes',
          ),
        ),
      );
    } catch (e) {
      _progressTimer?.cancel();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Backup failed: $e')),
      );
    } finally {
      await Future.delayed(const Duration(milliseconds: 300));

      if (!mounted) return;

      setState(() {
        _isBackingUp = false;
        _progress = 0.0;
      });
    }
  }

  Future<void> _showBackupPreview() async {
    try {
      final result = await BackupPreviewService().scanBackupContents();

      if (!mounted) return;

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (context) {
          final dbItems = result.items.where((e) => e.category == 'db').toList();
          final imageItems =
              result.items.where((e) => e.category == 'image').toList();

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Backup Preview',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),

                    Text('DB Files: ${dbItems.length}'),
                    Text('Images: ${imageItems.length}'),
                    Text('Total Size: ${_formatBytes(result.totalBytes)}'),

                    const SizedBox(height: 16),

                    Expanded(
                      child: ListView(
                        children: [
                          if (dbItems.isNotEmpty) ...[
                            const Text(
                              'Database',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            ...dbItems.map(
                              (item) => ListTile(
                                dense: true,
                                leading: const Icon(Icons.storage),
                                title: Text(item.fileName),
                                subtitle: Text(
                                  '${_formatBytes(item.sizeBytes)}\n${item.fullPath}',
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],

                          if (imageItems.isNotEmpty) ...[
                            const Text(
                              'Images',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            ...imageItems.map(
                              (item) => ListTile(
                                dense: true,
                                leading: const Icon(Icons.image_outlined),
                                title: Text(item.fileName),
                                subtitle: Text(
                                  '${_formatBytes(item.sizeBytes)}\n${item.fullPath}',
                                ),
                              ),
                            ),
                          ],

                          if (result.items.isEmpty)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 40),
                                child: Text('No backupable files found'),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preview failed: $e')),
      );
    }
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }

  void _startFakeProgress() {
    _progressTimer?.cancel();

    _progressTimer = Timer.periodic(const Duration(milliseconds: 120), (timer) {
      if (!mounted) return;

      setState(() {
        if (_progress < 0.15) {
          _progress += 0.03;
        } else if (_progress < 0.40) {
          _progress += 0.02;
        } else if (_progress < 0.70) {
          _progress += 0.015;
        } else if (_progress < 0.90) {
          _progress += 0.008;
        } else {
          timer.cancel();
        }

        if (_progress > 0.90) {
          _progress = 0.90;
        }
      });
    });
  }

  void _handleRestore() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Restore will be implemented next')),
    );
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final percent = (_progress * 100).toInt();

    return Scaffold(
      appBar: AppBar(title: const Text('Backup & Restore')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_isBackingUp)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: _progress,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '$percent%',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: _isBackingUp ? null : _showBackupPreview,
                icon: const Icon(Icons.visibility_outlined),
                label: const Text('Preview Backup Contents'),
              ),
            ),
            const SizedBox(height: 8),

            _BackupCard(
              icon: Icons.cloud_upload_outlined,
              title: 'Create Backup',
              description:
                  'Save a copy of your app data including database and images.',
              buttonText: _isBackingUp ? 'Backing Up...' : 'Backup Now',
              buttonColor: colorScheme.primary,
              textColor: colorScheme.onPrimary,
              isDisabled: _isBackingUp,
              onPressed: _handleBackup,
            ),

            const SizedBox(height: 16),

            _BackupCard(
              icon: Icons.cloud_download_outlined,
              title: 'Restore Data',
              description:
                  'Import a previously saved backup to restore your app data.',
              buttonText: 'Restore Backup',
              buttonColor: colorScheme.surfaceContainerHighest,
              textColor: colorScheme.error,
              isDisabled: _isBackingUp,
              onPressed: _handleRestore,
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
  final bool isDisabled;

  const _BackupCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.buttonColor,
    required this.textColor,
    required this.onPressed,
    this.isDisabled = false,
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
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(description, style: theme.textTheme.bodySmall),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: textColor,
                  disabledBackgroundColor: buttonColor.withValues(alpha: 0.5),
                  disabledForegroundColor: textColor.withValues(alpha: 0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: isDisabled ? null : onPressed,
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}