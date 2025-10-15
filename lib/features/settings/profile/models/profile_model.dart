import 'package:isar/isar.dart';
import '../../../orders/data/models/store_model.dart';

part 'profile_model.g.dart';

@Collection()
class UserProfile {
  Id id = 1;

  String? name;
  String? businessName;
  String? email;
  String? phone;
  String? address;
  String? profilePhotoPath;
  

  final currentBranch = IsarLink<Store>();
}
// To generate the code, run:
// flutter pub run build_runner build in terminal under root directory
