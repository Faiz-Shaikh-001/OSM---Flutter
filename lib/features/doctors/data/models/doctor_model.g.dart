// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDoctorModelCollection on Isar {
  IsarCollection<DoctorModel> get doctorModels => this.collection();
}

const DoctorModelSchema = CollectionSchema(
  name: r'DoctorModel',
  id: -6310600538599313073,
  properties: {
    r'city': PropertySchema(
      id: 0,
      name: r'city',
      type: IsarType.string,
    ),
    r'creationDate': PropertySchema(
      id: 1,
      name: r'creationDate',
      type: IsarType.dateTime,
    ),
    r'designation': PropertySchema(
      id: 2,
      name: r'designation',
      type: IsarType.string,
    ),
    r'doctorName': PropertySchema(
      id: 3,
      name: r'doctorName',
      type: IsarType.string,
    ),
    r'hospital': PropertySchema(
      id: 4,
      name: r'hospital',
      type: IsarType.string,
    )
  },
  estimateSize: _doctorModelEstimateSize,
  serialize: _doctorModelSerialize,
  deserialize: _doctorModelDeserialize,
  deserializeProp: _doctorModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'doctorName': IndexSchema(
      id: 6148945994998661170,
      name: r'doctorName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'doctorName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'hospital': IndexSchema(
      id: 1673943063360848205,
      name: r'hospital',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'hospital',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'city': IndexSchema(
      id: 2121973393509345332,
      name: r'city',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'city',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'prescriptions': LinkSchema(
      id: 145750479230950712,
      name: r'prescriptions',
      target: r'PrescriptionModel',
      single: false,
      linkName: r'doctor',
    ),
    r'storeLocation': LinkSchema(
      id: 6639310656887675523,
      name: r'storeLocation',
      target: r'StoreLocationModel',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _doctorModelGetId,
  getLinks: _doctorModelGetLinks,
  attach: _doctorModelAttach,
  version: '3.1.0+1',
);

int _doctorModelEstimateSize(
  DoctorModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.city.length * 3;
  bytesCount += 3 + object.designation.length * 3;
  bytesCount += 3 + object.doctorName.length * 3;
  bytesCount += 3 + object.hospital.length * 3;
  return bytesCount;
}

void _doctorModelSerialize(
  DoctorModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.city);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeString(offsets[2], object.designation);
  writer.writeString(offsets[3], object.doctorName);
  writer.writeString(offsets[4], object.hospital);
}

DoctorModel _doctorModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DoctorModel(
    city: reader.readString(offsets[0]),
    date: reader.readDateTimeOrNull(offsets[1]),
    designation: reader.readString(offsets[2]),
    doctorName: reader.readString(offsets[3]),
    hospital: reader.readString(offsets[4]),
  );
  object.id = id;
  return object;
}

P _doctorModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _doctorModelGetId(DoctorModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _doctorModelGetLinks(DoctorModel object) {
  return [object.prescriptions, object.storeLocation];
}

void _doctorModelAttach(
    IsarCollection<dynamic> col, Id id, DoctorModel object) {
  object.id = id;
  object.prescriptions.attach(
      col, col.isar.collection<PrescriptionModel>(), r'prescriptions', id);
  object.storeLocation.attach(
      col, col.isar.collection<StoreLocationModel>(), r'storeLocation', id);
}

extension DoctorModelQueryWhereSort
    on QueryBuilder<DoctorModel, DoctorModel, QWhere> {
  QueryBuilder<DoctorModel, DoctorModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhere> anyHospital() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'hospital'),
      );
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhere> anyCity() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'city'),
      );
    });
  }
}

extension DoctorModelQueryWhere
    on QueryBuilder<DoctorModel, DoctorModel, QWhereClause> {
  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause> doctorNameEqualTo(
      String doctorName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'doctorName',
        value: [doctorName],
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause>
      doctorNameNotEqualTo(String doctorName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'doctorName',
              lower: [],
              upper: [doctorName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'doctorName',
              lower: [doctorName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'doctorName',
              lower: [doctorName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'doctorName',
              lower: [],
              upper: [doctorName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause> hospitalEqualTo(
      String hospital) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'hospital',
        value: [hospital],
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause> hospitalNotEqualTo(
      String hospital) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hospital',
              lower: [],
              upper: [hospital],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hospital',
              lower: [hospital],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hospital',
              lower: [hospital],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hospital',
              lower: [],
              upper: [hospital],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause> hospitalGreaterThan(
    String hospital, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'hospital',
        lower: [hospital],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause> hospitalLessThan(
    String hospital, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'hospital',
        lower: [],
        upper: [hospital],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause> hospitalBetween(
    String lowerHospital,
    String upperHospital, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'hospital',
        lower: [lowerHospital],
        includeLower: includeLower,
        upper: [upperHospital],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause> hospitalStartsWith(
      String HospitalPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'hospital',
        lower: [HospitalPrefix],
        upper: ['$HospitalPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause> hospitalIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'hospital',
        value: [''],
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause>
      hospitalIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'hospital',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'hospital',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'hospital',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'hospital',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause> cityEqualTo(
      String city) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'city',
        value: [city],
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause> cityNotEqualTo(
      String city) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'city',
              lower: [],
              upper: [city],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'city',
              lower: [city],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'city',
              lower: [city],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'city',
              lower: [],
              upper: [city],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause> cityGreaterThan(
    String city, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'city',
        lower: [city],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause> cityLessThan(
    String city, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'city',
        lower: [],
        upper: [city],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause> cityBetween(
    String lowerCity,
    String upperCity, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'city',
        lower: [lowerCity],
        includeLower: includeLower,
        upper: [upperCity],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause> cityStartsWith(
      String CityPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'city',
        lower: [CityPrefix],
        upper: ['$CityPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause> cityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'city',
        value: [''],
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterWhereClause> cityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'city',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'city',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'city',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'city',
              upper: [''],
            ));
      }
    });
  }
}

extension DoctorModelQueryFilter
    on QueryBuilder<DoctorModel, DoctorModel, QFilterCondition> {
  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> cityEqualTo(
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

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> cityGreaterThan(
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

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> cityLessThan(
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

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> cityBetween(
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

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> cityStartsWith(
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

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> cityEndsWith(
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

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> cityContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> cityMatches(
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

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> cityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'city',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      cityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'city',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'creationDate',
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'creationDate',
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> dateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creationDate',
        value: value,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> dateGreaterThan(
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

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> dateLessThan(
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

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> dateBetween(
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

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      designationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'designation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      designationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'designation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      designationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'designation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      designationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'designation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      designationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'designation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      designationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'designation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      designationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'designation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      designationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'designation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      designationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'designation',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      designationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'designation',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      doctorNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'doctorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      doctorNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'doctorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      doctorNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'doctorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      doctorNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'doctorName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      doctorNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'doctorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      doctorNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'doctorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      doctorNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'doctorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      doctorNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'doctorName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      doctorNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'doctorName',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      doctorNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'doctorName',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> hospitalEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hospital',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      hospitalGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hospital',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      hospitalLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hospital',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> hospitalBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hospital',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      hospitalStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hospital',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      hospitalEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hospital',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      hospitalContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hospital',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> hospitalMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hospital',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      hospitalIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hospital',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      hospitalIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hospital',
        value: '',
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> idBetween(
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
}

extension DoctorModelQueryObject
    on QueryBuilder<DoctorModel, DoctorModel, QFilterCondition> {}

extension DoctorModelQueryLinks
    on QueryBuilder<DoctorModel, DoctorModel, QFilterCondition> {
  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> prescriptions(
      FilterQuery<PrescriptionModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'prescriptions');
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      prescriptionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'prescriptions', length, true, length, true);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      prescriptionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'prescriptions', 0, true, 0, true);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      prescriptionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'prescriptions', 0, false, 999999, true);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      prescriptionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'prescriptions', 0, true, length, include);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      prescriptionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'prescriptions', length, include, 999999, true);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
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

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition> storeLocation(
      FilterQuery<StoreLocationModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'storeLocation');
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterFilterCondition>
      storeLocationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'storeLocation', 0, true, 0, true);
    });
  }
}

extension DoctorModelQuerySortBy
    on QueryBuilder<DoctorModel, DoctorModel, QSortBy> {
  QueryBuilder<DoctorModel, DoctorModel, QAfterSortBy> sortByCity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.asc);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterSortBy> sortByCityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.desc);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creationDate', Sort.asc);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creationDate', Sort.desc);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterSortBy> sortByDesignation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'designation', Sort.asc);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterSortBy> sortByDesignationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'designation', Sort.desc);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterSortBy> sortByDoctorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doctorName', Sort.asc);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterSortBy> sortByDoctorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doctorName', Sort.desc);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterSortBy> sortByHospital() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hospital', Sort.asc);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterSortBy> sortByHospitalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hospital', Sort.desc);
    });
  }
}

extension DoctorModelQuerySortThenBy
    on QueryBuilder<DoctorModel, DoctorModel, QSortThenBy> {
  QueryBuilder<DoctorModel, DoctorModel, QAfterSortBy> thenByCity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.asc);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterSortBy> thenByCityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.desc);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creationDate', Sort.asc);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creationDate', Sort.desc);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterSortBy> thenByDesignation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'designation', Sort.asc);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterSortBy> thenByDesignationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'designation', Sort.desc);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterSortBy> thenByDoctorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doctorName', Sort.asc);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterSortBy> thenByDoctorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doctorName', Sort.desc);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterSortBy> thenByHospital() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hospital', Sort.asc);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterSortBy> thenByHospitalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hospital', Sort.desc);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension DoctorModelQueryWhereDistinct
    on QueryBuilder<DoctorModel, DoctorModel, QDistinct> {
  QueryBuilder<DoctorModel, DoctorModel, QDistinct> distinctByCity(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'city', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creationDate');
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QDistinct> distinctByDesignation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'designation', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QDistinct> distinctByDoctorName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'doctorName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoctorModel, DoctorModel, QDistinct> distinctByHospital(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hospital', caseSensitive: caseSensitive);
    });
  }
}

extension DoctorModelQueryProperty
    on QueryBuilder<DoctorModel, DoctorModel, QQueryProperty> {
  QueryBuilder<DoctorModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DoctorModel, String, QQueryOperations> cityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'city');
    });
  }

  QueryBuilder<DoctorModel, DateTime?, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creationDate');
    });
  }

  QueryBuilder<DoctorModel, String, QQueryOperations> designationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'designation');
    });
  }

  QueryBuilder<DoctorModel, String, QQueryOperations> doctorNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'doctorName');
    });
  }

  QueryBuilder<DoctorModel, String, QQueryOperations> hospitalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hospital');
    });
  }
}
