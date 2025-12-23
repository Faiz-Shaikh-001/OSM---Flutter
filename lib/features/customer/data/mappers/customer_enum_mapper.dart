import 'package:osm/features/customer/data/enums/customer_type_model.dart';
import 'package:osm/features/customer/data/enums/gender_model.dart';
import 'package:osm/features/customer/domain/entities/customer_type.dart';

class CustomerEnumMapper {
  static GenderModel toGenderModel(Gender gender) {
    switch (gender) {
      case Gender.male:
        return GenderModel.male;
      case Gender.female:
        return GenderModel.female;
      case Gender.other:
        return GenderModel.other;
    }
  }

  static Gender toGender(GenderModel model) {
    switch (model) {
      case GenderModel.male:
        return Gender.male;
      case GenderModel.female:
        return Gender.female;
      case GenderModel.other:
        return Gender.other;
    }
  }

  static CustomerTypeModel toCustomerTypeModel(CustomerType type) {
    switch (type) {
      case CustomerType.walkIn:
        return CustomerTypeModel.walkIn;
      case CustomerType.regular:
        return CustomerTypeModel.regular;
      case CustomerType.wholesale:
        return CustomerTypeModel.wholesale;
      case CustomerType.corporate:
        return CustomerTypeModel.corporate;
      case CustomerType.vip:
        return CustomerTypeModel.vip;
      case CustomerType.medical:
        return CustomerTypeModel.medical;
      case CustomerType.insurance:
        return CustomerTypeModel.insurance;
    }
  }

  static CustomerType toCustomerType(CustomerTypeModel model) {
    switch (model) {
      case CustomerTypeModel.walkIn:
        return CustomerType.walkIn;
      case CustomerTypeModel.regular:
        return CustomerType.regular;
      case CustomerTypeModel.wholesale:
        return CustomerType.wholesale;
      case CustomerTypeModel.corporate:
        return CustomerType.corporate;
      case CustomerTypeModel.vip:
        return CustomerType.vip;
      case CustomerTypeModel.medical:
        return CustomerType.medical;
      case CustomerTypeModel.insurance:
        return CustomerType.insurance;
    }
  }
}
