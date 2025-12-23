// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lens_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLensModelCollection on Isar {
  IsarCollection<LensModel> get lensModels => this.collection();
}

const LensModelSchema = CollectionSchema(
  name: r'LensModel',
  id: -5440905664421559508,
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
    r'imageUrls': PropertySchema(
      id: 2,
      name: r'imageUrls',
      type: IsarType.stringList,
    ),
    r'isActive': PropertySchema(
      id: 3,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'lensType': PropertySchema(
      id: 4,
      name: r'lensType',
      type: IsarType.string,
      enumMap: _LensModellensTypeEnumValueMap,
    ),
    r'maxIndex': PropertySchema(
      id: 5,
      name: r'maxIndex',
      type: IsarType.double,
    ),
    r'minIndex': PropertySchema(
      id: 6,
      name: r'minIndex',
      type: IsarType.double,
    ),
    r'productName': PropertySchema(
      id: 7,
      name: r'productName',
      type: IsarType.string,
    ),
    r'supportedCoatings': PropertySchema(
      id: 8,
      name: r'supportedCoatings',
      type: IsarType.stringList,
    ),
    r'supportedMaterials': PropertySchema(
      id: 9,
      name: r'supportedMaterials',
      type: IsarType.stringList,
      enumMap: _LensModelsupportedMaterialsEnumValueMap,
    )
  },
  estimateSize: _lensModelEstimateSize,
  serialize: _lensModelSerialize,
  deserialize: _lensModelDeserialize,
  deserializeProp: _lensModelDeserializeProp,
  idName: r'id',
  indexes: {
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
    r'productName': IndexSchema(
      id: 4701636579502142930,
      name: r'productName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'productName',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _lensModelGetId,
  getLinks: _lensModelGetLinks,
  attach: _lensModelAttach,
  version: '3.1.0+1',
);

int _lensModelEstimateSize(
  LensModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.companyName.length * 3;
  bytesCount += 3 + object.imageUrls.length * 3;
  {
    for (var i = 0; i < object.imageUrls.length; i++) {
      final value = object.imageUrls[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.lensType.name.length * 3;
  bytesCount += 3 + object.productName.length * 3;
  bytesCount += 3 + object.supportedCoatings.length * 3;
  {
    for (var i = 0; i < object.supportedCoatings.length; i++) {
      final value = object.supportedCoatings[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.supportedMaterials.length * 3;
  {
    for (var i = 0; i < object.supportedMaterials.length; i++) {
      final value = object.supportedMaterials[i];
      bytesCount += value.name.length * 3;
    }
  }
  return bytesCount;
}

void _lensModelSerialize(
  LensModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.companyName);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeStringList(offsets[2], object.imageUrls);
  writer.writeBool(offsets[3], object.isActive);
  writer.writeString(offsets[4], object.lensType.name);
  writer.writeDouble(offsets[5], object.maxIndex);
  writer.writeDouble(offsets[6], object.minIndex);
  writer.writeString(offsets[7], object.productName);
  writer.writeStringList(offsets[8], object.supportedCoatings);
  writer.writeStringList(
      offsets[9], object.supportedMaterials.map((e) => e.name).toList());
}

LensModel _lensModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LensModel(
    companyName: reader.readString(offsets[0]),
    createdAt: reader.readDateTime(offsets[1]),
    imageUrls: reader.readStringList(offsets[2]) ?? const [],
    isActive: reader.readBoolOrNull(offsets[3]) ?? true,
    lensType:
        _LensModellensTypeValueEnumMap[reader.readStringOrNull(offsets[4])] ??
            LensTypeModel.singleVision,
    maxIndex: reader.readDouble(offsets[5]),
    minIndex: reader.readDouble(offsets[6]),
    productName: reader.readString(offsets[7]),
    supportedCoatings: reader.readStringList(offsets[8]) ?? const [],
    supportedMaterials: reader
            .readStringList(offsets[9])
            ?.map((e) =>
                _LensModelsupportedMaterialsValueEnumMap[e] ??
                LensMaterialTypeModel.mineral)
            .toList() ??
        [],
  );
  object.id = id;
  return object;
}

P _lensModelDeserializeProp<P>(
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
      return (reader.readStringList(offset) ?? const []) as P;
    case 3:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 4:
      return (_LensModellensTypeValueEnumMap[reader.readStringOrNull(offset)] ??
          LensTypeModel.singleVision) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readStringList(offset) ?? const []) as P;
    case 9:
      return (reader
              .readStringList(offset)
              ?.map((e) =>
                  _LensModelsupportedMaterialsValueEnumMap[e] ??
                  LensMaterialTypeModel.mineral)
              .toList() ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _LensModellensTypeEnumValueMap = {
  r'singleVision': r'singleVision',
  r'bifocal': r'bifocal',
  r'progressive': r'progressive',
  r'contactLens': r'contactLens',
};
const _LensModellensTypeValueEnumMap = {
  r'singleVision': LensTypeModel.singleVision,
  r'bifocal': LensTypeModel.bifocal,
  r'progressive': LensTypeModel.progressive,
  r'contactLens': LensTypeModel.contactLens,
};
const _LensModelsupportedMaterialsEnumValueMap = {
  r'mineral': r'mineral',
  r'plastic': r'plastic',
  r'polycarbonate': r'polycarbonate',
  r'trivex': r'trivex',
  r'organic': r'organic',
};
const _LensModelsupportedMaterialsValueEnumMap = {
  r'mineral': LensMaterialTypeModel.mineral,
  r'plastic': LensMaterialTypeModel.plastic,
  r'polycarbonate': LensMaterialTypeModel.polycarbonate,
  r'trivex': LensMaterialTypeModel.trivex,
  r'organic': LensMaterialTypeModel.organic,
};

Id _lensModelGetId(LensModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _lensModelGetLinks(LensModel object) {
  return [];
}

void _lensModelAttach(IsarCollection<dynamic> col, Id id, LensModel object) {
  object.id = id;
}

extension LensModelQueryWhereSort
    on QueryBuilder<LensModel, LensModel, QWhere> {
  QueryBuilder<LensModel, LensModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterWhere> anyProductName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'productName'),
      );
    });
  }
}

extension LensModelQueryWhere
    on QueryBuilder<LensModel, LensModel, QWhereClause> {
  QueryBuilder<LensModel, LensModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<LensModel, LensModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<LensModel, LensModel, QAfterWhereClause> companyNameEqualTo(
      String companyName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'companyName',
        value: [companyName],
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterWhereClause> companyNameNotEqualTo(
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

  QueryBuilder<LensModel, LensModel, QAfterWhereClause> productNameEqualTo(
      String productName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'productName',
        value: [productName],
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterWhereClause> productNameNotEqualTo(
      String productName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'productName',
              lower: [],
              upper: [productName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'productName',
              lower: [productName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'productName',
              lower: [productName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'productName',
              lower: [],
              upper: [productName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterWhereClause> productNameGreaterThan(
    String productName, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'productName',
        lower: [productName],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterWhereClause> productNameLessThan(
    String productName, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'productName',
        lower: [],
        upper: [productName],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterWhereClause> productNameBetween(
    String lowerProductName,
    String upperProductName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'productName',
        lower: [lowerProductName],
        includeLower: includeLower,
        upper: [upperProductName],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterWhereClause> productNameStartsWith(
      String ProductNamePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'productName',
        lower: [ProductNamePrefix],
        upper: ['$ProductNamePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterWhereClause> productNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'productName',
        value: [''],
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterWhereClause>
      productNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'productName',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'productName',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'productName',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'productName',
              upper: [''],
            ));
      }
    });
  }
}

extension LensModelQueryFilter
    on QueryBuilder<LensModel, LensModel, QFilterCondition> {
  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> companyNameEqualTo(
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> companyNameLessThan(
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> companyNameBetween(
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> companyNameEndsWith(
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> companyNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> companyNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'companyName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      companyNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyName',
        value: '',
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      companyNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'companyName',
        value: '',
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      imageUrlsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageUrls',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      imageUrlsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageUrls',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      imageUrlsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrls',
        value: '',
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      imageUrlsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageUrls',
        value: '',
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> imageUrlsIsEmpty() {
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
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

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> isActiveEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> lensTypeEqualTo(
    LensTypeModel value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lensType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> lensTypeGreaterThan(
    LensTypeModel value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lensType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> lensTypeLessThan(
    LensTypeModel value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lensType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> lensTypeBetween(
    LensTypeModel lower,
    LensTypeModel upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lensType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> lensTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lensType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> lensTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lensType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> lensTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lensType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> lensTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lensType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> lensTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lensType',
        value: '',
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      lensTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lensType',
        value: '',
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> maxIndexEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxIndex',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> maxIndexGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxIndex',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> maxIndexLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxIndex',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> maxIndexBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> minIndexEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minIndex',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> minIndexGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minIndex',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> minIndexLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minIndex',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> minIndexBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> productNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      productNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> productNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> productNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'productName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      productNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> productNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> productNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition> productNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'productName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      productNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productName',
        value: '',
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      productNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'productName',
        value: '',
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedCoatingsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supportedCoatings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedCoatingsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'supportedCoatings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedCoatingsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'supportedCoatings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedCoatingsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'supportedCoatings',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedCoatingsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'supportedCoatings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedCoatingsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'supportedCoatings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedCoatingsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'supportedCoatings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedCoatingsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'supportedCoatings',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedCoatingsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supportedCoatings',
        value: '',
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedCoatingsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'supportedCoatings',
        value: '',
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedCoatingsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'supportedCoatings',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedCoatingsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'supportedCoatings',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedCoatingsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'supportedCoatings',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedCoatingsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'supportedCoatings',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedCoatingsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'supportedCoatings',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedCoatingsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'supportedCoatings',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedMaterialsElementEqualTo(
    LensMaterialTypeModel value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supportedMaterials',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedMaterialsElementGreaterThan(
    LensMaterialTypeModel value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'supportedMaterials',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedMaterialsElementLessThan(
    LensMaterialTypeModel value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'supportedMaterials',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedMaterialsElementBetween(
    LensMaterialTypeModel lower,
    LensMaterialTypeModel upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'supportedMaterials',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedMaterialsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'supportedMaterials',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedMaterialsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'supportedMaterials',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedMaterialsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'supportedMaterials',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedMaterialsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'supportedMaterials',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedMaterialsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supportedMaterials',
        value: '',
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedMaterialsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'supportedMaterials',
        value: '',
      ));
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedMaterialsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'supportedMaterials',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedMaterialsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'supportedMaterials',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedMaterialsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'supportedMaterials',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedMaterialsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'supportedMaterials',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedMaterialsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'supportedMaterials',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterFilterCondition>
      supportedMaterialsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'supportedMaterials',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension LensModelQueryObject
    on QueryBuilder<LensModel, LensModel, QFilterCondition> {}

extension LensModelQueryLinks
    on QueryBuilder<LensModel, LensModel, QFilterCondition> {}

extension LensModelQuerySortBy on QueryBuilder<LensModel, LensModel, QSortBy> {
  QueryBuilder<LensModel, LensModel, QAfterSortBy> sortByCompanyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyName', Sort.asc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> sortByCompanyNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyName', Sort.desc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> sortByLensType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lensType', Sort.asc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> sortByLensTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lensType', Sort.desc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> sortByMaxIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxIndex', Sort.asc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> sortByMaxIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxIndex', Sort.desc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> sortByMinIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minIndex', Sort.asc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> sortByMinIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minIndex', Sort.desc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> sortByProductName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productName', Sort.asc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> sortByProductNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productName', Sort.desc);
    });
  }
}

extension LensModelQuerySortThenBy
    on QueryBuilder<LensModel, LensModel, QSortThenBy> {
  QueryBuilder<LensModel, LensModel, QAfterSortBy> thenByCompanyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyName', Sort.asc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> thenByCompanyNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyName', Sort.desc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> thenByLensType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lensType', Sort.asc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> thenByLensTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lensType', Sort.desc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> thenByMaxIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxIndex', Sort.asc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> thenByMaxIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxIndex', Sort.desc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> thenByMinIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minIndex', Sort.asc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> thenByMinIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minIndex', Sort.desc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> thenByProductName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productName', Sort.asc);
    });
  }

  QueryBuilder<LensModel, LensModel, QAfterSortBy> thenByProductNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productName', Sort.desc);
    });
  }
}

extension LensModelQueryWhereDistinct
    on QueryBuilder<LensModel, LensModel, QDistinct> {
  QueryBuilder<LensModel, LensModel, QDistinct> distinctByCompanyName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'companyName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LensModel, LensModel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<LensModel, LensModel, QDistinct> distinctByImageUrls() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageUrls');
    });
  }

  QueryBuilder<LensModel, LensModel, QDistinct> distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<LensModel, LensModel, QDistinct> distinctByLensType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lensType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LensModel, LensModel, QDistinct> distinctByMaxIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxIndex');
    });
  }

  QueryBuilder<LensModel, LensModel, QDistinct> distinctByMinIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minIndex');
    });
  }

  QueryBuilder<LensModel, LensModel, QDistinct> distinctByProductName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'productName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LensModel, LensModel, QDistinct> distinctBySupportedCoatings() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supportedCoatings');
    });
  }

  QueryBuilder<LensModel, LensModel, QDistinct> distinctBySupportedMaterials() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supportedMaterials');
    });
  }
}

extension LensModelQueryProperty
    on QueryBuilder<LensModel, LensModel, QQueryProperty> {
  QueryBuilder<LensModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LensModel, String, QQueryOperations> companyNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'companyName');
    });
  }

  QueryBuilder<LensModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<LensModel, List<String>, QQueryOperations> imageUrlsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageUrls');
    });
  }

  QueryBuilder<LensModel, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<LensModel, LensTypeModel, QQueryOperations> lensTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lensType');
    });
  }

  QueryBuilder<LensModel, double, QQueryOperations> maxIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxIndex');
    });
  }

  QueryBuilder<LensModel, double, QQueryOperations> minIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minIndex');
    });
  }

  QueryBuilder<LensModel, String, QQueryOperations> productNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'productName');
    });
  }

  QueryBuilder<LensModel, List<String>, QQueryOperations>
      supportedCoatingsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supportedCoatings');
    });
  }

  QueryBuilder<LensModel, List<LensMaterialTypeModel>, QQueryOperations>
      supportedMaterialsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supportedMaterials');
    });
  }
}
