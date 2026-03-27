// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frame_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFrameModelCollection on Isar {
  IsarCollection<FrameModel> get frameModels => this.collection();
}

const FrameModelSchema = CollectionSchema(
  name: r'FrameModel',
  id: 891192206990745553,
  properties: {
    r'companyName': PropertySchema(
      id: 0,
      name: r'companyName',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'customTypeName': PropertySchema(
      id: 2,
      name: r'customTypeName',
      type: IsarType.string,
    ),
    r'frameType': PropertySchema(
      id: 3,
      name: r'frameType',
      type: IsarType.string,
      enumMap: _FrameModelframeTypeEnumValueMap,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    ),
    r'qrKey': PropertySchema(
      id: 5,
      name: r'qrKey',
      type: IsarType.string,
    ),
    r'variants': PropertySchema(
      id: 6,
      name: r'variants',
      type: IsarType.objectList,
      target: r'FrameVariantModel',
    )
  },
  estimateSize: _frameModelEstimateSize,
  serialize: _frameModelSerialize,
  deserialize: _frameModelDeserialize,
  deserializeProp: _frameModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'qrKey': IndexSchema(
      id: -8578756362810763972,
      name: r'qrKey',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'qrKey',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'companyName': IndexSchema(
      id: 6530936739720993813,
      name: r'companyName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'companyName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'FrameVariantModel': FrameVariantModelSchema},
  getId: _frameModelGetId,
  getLinks: _frameModelGetLinks,
  attach: _frameModelAttach,
  version: '3.1.0+1',
);

int _frameModelEstimateSize(
  FrameModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.companyName.length * 3;
  {
    final value = object.customTypeName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.frameType.name.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.qrKey.length * 3;
  bytesCount += 3 + object.variants.length * 3;
  {
    final offsets = allOffsets[FrameVariantModel]!;
    for (var i = 0; i < object.variants.length; i++) {
      final value = object.variants[i];
      bytesCount +=
          FrameVariantModelSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _frameModelSerialize(
  FrameModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.companyName);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.customTypeName);
  writer.writeString(offsets[3], object.frameType.name);
  writer.writeString(offsets[4], object.name);
  writer.writeString(offsets[5], object.qrKey);
  writer.writeObjectList<FrameVariantModel>(
    offsets[6],
    allOffsets,
    FrameVariantModelSchema.serialize,
    object.variants,
  );
}

FrameModel _frameModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FrameModel(
    companyName: reader.readString(offsets[0]),
    createdAt: reader.readDateTime(offsets[1]),
    customTypeName: reader.readStringOrNull(offsets[2]),
    frameType:
        _FrameModelframeTypeValueEnumMap[reader.readStringOrNull(offsets[3])] ??
            FrameTypeModel.rimless,
    name: reader.readString(offsets[4]),
    qrKey: reader.readString(offsets[5]),
    variants: reader.readObjectList<FrameVariantModel>(
          offsets[6],
          FrameVariantModelSchema.deserialize,
          allOffsets,
          FrameVariantModel(),
        ) ??
        const [],
  );
  object.id = id;
  return object;
}

P _frameModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (_FrameModelframeTypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          FrameTypeModel.rimless) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readObjectList<FrameVariantModel>(
            offset,
            FrameVariantModelSchema.deserialize,
            allOffsets,
            FrameVariantModel(),
          ) ??
          const []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _FrameModelframeTypeEnumValueMap = {
  r'rimless': r'rimless',
  r'halfRimless': r'halfRimless',
  r'fullMetal': r'fullMetal',
  r'fullShell': r'fullShell',
  r'goggles': r'goggles',
  r'custom': r'custom',
};
const _FrameModelframeTypeValueEnumMap = {
  r'rimless': FrameTypeModel.rimless,
  r'halfRimless': FrameTypeModel.halfRimless,
  r'fullMetal': FrameTypeModel.fullMetal,
  r'fullShell': FrameTypeModel.fullShell,
  r'goggles': FrameTypeModel.goggles,
  r'custom': FrameTypeModel.custom,
};

Id _frameModelGetId(FrameModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _frameModelGetLinks(FrameModel object) {
  return [];
}

void _frameModelAttach(IsarCollection<dynamic> col, Id id, FrameModel object) {
  object.id = id;
}

extension FrameModelByIndex on IsarCollection<FrameModel> {
  Future<FrameModel?> getByQrKey(String qrKey) {
    return getByIndex(r'qrKey', [qrKey]);
  }

  FrameModel? getByQrKeySync(String qrKey) {
    return getByIndexSync(r'qrKey', [qrKey]);
  }

  Future<bool> deleteByQrKey(String qrKey) {
    return deleteByIndex(r'qrKey', [qrKey]);
  }

  bool deleteByQrKeySync(String qrKey) {
    return deleteByIndexSync(r'qrKey', [qrKey]);
  }

  Future<List<FrameModel?>> getAllByQrKey(List<String> qrKeyValues) {
    final values = qrKeyValues.map((e) => [e]).toList();
    return getAllByIndex(r'qrKey', values);
  }

  List<FrameModel?> getAllByQrKeySync(List<String> qrKeyValues) {
    final values = qrKeyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'qrKey', values);
  }

  Future<int> deleteAllByQrKey(List<String> qrKeyValues) {
    final values = qrKeyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'qrKey', values);
  }

  int deleteAllByQrKeySync(List<String> qrKeyValues) {
    final values = qrKeyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'qrKey', values);
  }

  Future<Id> putByQrKey(FrameModel object) {
    return putByIndex(r'qrKey', object);
  }

  Id putByQrKeySync(FrameModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'qrKey', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByQrKey(List<FrameModel> objects) {
    return putAllByIndex(r'qrKey', objects);
  }

  List<Id> putAllByQrKeySync(List<FrameModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'qrKey', objects, saveLinks: saveLinks);
  }
}

extension FrameModelQueryWhereSort
    on QueryBuilder<FrameModel, FrameModel, QWhere> {
  QueryBuilder<FrameModel, FrameModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterWhere> anyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'name'),
      );
    });
  }
}

extension FrameModelQueryWhere
    on QueryBuilder<FrameModel, FrameModel, QWhereClause> {
  QueryBuilder<FrameModel, FrameModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<FrameModel, FrameModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<FrameModel, FrameModel, QAfterWhereClause> qrKeyEqualTo(
      String qrKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'qrKey',
        value: [qrKey],
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterWhereClause> qrKeyNotEqualTo(
      String qrKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'qrKey',
              lower: [],
              upper: [qrKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'qrKey',
              lower: [qrKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'qrKey',
              lower: [qrKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'qrKey',
              lower: [],
              upper: [qrKey],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterWhereClause> companyNameEqualTo(
      String companyName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'companyName',
        value: [companyName],
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterWhereClause> companyNameNotEqualTo(
      String companyName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'companyName',
              lower: [],
              upper: [companyName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'companyName',
              lower: [companyName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'companyName',
              lower: [companyName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'companyName',
              lower: [],
              upper: [companyName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterWhereClause> nameEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterWhereClause> nameNotEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterWhereClause> nameGreaterThan(
    String name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [name],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterWhereClause> nameLessThan(
    String name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [],
        upper: [name],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterWhereClause> nameBetween(
    String lowerName,
    String upperName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [lowerName],
        includeLower: includeLower,
        upper: [upperName],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterWhereClause> nameStartsWith(
      String NamePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [NamePrefix],
        upper: ['$NamePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterWhereClause> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [''],
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterWhereClause> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'name',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'name',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'name',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'name',
              upper: [''],
            ));
      }
    });
  }
}

extension FrameModelQueryFilter
    on QueryBuilder<FrameModel, FrameModel, QFilterCondition> {
  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      companyNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      companyNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      companyNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      companyNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'companyName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      companyNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      companyNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      companyNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      companyNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'companyName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      companyNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyName',
        value: '',
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      companyNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'companyName',
        value: '',
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
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

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      customTypeNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customTypeName',
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      customTypeNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customTypeName',
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      customTypeNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      customTypeNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      customTypeNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      customTypeNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customTypeName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      customTypeNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'customTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      customTypeNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'customTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      customTypeNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      customTypeNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customTypeName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      customTypeNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customTypeName',
        value: '',
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      customTypeNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customTypeName',
        value: '',
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> frameTypeEqualTo(
    FrameTypeModel value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frameType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      frameTypeGreaterThan(
    FrameTypeModel value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'frameType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> frameTypeLessThan(
    FrameTypeModel value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'frameType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> frameTypeBetween(
    FrameTypeModel lower,
    FrameTypeModel upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'frameType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      frameTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'frameType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> frameTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'frameType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> frameTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'frameType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> frameTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'frameType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      frameTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frameType',
        value: '',
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      frameTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'frameType',
        value: '',
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> qrKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qrKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> qrKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'qrKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> qrKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'qrKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> qrKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'qrKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> qrKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'qrKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> qrKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'qrKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> qrKeyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'qrKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> qrKeyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'qrKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> qrKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qrKey',
        value: '',
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      qrKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'qrKey',
        value: '',
      ));
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      variantsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'variants',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      variantsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'variants',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      variantsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'variants',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      variantsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'variants',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      variantsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'variants',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition>
      variantsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'variants',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension FrameModelQueryObject
    on QueryBuilder<FrameModel, FrameModel, QFilterCondition> {
  QueryBuilder<FrameModel, FrameModel, QAfterFilterCondition> variantsElement(
      FilterQuery<FrameVariantModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'variants');
    });
  }
}

extension FrameModelQueryLinks
    on QueryBuilder<FrameModel, FrameModel, QFilterCondition> {}

extension FrameModelQuerySortBy
    on QueryBuilder<FrameModel, FrameModel, QSortBy> {
  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> sortByCompanyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyName', Sort.asc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> sortByCompanyNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyName', Sort.desc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> sortByCustomTypeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customTypeName', Sort.asc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy>
      sortByCustomTypeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customTypeName', Sort.desc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> sortByFrameType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frameType', Sort.asc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> sortByFrameTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frameType', Sort.desc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> sortByQrKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrKey', Sort.asc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> sortByQrKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrKey', Sort.desc);
    });
  }
}

extension FrameModelQuerySortThenBy
    on QueryBuilder<FrameModel, FrameModel, QSortThenBy> {
  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> thenByCompanyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyName', Sort.asc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> thenByCompanyNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyName', Sort.desc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> thenByCustomTypeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customTypeName', Sort.asc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy>
      thenByCustomTypeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customTypeName', Sort.desc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> thenByFrameType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frameType', Sort.asc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> thenByFrameTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frameType', Sort.desc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> thenByQrKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrKey', Sort.asc);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QAfterSortBy> thenByQrKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrKey', Sort.desc);
    });
  }
}

extension FrameModelQueryWhereDistinct
    on QueryBuilder<FrameModel, FrameModel, QDistinct> {
  QueryBuilder<FrameModel, FrameModel, QDistinct> distinctByCompanyName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'companyName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<FrameModel, FrameModel, QDistinct> distinctByCustomTypeName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customTypeName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QDistinct> distinctByFrameType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frameType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FrameModel, FrameModel, QDistinct> distinctByQrKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'qrKey', caseSensitive: caseSensitive);
    });
  }
}

extension FrameModelQueryProperty
    on QueryBuilder<FrameModel, FrameModel, QQueryProperty> {
  QueryBuilder<FrameModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FrameModel, String, QQueryOperations> companyNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'companyName');
    });
  }

  QueryBuilder<FrameModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<FrameModel, String?, QQueryOperations> customTypeNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customTypeName');
    });
  }

  QueryBuilder<FrameModel, FrameTypeModel, QQueryOperations>
      frameTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frameType');
    });
  }

  QueryBuilder<FrameModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<FrameModel, String, QQueryOperations> qrKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qrKey');
    });
  }

  QueryBuilder<FrameModel, List<FrameVariantModel>, QQueryOperations>
      variantsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'variants');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const FrameVariantModelSchema = Schema(
  name: r'FrameVariantModel',
  id: 8057371288246787906,
  properties: {
    r'colorName': PropertySchema(
      id: 0,
      name: r'colorName',
      type: IsarType.string,
    ),
    r'colorValue': PropertySchema(
      id: 1,
      name: r'colorValue',
      type: IsarType.long,
    ),
    r'imageUrls': PropertySchema(
      id: 2,
      name: r'imageUrls',
      type: IsarType.stringList,
    ),
    r'productCode': PropertySchema(
      id: 3,
      name: r'productCode',
      type: IsarType.string,
    ),
    r'purchasePrice': PropertySchema(
      id: 4,
      name: r'purchasePrice',
      type: IsarType.long,
    ),
    r'quantity': PropertySchema(
      id: 5,
      name: r'quantity',
      type: IsarType.long,
    ),
    r'salesPrice': PropertySchema(
      id: 6,
      name: r'salesPrice',
      type: IsarType.long,
    ),
    r'size': PropertySchema(
      id: 7,
      name: r'size',
      type: IsarType.string,
    ),
    r'sku': PropertySchema(
      id: 8,
      name: r'sku',
      type: IsarType.string,
    )
  },
  estimateSize: _frameVariantModelEstimateSize,
  serialize: _frameVariantModelSerialize,
  deserialize: _frameVariantModelDeserialize,
  deserializeProp: _frameVariantModelDeserializeProp,
);

int _frameVariantModelEstimateSize(
  FrameVariantModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.colorName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.imageUrls;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final value = object.productCode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.size;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sku;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _frameVariantModelSerialize(
  FrameVariantModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.colorName);
  writer.writeLong(offsets[1], object.colorValue);
  writer.writeStringList(offsets[2], object.imageUrls);
  writer.writeString(offsets[3], object.productCode);
  writer.writeLong(offsets[4], object.purchasePrice);
  writer.writeLong(offsets[5], object.quantity);
  writer.writeLong(offsets[6], object.salesPrice);
  writer.writeString(offsets[7], object.size);
  writer.writeString(offsets[8], object.sku);
}

FrameVariantModel _frameVariantModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FrameVariantModel(
    colorName: reader.readStringOrNull(offsets[0]),
    colorValue: reader.readLongOrNull(offsets[1]),
    imageUrls: reader.readStringList(offsets[2]),
    productCode: reader.readStringOrNull(offsets[3]),
    purchasePrice: reader.readLongOrNull(offsets[4]),
    quantity: reader.readLongOrNull(offsets[5]),
    salesPrice: reader.readLongOrNull(offsets[6]),
    size: reader.readStringOrNull(offsets[7]),
    sku: reader.readStringOrNull(offsets[8]),
  );
  return object;
}

P _frameVariantModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readStringList(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension FrameVariantModelQueryFilter
    on QueryBuilder<FrameVariantModel, FrameVariantModel, QFilterCondition> {
  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      colorNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'colorName',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      colorNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'colorName',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      colorNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'colorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      colorNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'colorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      colorNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'colorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      colorNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'colorName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      colorNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'colorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      colorNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'colorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      colorNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'colorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      colorNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'colorName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      colorNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'colorName',
        value: '',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      colorNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'colorName',
        value: '',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      colorValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'colorValue',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      colorValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'colorValue',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      colorValueEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'colorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      colorValueGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'colorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      colorValueLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'colorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      colorValueBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'colorValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      imageUrlsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageUrls',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      imageUrlsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageUrls',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      imageUrlsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      imageUrlsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      imageUrlsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      imageUrlsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageUrls',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      imageUrlsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      imageUrlsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      imageUrlsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      imageUrlsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageUrls',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      imageUrlsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrls',
        value: '',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      imageUrlsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageUrls',
        value: '',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      imageUrlsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'imageUrls',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      imageUrlsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'imageUrls',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      imageUrlsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'imageUrls',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      imageUrlsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'imageUrls',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      imageUrlsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'imageUrls',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      imageUrlsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'imageUrls',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      productCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'productCode',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      productCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'productCode',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      productCodeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      productCodeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'productCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      productCodeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'productCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      productCodeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'productCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      productCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'productCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      productCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'productCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      productCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'productCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      productCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'productCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      productCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productCode',
        value: '',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      productCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'productCode',
        value: '',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      purchasePriceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'purchasePrice',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      purchasePriceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'purchasePrice',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      purchasePriceEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'purchasePrice',
        value: value,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      purchasePriceGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'purchasePrice',
        value: value,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      purchasePriceLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'purchasePrice',
        value: value,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      purchasePriceBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'purchasePrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      quantityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quantity',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      quantityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quantity',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      quantityEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      quantityGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      quantityLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      quantityBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      salesPriceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'salesPrice',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      salesPriceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'salesPrice',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      salesPriceEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'salesPrice',
        value: value,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      salesPriceGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'salesPrice',
        value: value,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      salesPriceLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'salesPrice',
        value: value,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      salesPriceBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'salesPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      sizeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'size',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      sizeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'size',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      sizeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      sizeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'size',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      sizeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'size',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      sizeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'size',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      sizeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'size',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      sizeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'size',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      sizeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'size',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      sizeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'size',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      sizeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size',
        value: '',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      sizeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'size',
        value: '',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      skuIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sku',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      skuIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sku',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      skuEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sku',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      skuGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sku',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      skuLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sku',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      skuBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sku',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      skuStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sku',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      skuEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sku',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      skuContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sku',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      skuMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sku',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      skuIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sku',
        value: '',
      ));
    });
  }

  QueryBuilder<FrameVariantModel, FrameVariantModel, QAfterFilterCondition>
      skuIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sku',
        value: '',
      ));
    });
  }
}

extension FrameVariantModelQueryObject
    on QueryBuilder<FrameVariantModel, FrameVariantModel, QFilterCondition> {}
