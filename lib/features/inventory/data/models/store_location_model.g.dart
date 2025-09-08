// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_location_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStoreLocationModelCollection on Isar {
  IsarCollection<StoreLocationModel> get storeLocationModels =>
      this.collection();
}

const StoreLocationModelSchema = CollectionSchema(
  name: r'StoreLocationModel',
  id: -2709181983127839825,
  properties: {
    r'address': PropertySchema(id: 0, name: r'address', type: IsarType.string),
    r'name': PropertySchema(id: 1, name: r'name', type: IsarType.string),
    r'operatingHours': PropertySchema(
      id: 2,
      name: r'operatingHours',
      type: IsarType.string,
    ),
    r'phoneNumber': PropertySchema(
      id: 3,
      name: r'phoneNumber',
      type: IsarType.string,
    ),
  },
  estimateSize: _storeLocationModelEstimateSize,
  serialize: _storeLocationModelSerialize,
  deserialize: _storeLocationModelDeserialize,
  deserializeProp: _storeLocationModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {
    r'doctors': LinkSchema(
      id: -1644468487829846112,
      name: r'doctors',
      target: r'DoctorModel',
      single: false,
      linkName: r'storeLocation',
    ),
    r'orders': LinkSchema(
      id: 2447201850964289311,
      name: r'orders',
      target: r'OrderModel',
      single: false,
      linkName: r'storeLocation',
    ),
  },
  embeddedSchemas: {},
  getId: _storeLocationModelGetId,
  getLinks: _storeLocationModelGetLinks,
  attach: _storeLocationModelAttach,
  version: '3.1.0+1',
);

int _storeLocationModelEstimateSize(
  StoreLocationModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.address.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.operatingHours.length * 3;
  bytesCount += 3 + object.phoneNumber.length * 3;
  return bytesCount;
}

void _storeLocationModelSerialize(
  StoreLocationModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.address);
  writer.writeString(offsets[1], object.name);
  writer.writeString(offsets[2], object.operatingHours);
  writer.writeString(offsets[3], object.phoneNumber);
}

StoreLocationModel _storeLocationModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StoreLocationModel(
    address: reader.readString(offsets[0]),
    name: reader.readString(offsets[1]),
    operatingHours: reader.readString(offsets[2]),
    phoneNumber: reader.readString(offsets[3]),
  );
  object.id = id;
  return object;
}

P _storeLocationModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _storeLocationModelGetId(StoreLocationModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _storeLocationModelGetLinks(
  StoreLocationModel object,
) {
  return [object.doctors, object.orders];
}

void _storeLocationModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  StoreLocationModel object,
) {
  object.id = id;
  object.doctors.attach(
    col,
    col.isar.collection<DoctorModel>(),
    r'doctors',
    id,
  );
  object.orders.attach(col, col.isar.collection<OrderModel>(), r'orders', id);
}

extension StoreLocationModelByIndex on IsarCollection<StoreLocationModel> {
  Future<StoreLocationModel?> getByName(String name) {
    return getByIndex(r'name', [name]);
  }

  StoreLocationModel? getByNameSync(String name) {
    return getByIndexSync(r'name', [name]);
  }

  Future<bool> deleteByName(String name) {
    return deleteByIndex(r'name', [name]);
  }

  bool deleteByNameSync(String name) {
    return deleteByIndexSync(r'name', [name]);
  }

  Future<List<StoreLocationModel?>> getAllByName(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return getAllByIndex(r'name', values);
  }

  List<StoreLocationModel?> getAllByNameSync(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'name', values);
  }

  Future<int> deleteAllByName(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'name', values);
  }

  int deleteAllByNameSync(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'name', values);
  }

  Future<Id> putByName(StoreLocationModel object) {
    return putByIndex(r'name', object);
  }

  Id putByNameSync(StoreLocationModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'name', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByName(List<StoreLocationModel> objects) {
    return putAllByIndex(r'name', objects);
  }

  List<Id> putAllByNameSync(
    List<StoreLocationModel> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'name', objects, saveLinks: saveLinks);
  }
}

extension StoreLocationModelQueryWhereSort
    on QueryBuilder<StoreLocationModel, StoreLocationModel, QWhere> {
  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StoreLocationModelQueryWhere
    on QueryBuilder<StoreLocationModel, StoreLocationModel, QWhereClause> {
  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterWhereClause>
  idNotEqualTo(Id id) {
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

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterWhereClause>
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterWhereClause>
  nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'name', value: [name]),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterWhereClause>
  nameNotEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'name',
                lower: [],
                upper: [name],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'name',
                lower: [name],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'name',
                lower: [name],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'name',
                lower: [],
                upper: [name],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension StoreLocationModelQueryFilter
    on QueryBuilder<StoreLocationModel, StoreLocationModel, QFilterCondition> {
  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  addressEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'address',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  addressGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'address',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  addressLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'address',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  addressBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'address',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  addressStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'address',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  addressEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'address',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  addressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'address',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  addressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'address',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  addressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'address', value: ''),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  addressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'address', value: ''),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  nameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  nameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  nameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  operatingHoursEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'operatingHours',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  operatingHoursGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'operatingHours',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  operatingHoursLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'operatingHours',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  operatingHoursBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'operatingHours',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  operatingHoursStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'operatingHours',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  operatingHoursEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'operatingHours',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  operatingHoursContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'operatingHours',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  operatingHoursMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'operatingHours',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  operatingHoursIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'operatingHours', value: ''),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  operatingHoursIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'operatingHours', value: ''),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  phoneNumberEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'phoneNumber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  phoneNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'phoneNumber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  phoneNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'phoneNumber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  phoneNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'phoneNumber',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  phoneNumberStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'phoneNumber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  phoneNumberEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'phoneNumber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  phoneNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'phoneNumber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  phoneNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'phoneNumber',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  phoneNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'phoneNumber', value: ''),
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  phoneNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'phoneNumber', value: ''),
      );
    });
  }
}

extension StoreLocationModelQueryObject
    on QueryBuilder<StoreLocationModel, StoreLocationModel, QFilterCondition> {}

extension StoreLocationModelQueryLinks
    on QueryBuilder<StoreLocationModel, StoreLocationModel, QFilterCondition> {
  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  doctors(FilterQuery<DoctorModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'doctors');
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  doctorsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'doctors', length, true, length, true);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  doctorsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'doctors', 0, true, 0, true);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  doctorsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'doctors', 0, false, 999999, true);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  doctorsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'doctors', 0, true, length, include);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  doctorsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'doctors', length, include, 999999, true);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  doctorsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
        r'doctors',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  orders(FilterQuery<OrderModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'orders');
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  ordersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'orders', length, true, length, true);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  ordersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'orders', 0, true, 0, true);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  ordersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'orders', 0, false, 999999, true);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  ordersLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'orders', 0, true, length, include);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  ordersLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'orders', length, include, 999999, true);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterFilterCondition>
  ordersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
        r'orders',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension StoreLocationModelQuerySortBy
    on QueryBuilder<StoreLocationModel, StoreLocationModel, QSortBy> {
  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterSortBy>
  sortByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterSortBy>
  sortByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterSortBy>
  sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterSortBy>
  sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterSortBy>
  sortByOperatingHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operatingHours', Sort.asc);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterSortBy>
  sortByOperatingHoursDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operatingHours', Sort.desc);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterSortBy>
  sortByPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.asc);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterSortBy>
  sortByPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.desc);
    });
  }
}

extension StoreLocationModelQuerySortThenBy
    on QueryBuilder<StoreLocationModel, StoreLocationModel, QSortThenBy> {
  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterSortBy>
  thenByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterSortBy>
  thenByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterSortBy>
  thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterSortBy>
  thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterSortBy>
  thenByOperatingHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operatingHours', Sort.asc);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterSortBy>
  thenByOperatingHoursDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operatingHours', Sort.desc);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterSortBy>
  thenByPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.asc);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QAfterSortBy>
  thenByPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.desc);
    });
  }
}

extension StoreLocationModelQueryWhereDistinct
    on QueryBuilder<StoreLocationModel, StoreLocationModel, QDistinct> {
  QueryBuilder<StoreLocationModel, StoreLocationModel, QDistinct>
  distinctByAddress({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'address', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QDistinct>
  distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QDistinct>
  distinctByOperatingHours({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'operatingHours',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<StoreLocationModel, StoreLocationModel, QDistinct>
  distinctByPhoneNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phoneNumber', caseSensitive: caseSensitive);
    });
  }
}

extension StoreLocationModelQueryProperty
    on QueryBuilder<StoreLocationModel, StoreLocationModel, QQueryProperty> {
  QueryBuilder<StoreLocationModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<StoreLocationModel, String, QQueryOperations> addressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'address');
    });
  }

  QueryBuilder<StoreLocationModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<StoreLocationModel, String, QQueryOperations>
  operatingHoursProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'operatingHours');
    });
  }

  QueryBuilder<StoreLocationModel, String, QQueryOperations>
  phoneNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phoneNumber');
    });
  }
}
