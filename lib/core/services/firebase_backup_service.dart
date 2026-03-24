import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseBackupService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

 /// Get Isar DB path
  Future<Directory> _getAppDir() async {
    return await getApplicationDocumentsDirectory();
  }

  /// Create backup folder
  Future<Directory> _createBackupFolder() async {
    final dir = await _getAppDir();
    final backupDir = Directory('${dir.path}/backup_temp');

    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }

    return backupDir;
  }

  /// Copy all app data (DB + images)
  Future<void> _copyAppData(Directory backupDir) async {
    final appDir = await _getAppDir();

    final entities = appDir.listSync(recursive: true);

    for (var entity in entities) {
      if (entity is File) {
        final newPath = entity.path.replaceFirst(appDir.path, backupDir.path);
        final newFile = File(newPath);

        await newFile.create(recursive: true);
        await newFile.writeAsBytes(await entity.readAsBytes());
      }
    }
  }

  /// Upload backup to Firebase
  Future<void> uploadBackup() async {
    final backupDir = await _createBackupFolder();

    await _copyAppData(backupDir);

    final files = backupDir.listSync(recursive: true);

    for (var file in files) {
      if (file is File) {
        final fileName = file.path.split('/').last;

        await _storage
            .ref('backups/$fileName')
            .putFile(file);
      }
    }
  }
}