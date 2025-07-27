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
    r'addPower': PropertySchema(
      id: 0,
      name: r'addPower',
      type: IsarType.double,
    ),
    r'axisLeft': PropertySchema(
      id: 1,
      name: r'axisLeft',
      type: IsarType.double,
    ),
    r'axisRight': PropertySchema(
      id: 2,
      name: r'axisRight',
      type: IsarType.double,
    ),
    r'cylinderLeft': PropertySchema(
      id: 3,
      name: r'cylinderLeft',
      type: IsarType.double,
    ),
    r'cylinderRight': PropertySchema(
      id: 4,
      name: r'cylinderRight',
      type: IsarType.double,
    ),
    r'notes': PropertySchema(
      id: 5,
      name: r'notes',
      type: IsarType.string,
    ),
    r'prescriptionDate': PropertySchema(
      id: 6,
      name: r'prescriptionDate',
      type: IsarType.dateTime,
    ),
    r'sphereLeft': PropertySchema(
      id: 7,
      name: r'sphereLeft',
      type: IsarType.double,
    ),
    r'sphereRight': PropertySchema(
      id: 8,
      name: r'sphereRight',
      type: IsarType.double,
    )
  },
  estimateSize: _prescriptionModelEstimateSize,
  serialize: _prescriptionModelSerialize,
  deserialize: _prescriptionModelDeserialize,
  deserializeProp: _prescriptionModelDeserializeProp,
  idName: r'id',
  indexes: {},
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
    ),
    r'orders': LinkSchema(
      id: 6611522618700181329,
      name: r'orders',
      target: r'OrderModel',
      single: false,
      linkName: r'prescription',
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
  return bytesCount;
}

void _prescriptionModelSerialize(
  PrescriptionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.addPower);
  writer.writeDouble(offsets[1], object.axisLeft);
  writer.writeDouble(offsets[2], object.axisRight);
  writer.writeDouble(offsets[3], object.cylinderLeft);
  writer.writeDouble(offsets[4], object.cylinderRight);
  writer.writeString(offsets[5], object.notes);
  writer.writeDateTime(offsets[6], object.prescriptionDate);
  writer.writeDouble(offsets[7], object.sphereLeft);
  writer.writeDouble(offsets[8], object.sphereRight);
}

PrescriptionModel _prescriptionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PrescriptionModel(
    addPower: reader.readDoubleOrNull(offsets[0]),
    axisLeft: reader.readDouble(offsets[1]),
    axisRight: reader.readDouble(offsets[2]),
    cylinderLeft: reader.readDouble(offsets[3]),
    cylinderRight: reader.readDouble(offsets[4]),
    notes: reader.readStringOrNull(offsets[5]),
    prescriptionDate: reader.readDateTime(offsets[6]),
    sphereLeft: reader.readDouble(offsets[7]),
    sphereRight: reader.readDouble(offsets[8]),
  );
  object.id = id;
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
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _prescriptionModelGetId(PrescriptionModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _prescriptionModelGetLinks(
    PrescriptionModel object) {
  return [object.customer, object.doctor, object.orders];
}

void _prescriptionModelAttach(
    IsarCollection<dynamic> col, Id id, PrescriptionModel object) {
  object.id = id;
  object.customer
      .attach(col, col.isar.collection<CustomerModel>(), r'customer', id);
  object.doctor.attach(col, col.isar.collection<DoctorModel>(), r'doctor', id);
  object.orders.attach(col, col.isar.collection<OrderModel>(), r'orders', id);
}

extension PrescriptionModelQueryWhereSort
    on QueryBuilder<PrescriptionModel, PrescriptionModel, QWhere> {
  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
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
}

extension PrescriptionModelQueryFilter
    on QueryBuilder<PrescriptionModel, PrescriptionModel, QFilterCondition> {
  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      addPowerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'addPower',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      addPowerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'addPower',
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      addPowerEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addPower',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      addPowerGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'addPower',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      addPowerLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'addPower',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      addPowerBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'addPower',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      axisLeftEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'axisLeft',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      axisLeftGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'axisLeft',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      axisLeftLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'axisLeft',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      axisLeftBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'axisLeft',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      axisRightEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'axisRight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      axisRightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'axisRight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      axisRightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'axisRight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      axisRightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'axisRight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      cylinderLeftEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cylinderLeft',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      cylinderLeftGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cylinderLeft',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      cylinderLeftLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cylinderLeft',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      cylinderLeftBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cylinderLeft',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      cylinderRightEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cylinderRight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      cylinderRightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cylinderRight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      cylinderRightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cylinderRight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      cylinderRightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cylinderRight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
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
      sphereLeftEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sphereLeft',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      sphereLeftGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sphereLeft',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      sphereLeftLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sphereLeft',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      sphereLeftBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sphereLeft',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      sphereRightEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sphereRight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      sphereRightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sphereRight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      sphereRightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sphereRight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      sphereRightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sphereRight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
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

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      orders(FilterQuery<OrderModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'orders');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      ordersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'orders', length, true, length, true);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      ordersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'orders', 0, true, 0, true);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      ordersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'orders', 0, false, 999999, true);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      ordersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'orders', 0, true, length, include);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
      ordersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'orders', length, include, 999999, true);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterFilterCondition>
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

extension PrescriptionModelQuerySortBy
    on QueryBuilder<PrescriptionModel, PrescriptionModel, QSortBy> {
  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByAddPower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addPower', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByAddPowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addPower', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByAxisLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'axisLeft', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByAxisLeftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'axisLeft', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByAxisRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'axisRight', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByAxisRightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'axisRight', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByCylinderLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cylinderLeft', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByCylinderLeftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cylinderLeft', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByCylinderRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cylinderRight', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortByCylinderRightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cylinderRight', Sort.desc);
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
      sortBySphereLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sphereLeft', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortBySphereLeftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sphereLeft', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortBySphereRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sphereRight', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      sortBySphereRightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sphereRight', Sort.desc);
    });
  }
}

extension PrescriptionModelQuerySortThenBy
    on QueryBuilder<PrescriptionModel, PrescriptionModel, QSortThenBy> {
  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByAddPower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addPower', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByAddPowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addPower', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByAxisLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'axisLeft', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByAxisLeftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'axisLeft', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByAxisRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'axisRight', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByAxisRightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'axisRight', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByCylinderLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cylinderLeft', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByCylinderLeftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cylinderLeft', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByCylinderRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cylinderRight', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenByCylinderRightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cylinderRight', Sort.desc);
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
      thenBySphereLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sphereLeft', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenBySphereLeftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sphereLeft', Sort.desc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenBySphereRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sphereRight', Sort.asc);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QAfterSortBy>
      thenBySphereRightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sphereRight', Sort.desc);
    });
  }
}

extension PrescriptionModelQueryWhereDistinct
    on QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct> {
  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct>
      distinctByAddPower() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'addPower');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct>
      distinctByAxisLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'axisLeft');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct>
      distinctByAxisRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'axisRight');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct>
      distinctByCylinderLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cylinderLeft');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct>
      distinctByCylinderRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cylinderRight');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct>
      distinctByPrescriptionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'prescriptionDate');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct>
      distinctBySphereLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sphereLeft');
    });
  }

  QueryBuilder<PrescriptionModel, PrescriptionModel, QDistinct>
      distinctBySphereRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sphereRight');
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

  QueryBuilder<PrescriptionModel, double?, QQueryOperations>
      addPowerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'addPower');
    });
  }

  QueryBuilder<PrescriptionModel, double, QQueryOperations> axisLeftProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'axisLeft');
    });
  }

  QueryBuilder<PrescriptionModel, double, QQueryOperations>
      axisRightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'axisRight');
    });
  }

  QueryBuilder<PrescriptionModel, double, QQueryOperations>
      cylinderLeftProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cylinderLeft');
    });
  }

  QueryBuilder<PrescriptionModel, double, QQueryOperations>
      cylinderRightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cylinderRight');
    });
  }

  QueryBuilder<PrescriptionModel, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<PrescriptionModel, DateTime, QQueryOperations>
      prescriptionDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'prescriptionDate');
    });
  }

  QueryBuilder<PrescriptionModel, double, QQueryOperations>
      sphereLeftProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sphereLeft');
    });
  }

  QueryBuilder<PrescriptionModel, double, QQueryOperations>
      sphereRightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sphereRight');
    });
  }
}
