part of 'doctor_bloc.dart';

@immutable
sealed class DoctorEvent {}

class LoadDoctors extends DoctorEvent {}

class LoadDoctorsByStore extends DoctorEvent {
  final StoreLocationId storeLocationId;

  LoadDoctorsByStore(this.storeLocationId);
}
