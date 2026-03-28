//DEBUG VERSION - NOT FINAL CODE
import 'dart:convert';
import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class BackupZipService {
  Future<File> createBackupZip() async {
    final docDir = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();

    final formattedDate =
        DateFormat('yyyy_MM_dd_HH_mm_ss').format(DateTime.now());

    final zipPath = '${tempDir.path}/osm_backup_$formattedDate.zip';
    final stagingPath = '${tempDir.path}/osm_backup_staging_$formattedDate';

    final resultPath = await compute(
      _createBackupZipInBackground,
      BackupJobData(
        documentsPath: docDir.path,
        zipPath: zipPath,
        stagingPath: stagingPath,
      ),
    );

    return File(resultPath);
  }
}

class BackupJobData {
  final String documentsPath;
  final String zipPath;
  final String stagingPath;

  const BackupJobData({
    required this.documentsPath,
    required this.zipPath,
    required this.stagingPath,
  });
}

Future<String> _createBackupZipInBackground(BackupJobData data) async {
  final stagingDir = Directory(data.stagingPath);

  if (stagingDir.existsSync()) {
    stagingDir.deleteSync(recursive: true);
  }
  stagingDir.createSync(recursive: true);

  final dbDir = Directory('${stagingDir.path}/db')..createSync(recursive: true);
  final imagesDir =
      Directory('${stagingDir.path}/images')..createSync(recursive: true);

  final sourceDir = Directory(data.documentsPath);

  if (sourceDir.existsSync()) {
    final entities = sourceDir.listSync(recursive: true, followLinks: false);

    print('===== DOCUMENTS DIRECTORY FILES =====');
    for (final entity in entities) {
      print(entity.path);
    }
    print('====================================');

    for (final entity in entities) {
      if (entity is! File) continue;

      final filePath = entity.path;
      final fileName = p.basename(filePath);
      final lower = fileName.toLowerCase();

      try {
        // Backup Isar DB files
        if (lower.endsWith('.isar')) {
          final targetFile = File('${dbDir.path}/$fileName');
          await entity.copy(targetFile.path);
          print('Copied DB file: $fileName');
          continue;
        }

        // Backup image files
        if (_isImageFile(lower)) {
          final targetFile = File('${imagesDir.path}/$fileName');
          await entity.copy(targetFile.path);
          print('Copied image file: $fileName');
          continue;
        }
      } catch (e) {
        print('Skipped file during backup: $filePath');
        print('Reason: $e');
      }
    }
  }

  // Add metadata.json
  final metadataFile = File('${stagingDir.path}/metadata.json');
  await metadataFile.writeAsString(
    jsonEncode({
      'app': 'OSM',
      'backup_type': 'full',
      'created_at': DateTime.now().toIso8601String(),
      'includes': ['isar_database', 'images'],
    }),
  );

  final encoder = ZipFileEncoder();
  encoder.create(data.zipPath);
  encoder.addDirectory(stagingDir);
  encoder.close();

  if (stagingDir.existsSync()) {
    stagingDir.deleteSync(recursive: true);
  }

  return data.zipPath;
}

bool _isImageFile(String fileName) {
  return fileName.endsWith('.png') ||
      fileName.endsWith('.jpg') ||
      fileName.endsWith('.jpeg') ||
      fileName.endsWith('.webp');
}