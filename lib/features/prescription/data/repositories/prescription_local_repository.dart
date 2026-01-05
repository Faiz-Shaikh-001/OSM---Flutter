import 'package:isar/isar.dart';
import 'package:osm/features/customer/data/models/customer_model.dart';
import 'package:osm/features/doctors/data/models/doctor_model.dart';
import 'package:osm/features/prescription/data/models/prescription_model.dart';

class PrescriptionLocalRepository {
  PrescriptionLocalRepository();

  Future<int> insert(
    PrescriptionModel prescription,
    CustomerModel customer,
    DoctorModel? doctor, {
    required Isar isar,
  }) async {
    final id = await isar.prescriptionModels.put(prescription);

    prescription.customer.value = customer;

    await prescription.customer.save();

    if (doctor != null) {
      prescription.doctor.value = doctor;
      await prescription.doctor.save();
    }
    
    return id;
  }

  Future<List<PrescriptionModel>> getByCustomer(CustomerModel customer) async {
    await customer.prescriptions.load();

    final list = customer.prescriptions.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return list;
  }

  Future<PrescriptionModel?> getLatestByCustomer(CustomerModel customer) async {
    final list = await getByCustomer(customer);
    return list.isEmpty ? null : list.first;
  }

  Future<PrescriptionModel?> getById(int id, {required Isar isar}) async {
    return isar.prescriptionModels.get(id);
  }

  Future<void> delete(int id, {required Isar isar}) async {
    await isar.prescriptionModels.delete(id);
  }
}
