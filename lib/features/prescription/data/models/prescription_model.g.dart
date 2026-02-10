// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPrescriptionModelCollection on Isar {
  IsarCollection<PrescriptionModel> get prescriptionModels => this.collection();
}

const PrescriptionModelSchema = CollectionSchema(
  name: r'PrescriptionModel',
  id: 5238557809895904838,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'leftAdd': PropertySchema(
      id: 1,
      name: r'leftAdd',
      type: IsarType.double,
    ),
    r'leftAxis': PropertySchema(
      id: 2,
      name: r'leftAxis',
      type: IsarType.long,
    ),
    r'leftCylinder': PropertySchema(
      id: 3,
      name: r'leftCylinder',
      type: IsarType.double,
    ),
    r'leftSphere': PropertySchema(
      id: 4,
      name: r'leftSphere',
      type: IsarType.double,
    ),
    r'notes': PropertySchema(
      id: 5,
      name: r'notes',
      type: IsarType.string,
    ),
    r'pdLeft': PropertySchema(
      id: 6,
      name: r'pdLeft',
      type: IsarType.double,
    ),
    r'pdRight': PropertySchema(
      id: 7,
      name: r'pdRight',
      type: IsarType.double,
    ),
    r'prescriptionDate': PropertySchema(
      id: 8,
      name: r'prescriptionDate',
      type: IsarType.dateTime,
    ),
    r'rightAdd': PropertySchema(
      id: 9,
      name: r'rightAdd',
      type: IsarType.double,
    ),
    r'rightAxis': PropertySchema(
      id: 10,
      name: r'rightAxis',
      type: IsarType.long,
    ),
    r'rightCylinder': PropertySchema(
      id: 11,
      name: r'rightCylinder',
      type: IsarType.double,
    ),
    r'rightSphere': PropertySchema(
      id: 12,
      name: r'rightSphere',
      type: IsarType.double,
    ),
    r'source': PropertySchema(
      id: 13,
      name: r'source',
      type: IsarType.string,
      enumMap: _PrescriptionModelsourceEnumValueMap,
    )
  },
  estimateSize: _prescriptionModelEstimateSize,
  serialize: _prescriptionModelSerialize,
  deserialize: _prescriptionModelDeserialize,
  deserializeProp: _prescriptionModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'customer': LinkSchema(
      id: 4337710164278096703,
      name: r'customer',
      target: r'CustomerModel',
      single: true,
    ),
    r'doctor': LinkSchema(
      id: -5359869747344956629,
      name: r'doctor',
      target: r'DoctorModel',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _prescriptionModelGetId,
  getLinks: _prescriptionModelGetLinks,
  attach: _prescriptionModelAttach,
  version: '3.1.0+1',
);

int _prescriptionModelEstimateSize(
  PrescriptionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.source.name.length * 3;
  return bytesCount;
}

void _prescriptionModelSerialize(
  PrescriptionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeDouble(offsets[1], object.leftAdd);
  writer.writeLong(offsets[2], object.leftAxis);
  writer.writeDouble(offsets[3], object.leftCylinder);
  writer.writeDouble(offsets[4], object.leftSphere);
  writer.writeString(offsets[5], object.notes);
  writer.writeDouble(offsets[6], object.pdLeft);
  writer.writeDouble(offsets[7], object.pdRight);
  writer.writeDateTime(offsets[8], object.prescriptionDate);
  writer.writeDouble(offsets[9], object.rightAdd);
  writer.writeLong(offsets[10], object.rightAxis);
  writer.writeDouble(offsets[11], object.rightCylinder);
  writer.writeDouble(offsets[12], object.rightSphere);
  writer.writeString(offsets[13], object.source.name);
}

PrescriptionModel _prescriptionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PrescriptionModel(
    createdAt: reader.readDateTime(offsets[0]),
    notes: reader.readStringOrNull(offsets[5]),
  );
  object.id = id;
  object.leftAdd = reader.readDoubleOrNull(offsets[1]);
  object.leftAxis = reader.readLongOrNull(offsets[2]);
  object.leftCylinder = reader.readDoubleOrNull(offsets[3]);
  object.leftSphere = reader.readDouble(offsets[4]);
  object.pdLeft = reader.readDoubleOrNull(offsets[6]);
  object.pdRight = reader.readDoubleOrNull(offsets[7]);
  object.prescriptionDate = reader.readDateTime(offsets[8]);
  object.rightAdd = reader.readDoubleOrNull(offsets[9]);
  object.rightAxis = reader.readLongOrNull(offsets[10]);
  object.rightCylinder = reader.readDoubleOrNull(offsets[11]);
  object.rightSphere = reader.readDouble(offsets[12]);
  object.source = _PrescriptionModelsourceValueEnumMap[
          reader.readStringOrNull(offsets[13])] ??
      PrescriptionSource.internal;
  return object;
}

P _prescriptionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    case 9:
      return (reader.readDoubleOrNull(offset)) as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    case 11:
      return (reader.readDoubleOrNull(offset)) as P;
    case 12:
      return (reader.readDouble(offset)) as P;
    case 13:
      return (_PrescriptionModelsourceValueEnumMap[
              reader.readStringOrNull(offset)] ??
          PrescriptionSource.internal) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PrescriptionModelsourceEnumValueMap = {
  r'internal': r'internal',
  r'external': r'external',
};
const _PrescriptionModelsourceValueEnumMap = {
  r'internal': PrescriptionSource.internal,
  r'external': PrescriptionSource.external,
};

Id _prescriptionModelGetId(PrescriptionModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _prescriptionModelGetLinks(
    PrescriptionModel object) {
  return [object.customer, object.doctor];
}

void _prescriptionModelAttach(
    IsarCollection<dynamic> col, Id id, PrescriptionModel object) {
  object.id = id;
  object.customer
      .attach(col, col.isar.collection<CustomerModel>(), r'customer', id);
  object.doctor.attach(col, col.isar.collection<DoctorModel>(), r'doctor', id);
}

extension PrescriptionModelQueryWhereSort
    on QueryBuilder<PrescriptionModel, PrescriptionModel, QWhere> {
  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterWhere>
      anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension PrescriptionModelQueryWhere
    on QueryBuilder<PrescriptionModel, PrescriptionModel, QWhereClause> {
  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterWhereClause>
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

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterWhereClause>
      createdAtEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterWhereClause>
      createdAtNotEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterWhereClause>
      createdAtGreaterThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterWhereClause>
      createdAtLessThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterWhereClause>
      createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PrescriptionModelQueryFilter
    on QueryBuilder<PrescriptionModel, PrescriptionModel, QFilterCondition> {
  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
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

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      leftAddIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'leftAdd',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      leftAddIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'leftAdd',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      leftAddEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'leftAdd',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      leftAddGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'leftAdd',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      leftAddLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'leftAdd',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      leftAddBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'leftAdd',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      leftAxisIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'leftAxis',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      leftAxisIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'leftAxis',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      leftAxisEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'leftAxis',
        value: value,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      leftAxisGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'leftAxis',
        value: value,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      leftAxisLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'leftAxis',
        value: value,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      leftAxisBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'leftAxis',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      leftCylinderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'leftCylinder',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      leftCylinderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'leftCylinder',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      leftCylinderEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'leftCylinder',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      leftCylinderGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'leftCylinder',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      leftCylinderLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'leftCylinder',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      leftCylinderBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'leftCylinder',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      leftSphereEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'leftSphere',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      leftSphereGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'leftSphere',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      leftSphereLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'leftSphere',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      leftSphereBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'leftSphere',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      pdLeftIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pdLeft',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      pdLeftIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pdLeft',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      pdLeftEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pdLeft',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      pdLeftGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pdLeft',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      pdLeftLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pdLeft',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      pdLeftBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pdLeft',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      pdRightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pdRight',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      pdRightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pdRight',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      pdRightEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pdRight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      pdRightGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pdRight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      pdRightLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pdRight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      pdRightBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pdRight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      prescriptionDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prescriptionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      prescriptionDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'prescriptionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      prescriptionDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'prescriptionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      prescriptionDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'prescriptionDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      rightAddIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rightAdd',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      rightAddIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rightAdd',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      rightAddEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rightAdd',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      rightAddGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rightAdd',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      rightAddLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rightAdd',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      rightAddBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rightAdd',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      rightAxisIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rightAxis',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      rightAxisIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rightAxis',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      rightAxisEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rightAxis',
        value: value,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      rightAxisGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rightAxis',
        value: value,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      rightAxisLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rightAxis',
        value: value,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      rightAxisBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rightAxis',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      rightCylinderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rightCylinder',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      rightCylinderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rightCylinder',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      rightCylinderEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rightCylinder',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      rightCylinderGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rightCylinder',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      rightCylinderLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rightCylinder',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      rightCylinderBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rightCylinder',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      rightSphereEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rightSphere',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      rightSphereGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rightSphere',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      rightSphereLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rightSphere',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      rightSphereBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rightSphere',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      sourceEqualTo(
    PrescriptionSource value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      sourceGreaterThan(
    PrescriptionSource value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      sourceLessThan(
    PrescriptionSource value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      sourceBetween(
    PrescriptionSource lower,
    PrescriptionSource upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'source',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      sourceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      sourceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      sourceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      sourceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'source',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      sourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: '',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      sourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'source',
        value: '',
      ));
    });
  }
}

extension PrescriptionModelQueryObject
    on QueryBuilder<PrescriptionModel, PrescriptionModel, QFilterCondition> {}

extension PrescriptionModelQueryLinks
    on QueryBuilder<PrescriptionModel, PrescriptionModel, QFilterCondition> {
  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      customer(FilterQuery<CustomerModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'customer');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      customerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'customer', 0, true, 0, true);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      doctor(FilterQuery<DoctorModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'doctor');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      doctorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'doctor', 0, true, 0, true);
    });
  }
}

extension PrescriptionModelQuerySortBy
    on QueryBuilder<PrescriptionModel, PrescriptionModel, QSortBy> {
  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByLeftAdd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftAdd', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByLeftAddDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftAdd', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByLeftAxis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftAxis', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByLeftAxisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftAxis', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByLeftCylinder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftCylinder', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByLeftCylinderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftCylinder', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByLeftSphere() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftSphere', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByLeftSphereDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftSphere', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByPdLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdLeft', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByPdLeftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdLeft', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByPdRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdRight', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByPdRightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdRight', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByPrescriptionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prescriptionDate', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByPrescriptionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prescriptionDate', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByRightAdd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightAdd', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByRightAddDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightAdd', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByRightAxis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightAxis', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByRightAxisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightAxis', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByRightCylinder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightCylinder', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByRightCylinderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightCylinder', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByRightSphere() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightSphere', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByRightSphereDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightSphere', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }
}

extension PrescriptionModelQuerySortThenBy
    on QueryBuilder<PrescriptionModel, PrescriptionModel, QSortThenBy> {
  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByLeftAdd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftAdd', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByLeftAddDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftAdd', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByLeftAxis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftAxis', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByLeftAxisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftAxis', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByLeftCylinder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftCylinder', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByLeftCylinderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftCylinder', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByLeftSphere() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftSphere', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByLeftSphereDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftSphere', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByPdLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdLeft', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByPdLeftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdLeft', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByPdRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdRight', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByPdRightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdRight', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByPrescriptionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prescriptionDate', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByPrescriptionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prescriptionDate', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByRightAdd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightAdd', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByRightAddDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightAdd', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByRightAxis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightAxis', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByRightAxisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightAxis', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByRightCylinder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightCylinder', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByRightCylinderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightCylinder', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByRightSphere() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightSphere', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByRightSphereDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightSphere', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }
}

extension PrescriptionModelQueryWhereDistinct
    on QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct> {
  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct>
      distinctByLeftAdd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leftAdd');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct>
      distinctByLeftAxis() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leftAxis');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct>
      distinctByLeftCylinder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leftCylinder');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct>
      distinctByLeftSphere() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leftSphere');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct>
      distinctByPdLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pdLeft');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct>
      distinctByPdRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pdRight');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct>
      distinctByPrescriptionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'prescriptionDate');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct>
      distinctByRightAdd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rightAdd');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct>
      distinctByRightAxis() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rightAxis');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct>
      distinctByRightCylinder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rightCylinder');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct>
      distinctByRightSphere() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rightSphere');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct>
      distinctBySource({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'source', caseSensitive: caseSensitive);
    });
  }
}

extension PrescriptionModelQueryProperty
    on QueryBuilder<PrescriptionModel, PrescriptionModel, QQueryProperty> {
  QueryBuilder<PrescriptionModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PrescriptionModel, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<PrescriptionModel, double?, QQueryOperations> leftAddProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leftAdd');
    });
  }

  QueryBuilder<PrescriptionModel, int?, QQueryOperations> leftAxisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leftAxis');
    });
  }

  QueryBuilder<PrescriptionModel, double?, QQueryOperations>
      leftCylinderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leftCylinder');
    });
  }

  QueryBuilder<PrescriptionModel, double, QQueryOperations>
      leftSphereProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leftSphere');
    });
  }

  QueryBuilder<PrescriptionModel, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<PrescriptionModel, double?, QQueryOperations> pdLeftProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pdLeft');
    });
  }

  QueryBuilder<PrescriptionModel, double?, QQueryOperations> pdRightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pdRight');
    });
  }

  QueryBuilder<PrescriptionModel, DateTime, QQueryOperations>
      prescriptionDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'prescriptionDate');
    });
  }

  QueryBuilder<PrescriptionModel, double?, QQueryOperations>
      rightAddProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rightAdd');
    });
  }

  QueryBuilder<PrescriptionModel, int?, QQueryOperations> rightAxisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rightAxis');
    });
  }

  QueryBuilder<PrescriptionModel, double?, QQueryOperations>
      rightCylinderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rightCylinder');
    });
  }

  QueryBuilder<PrescriptionModel, double, QQueryOperations>
      rightSphereProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rightSphere');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionSource, QQueryOperations>
      sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'source');
    });
  }
}
