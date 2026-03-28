import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class BackupPreviewItem {
  final String category; // db / image
  final String fileName;
  final String fullPath;
  final int sizeBytes;

  BackupPreviewItem({
    required this.category,
    required this.fileName,
    required this.fullPath,
    required this.sizeBytes,
  });
}

class BackupPreviewResult {
  final List<BackupPreviewItem> items;
  final int totalBytes;

  BackupPreviewResult({
    required this.items,
    required this.totalBytes,
  });

  int get dbCount => items.where((e) => e.category == 'db').length;
  int get imageCount => items.where((e) => e.category == 'image').length;
}

class BackupPreviewService {
  Future<BackupPreviewResult> scanBackupContents() async {
    final docDir = await getApplicationDocumentsDirectory();
    final sourceDir = Directory(docDir.path);

    final List<BackupPreviewItem> items = [];
    int totalBytes = 0;

    if (!sourceDir.existsSync()) {
      return BackupPreviewResult(items: [], totalBytes: 0);
    }

    final entities = sourceDir.listSync(recursive: true, followLinks: false);

    for (final entity in entities) {
      if (entity is! File) continue;

      final filePath = entity.path;
      final fileName = p.basename(filePath);
      final lower = fileName.toLowerCase();

      if (_shouldSkipPath(filePath)) {
        continue;
      }

      try {
        final size = await entity.length();

        if (lower == 'default.isar') {
          items.add(
            BackupPreviewItem(
              category: 'db',
              fileName: fileName,
              fullPath: filePath,
              sizeBytes: size,
            ),
          );
          totalBytes += size;
          continue;
        }

        if (_isImageFile(lower)) {
          items.add(
            BackupPreviewItem(
              category: 'image',
              fileName: fileName,
              fullPath: filePath,
              sizeBytes: size,
            ),
          );
          totalBytes += size;
          continue;
        }
      } catch (_) {
        // ignore unreadable files
      }
    }

    return BackupPreviewResult(
      items: items,
      totalBytes: totalBytes,
    );
  }
}

bool _isImageFile(String fileName) {
  return fileName.endsWith('.png') ||
      fileName.endsWith('.jpg') ||
      fileName.endsWith('.jpeg') ||
      fileName.endsWith('.webp');
}

bool _shouldSkipPath(String path) {
  final lower = path.toLowerCase();

  return lower.contains('/backup_temp') ||
      lower.contains('\\backup_temp') ||
      lower.contains('/flutter_assets') ||
      lower.contains('\\flutter_assets') ||
      lower.contains('res_timestamp') ||
      lower.endsWith('.lock');
}