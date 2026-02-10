import 'package:osm/features/customer/domain/entities/customer_type.dart';

extension CustomerTypeUi on CustomerType {
  String get label {
    switch (this) {
      case CustomerType.walkIn:
        return 'Walk-in';
      case CustomerType.regular:
        return 'Regular';
      case CustomerType.vip:
        return 'VIP';
      case CustomerType.wholesale:
        return 'Wholesale';
      case CustomerType.corporate:
        return 'Corporate';
      case CustomerType.insurance:
        return 'Insurance';
      case CustomerType.medical:
        return 'Medical';
    }
  }
}
