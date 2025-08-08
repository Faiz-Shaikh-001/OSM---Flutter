// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCustomerModelCollection on Isar {
  IsarCollection<CustomerModel> get customerModels => this.collection();
}

const CustomerModelSchema = CollectionSchema(
  name: r'CustomerModel',
  id: -2515451200106855952,
  properties: {
    r'age': PropertySchema(
      id: 0,
      name: r'age',
      type: IsarType.long,
    ),
    r'city': PropertySchema(
      id: 1,
      name: r'city',
      type: IsarType.string,
    ),
    r'creationDate': PropertySchema(
      id: 2,
      name: r'creationDate',
      type: IsarType.dateTime,
    ),
    r'email': PropertySchema(
      id: 3,
      name: r'email',
      type: IsarType.string,
    ),
    r'firstName': PropertySchema(
      id: 4,
      name: r'firstName',
      type: IsarType.string,
    ),
    r'gender': PropertySchema(
      id: 5,
      name: r'gender',
      type: IsarType.string,
    ),
    r'lastName': PropertySchema(
      id: 6,
      name: r'lastName',
      type: IsarType.string,
    ),
    r'primaryPhoneNumber': PropertySchema(
      id: 7,
      name: r'primaryPhoneNumber',
      type: IsarType.string,
    ),
    r'profileImageUrl': PropertySchema(
      id: 8,
      name: r'profileImageUrl',
      type: IsarType.string,
    ),
    r'secondaryPhoneNumber': PropertySchema(
      id: 9,
      name: r'secondaryPhoneNumber',
      type: IsarType.string,
    )
  },
  estimateSize: _customerModelEstimateSize,
  serialize: _customerModelSerialize,
  deserialize: _customerModelDeserialize,
  deserializeProp: _customerModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'firstName': IndexSchema(
      id: -2537032818573098835,
      name: r'firstName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'firstName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'lastName': IndexSchema(
      id: 8422632250150515205,
      name: r'lastName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'lastName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'primaryPhoneNumber': IndexSchema(
      id: 5796925699396751918,
      name: r'primaryPhoneNumber',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'primaryPhoneNumber',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'prescriptions': LinkSchema(
      id: -4893861860868165928,
      name: r'prescriptions',
      target: r'PrescriptionModel',
      single: false,
      linkName: r'customer',
    ),
    r'orders': LinkSchema(
      id: -6050909837839474401,
      name: r'orders',
      target: r'OrderModel',
      single: false,
      linkName: r'customer',
    )
  },
  embeddedSchemas: {},
  getId: _customerModelGetId,
  getLinks: _customerModelGetLinks,
  attach: _customerModelAttach,
  version: '3.1.0+1',
);

int _customerModelEstimateSize(
  CustomerModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.city.length * 3;
  {
    final value = object.email;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.firstName.length * 3;
  bytesCount += 3 + object.gender.length * 3;
  bytesCount += 3 + object.lastName.length * 3;
  bytesCount += 3 + object.primaryPhoneNumber.length * 3;
  bytesCount += 3 + object.profileImageUrl.length * 3;
  {
    final value = object.secondaryPhoneNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _customerModelSerialize(
  CustomerModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.age);
  writer.writeString(offsets[1], object.city);
  writer.writeDateTime(offsets[2], object.date);
  writer.writeString(offsets[3], object.email);
  writer.writeString(offsets[4], object.firstName);
  writer.writeString(offsets[5], object.gender);
  writer.writeString(offsets[6], object.lastName);
  writer.writeString(offsets[7], object.primaryPhoneNumber);
  writer.writeString(offsets[8], object.profileImageUrl);
  writer.writeString(offsets[9], object.secondaryPhoneNumber);
}

CustomerModel _customerModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CustomerModel(
    age: reader.readLong(offsets[0]),
    city: reader.readString(offsets[1]),
    date: reader.readDateTimeOrNull(offsets[2]),
    email: reader.readStringOrNull(offsets[3]),
    firstName: reader.readString(offsets[4]),
    gender: reader.readString(offsets[5]),
    lastName: reader.readString(offsets[6]),
    primaryPhoneNumber: reader.readString(offsets[7]),
    profileImageUrl: reader.readString(offsets[8]),
    secondaryPhoneNumber: reader.readStringOrNull(offsets[9]),
  );
  object.id = id;
  return object;
}

P _customerModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _customerModelGetId(CustomerModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _customerModelGetLinks(CustomerModel object) {
  return [object.prescriptions, object.orders];
}

void _customerModelAttach(
    IsarCollection<dynamic> col, Id id, CustomerModel object) {
  object.id = id;
  object.prescriptions.attach(
      col, col.isar.collection<PrescriptionModel>(), r'prescriptions', id);
  object.orders.attach(col, col.isar.collection<OrderModel>(), r'orders', id);
}

extension CustomerModelByIndex on IsarCollection<CustomerModel> {
  Future<CustomerModel?> getByPrimaryPhoneNumber(String primaryPhoneNumber) {
    return getByIndex(r'primaryPhoneNumber', [primaryPhoneNumber]);
  }

  CustomerModel? getByPrimaryPhoneNumberSync(String primaryPhoneNumber) {
    return getByIndexSync(r'primaryPhoneNumber', [primaryPhoneNumber]);
  }

  Future<bool> deleteByPrimaryPhoneNumber(String primaryPhoneNumber) {
    return deleteByIndex(r'primaryPhoneNumber', [primaryPhoneNumber]);
  }

  bool deleteByPrimaryPhoneNumberSync(String primaryPhoneNumber) {
    return deleteByIndexSync(r'primaryPhoneNumber', [primaryPhoneNumber]);
  }

  Future<List<CustomerModel?>> getAllByPrimaryPhoneNumber(
      List<String> primaryPhoneNumberValues) {
    final values = primaryPhoneNumberValues.map((e) => [e]).toList();
    return getAllByIndex(r'primaryPhoneNumber', values);
  }

  List<CustomerModel?> getAllByPrimaryPhoneNumberSync(
      List<String> primaryPhoneNumberValues) {
    final values = primaryPhoneNumberValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'primaryPhoneNumber', values);
  }

  Future<int> deleteAllByPrimaryPhoneNumber(
      List<String> primaryPhoneNumberValues) {
    final values = primaryPhoneNumberValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'primaryPhoneNumber', values);
  }

  int deleteAllByPrimaryPhoneNumberSync(List<String> primaryPhoneNumberValues) {
    final values = primaryPhoneNumberValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'primaryPhoneNumber', values);
  }

  Future<Id> putByPrimaryPhoneNumber(CustomerModel object) {
    return putByIndex(r'primaryPhoneNumber', object);
  }

  Id putByPrimaryPhoneNumberSync(CustomerModel object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'primaryPhoneNumber', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByPrimaryPhoneNumber(List<CustomerModel> objects) {
    return putAllByIndex(r'primaryPhoneNumber', objects);
  }

  List<Id> putAllByPrimaryPhoneNumberSync(List<CustomerModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'primaryPhoneNumber', objects,
        saveLinks: saveLinks);
  }
}

extension CustomerModelQueryWhereSort
    on QueryBuilder<CustomerModel, CustomerModel, QWhere> {
  QueryBuilder<CustomerModel, CustomerModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CustomerModelQueryWhere
    on QueryBuilder<CustomerModel, CustomerModel, QWhereClause> {
  QueryBuilder<CustomerModel, CustomerModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterWhereClause>
      firstNameEqualTo(String firstName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'firstName',
        value: [firstName],
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterWhereClause>
      firstNameNotEqualTo(String firstName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firstName',
              lower: [],
              upper: [firstName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firstName',
              lower: [firstName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firstName',
              lower: [firstName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firstName',
              lower: [],
              upper: [firstName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterWhereClause> lastNameEqualTo(
      String lastName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'lastName',
        value: [lastName],
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterWhereClause>
      lastNameNotEqualTo(String lastName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastName',
              lower: [],
              upper: [lastName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastName',
              lower: [lastName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastName',
              lower: [lastName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastName',
              lower: [],
              upper: [lastName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterWhereClause>
      primaryPhoneNumberEqualTo(String primaryPhoneNumber) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'primaryPhoneNumber',
        value: [primaryPhoneNumber],
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterWhereClause>
      primaryPhoneNumberNotEqualTo(String primaryPhoneNumber) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'primaryPhoneNumber',
              lower: [],
              upper: [primaryPhoneNumber],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'primaryPhoneNumber',
              lower: [primaryPhoneNumber],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'primaryPhoneNumber',
              lower: [primaryPhoneNumber],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'primaryPhoneNumber',
              lower: [],
              upper: [primaryPhoneNumber],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CustomerModelQueryFilter
    on QueryBuilder<CustomerModel, CustomerModel, QFilterCondition> {
  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition> ageEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'age',
        value: value,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      ageGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'age',
        value: value,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition> ageLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'age',
        value: value,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition> ageBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'age',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition> cityEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      cityGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      cityLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition> cityBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'city',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      cityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      cityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      cityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition> cityMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'city',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      cityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'city',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      cityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'city',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'creationDate',
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'creationDate',
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition> dateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creationDate',
        value: value,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      dateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'creationDate',
        value: value,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      dateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'creationDate',
        value: value,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition> dateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'creationDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      emailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      emailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      emailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      emailGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      emailLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      emailBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'email',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      emailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      emailMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'email',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      firstNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      firstNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      firstNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      firstNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firstName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      firstNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      firstNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      firstNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      firstNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firstName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      firstNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstName',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      firstNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firstName',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      genderEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      genderGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      genderLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      genderBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gender',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      genderStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      genderEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      genderContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      genderMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gender',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      genderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gender',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      genderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gender',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      lastNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      lastNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      lastNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      lastNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      lastNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      lastNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      lastNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      lastNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      lastNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastName',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      lastNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastName',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      primaryPhoneNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'primaryPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      primaryPhoneNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'primaryPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      primaryPhoneNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'primaryPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      primaryPhoneNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'primaryPhoneNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      primaryPhoneNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'primaryPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      primaryPhoneNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'primaryPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      primaryPhoneNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'primaryPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      primaryPhoneNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'primaryPhoneNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      primaryPhoneNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'primaryPhoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      primaryPhoneNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'primaryPhoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      profileImageUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profileImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      profileImageUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'profileImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      profileImageUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'profileImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      profileImageUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'profileImageUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      profileImageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'profileImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      profileImageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'profileImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      profileImageUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'profileImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      profileImageUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'profileImageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      profileImageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profileImageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      profileImageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'profileImageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      secondaryPhoneNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'secondaryPhoneNumber',
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      secondaryPhoneNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'secondaryPhoneNumber',
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      secondaryPhoneNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secondaryPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      secondaryPhoneNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'secondaryPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      secondaryPhoneNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'secondaryPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      secondaryPhoneNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'secondaryPhoneNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      secondaryPhoneNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'secondaryPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      secondaryPhoneNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'secondaryPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      secondaryPhoneNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'secondaryPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      secondaryPhoneNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'secondaryPhoneNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      secondaryPhoneNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secondaryPhoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      secondaryPhoneNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'secondaryPhoneNumber',
        value: '',
      ));
    });
  }
}

extension CustomerModelQueryObject
    on QueryBuilder<CustomerModel, CustomerModel, QFilterCondition> {}

extension CustomerModelQueryLinks
    on QueryBuilder<CustomerModel, CustomerModel, QFilterCondition> {
  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      prescriptions(FilterQuery<PrescriptionModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'prescriptions');
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      prescriptionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'prescriptions', length, true, length, true);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      prescriptionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'prescriptions', 0, true, 0, true);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      prescriptionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'prescriptions', 0, false, 999999, true);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      prescriptionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'prescriptions', 0, true, length, include);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      prescriptionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'prescriptions', length, include, 999999, true);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      prescriptionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'prescriptions', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition> orders(
      FilterQuery<OrderModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'orders');
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      ordersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'orders', length, true, length, true);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      ordersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'orders', 0, true, 0, true);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      ordersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'orders', 0, false, 999999, true);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      ordersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'orders', 0, true, length, include);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      ordersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'orders', length, include, 999999, true);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterFilterCondition>
      ordersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'orders', lower, includeLower, upper, includeUpper);
    });
  }
}

extension CustomerModelQuerySortBy
    on QueryBuilder<CustomerModel, CustomerModel, QSortBy> {
  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> sortByAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.asc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> sortByAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.desc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> sortByCity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.asc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> sortByCityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.desc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creationDate', Sort.asc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creationDate', Sort.desc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> sortByFirstName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.asc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy>
      sortByFirstNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.desc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> sortByGender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.asc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> sortByGenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.desc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> sortByLastName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.asc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy>
      sortByLastNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.desc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy>
      sortByPrimaryPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryPhoneNumber', Sort.asc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy>
      sortByPrimaryPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryPhoneNumber', Sort.desc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy>
      sortByProfileImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileImageUrl', Sort.asc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy>
      sortByProfileImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileImageUrl', Sort.desc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy>
      sortBySecondaryPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondaryPhoneNumber', Sort.asc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy>
      sortBySecondaryPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondaryPhoneNumber', Sort.desc);
    });
  }
}

extension CustomerModelQuerySortThenBy
    on QueryBuilder<CustomerModel, CustomerModel, QSortThenBy> {
  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> thenByAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.asc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> thenByAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.desc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> thenByCity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.asc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> thenByCityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.desc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creationDate', Sort.asc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creationDate', Sort.desc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> thenByFirstName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.asc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy>
      thenByFirstNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.desc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> thenByGender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.asc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> thenByGenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.desc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy> thenByLastName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.asc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy>
      thenByLastNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.desc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy>
      thenByPrimaryPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryPhoneNumber', Sort.asc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy>
      thenByPrimaryPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryPhoneNumber', Sort.desc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy>
      thenByProfileImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileImageUrl', Sort.asc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy>
      thenByProfileImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileImageUrl', Sort.desc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy>
      thenBySecondaryPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondaryPhoneNumber', Sort.asc);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QAfterSortBy>
      thenBySecondaryPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondaryPhoneNumber', Sort.desc);
    });
  }
}

extension CustomerModelQueryWhereDistinct
    on QueryBuilder<CustomerModel, CustomerModel, QDistinct> {
  QueryBuilder<CustomerModel, CustomerModel, QDistinct> distinctByAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'age');
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QDistinct> distinctByCity(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'city', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creationDate');
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QDistinct> distinctByEmail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QDistinct> distinctByFirstName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firstName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QDistinct> distinctByGender(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gender', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QDistinct> distinctByLastName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QDistinct>
      distinctByPrimaryPhoneNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'primaryPhoneNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QDistinct>
      distinctByProfileImageUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'profileImageUrl',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerModel, CustomerModel, QDistinct>
      distinctBySecondaryPhoneNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'secondaryPhoneNumber',
          caseSensitive: caseSensitive);
    });
  }
}

extension CustomerModelQueryProperty
    on QueryBuilder<CustomerModel, CustomerModel, QQueryProperty> {
  QueryBuilder<CustomerModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CustomerModel, int, QQueryOperations> ageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'age');
    });
  }

  QueryBuilder<CustomerModel, String, QQueryOperations> cityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'city');
    });
  }

  QueryBuilder<CustomerModel, DateTime?, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creationDate');
    });
  }

  QueryBuilder<CustomerModel, String?, QQueryOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<CustomerModel, String, QQueryOperations> firstNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firstName');
    });
  }

  QueryBuilder<CustomerModel, String, QQueryOperations> genderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gender');
    });
  }

  QueryBuilder<CustomerModel, String, QQueryOperations> lastNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastName');
    });
  }

  QueryBuilder<CustomerModel, String, QQueryOperations>
      primaryPhoneNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'primaryPhoneNumber');
    });
  }

  QueryBuilder<CustomerModel, String, QQueryOperations>
      profileImageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'profileImageUrl');
    });
  }

  QueryBuilder<CustomerModel, String?, QQueryOperations>
      secondaryPhoneNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'secondaryPhoneNumber');
    });
  }
}
