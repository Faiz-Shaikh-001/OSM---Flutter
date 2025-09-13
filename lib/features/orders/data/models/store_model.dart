import 'package:isar/isar.dart';

// You will need to run the build runner to generate this file:
// flutter pub run build_runner build
part 'store_model.g.dart';

@Collection()
class Store {
  Id id = Isar.autoIncrement; // Isar's auto-incrementing ID

  final String name;
  
  final String address;
  
  final String city;
  
  final String phone;

  Store({
    required this.name,
    required this.address,
    required this.city,
    required this.phone,
  });
}