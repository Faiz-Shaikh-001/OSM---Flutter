abstract class UniqueId {
  final String value;
  const UniqueId(this.value);

  @override
  String toString() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UniqueId &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

class OrderId extends UniqueId {
  const OrderId(super.value);
  
  factory OrderId.empty() => const OrderId('');
}

class CustomerId extends UniqueId {
  const CustomerId(super.value);
}

class ProductId extends UniqueId {
  const ProductId(super.value);
}

class FrameId extends UniqueId {
  const FrameId(super.value);
}

class LensId extends UniqueId {
  const LensId(super.value);
}

class AccessoryId extends UniqueId {
  const AccessoryId(super.value);
}

class DoctorId extends UniqueId {
  const DoctorId(super.value);
}

class PrescriptionId extends UniqueId {
  const PrescriptionId(super.value);
}

class StoreLocationId extends UniqueId {
  const StoreLocationId(super.value);
}

class StaffId extends UniqueId {
  const StaffId(super.value);
}