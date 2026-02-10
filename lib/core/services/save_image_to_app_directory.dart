import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> saveImageToAppDirectory(File imageFile) async {
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final String appDocPath = appDocDir.path;
  final String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
  final String newPath = '$appDocPath/$fileName';
  final File newImage = await imageFile.copy(newPath);
  return newImage.path;
}
