// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetInventoryModelCollection on Isar {
  IsarCollection<InventoryModel> get inventoryModels => this.collection();
}

const InventoryModelSchema = CollectionSchema(
  name: r'InventoryModel',
  id: -6585919663430944371,
  properties: {
    r'lastRestockDate': PropertySchema(
      id: 0,
      name: r'lastRestockDate',
      type: IsarType.dateTime,
    ),
    r'minStockLevel': PropertySchema(
      id: 1,
      name: r'minStockLevel',
      type: IsarType.long,
    ),
    r'quantityOnHand': PropertySchema(
      id: 2,
      name: r'quantityOnHand',
      type: IsarType.long,
    )
  },
  estimateSize: _inventoryModelEstimateSize,
  serialize: _inventoryModelSerialize,
  deserialize: _inventoryModelDeserialize,
  deserializeProp: _inventoryModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'quantityOnHand': IndexSchema(
      id: 5897432977268771135,
      name: r'quantityOnHand',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'quantityOnHand',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'frame': LinkSchema(
      id: 6244404958589251501,
      name: r'frame',
      target: r'FrameModel',
      single: true,
    ),
    r'lens': LinkSchema(
      id: 6055735717773908085,
      name: r'lens',
      target: r'LensModel',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _inventoryModelGetId,
  getLinks: _inventoryModelGetLinks,
  attach: _inventoryModelAttach,
  version: '3.1.0+1',
);

int _inventoryModelEstimateSize(
  InventoryModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _inventoryModelSerialize(
  InventoryModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.lastRestockDate);
  writer.writeLong(offsets[1], object.minStockLevel);
  writer.writeLong(offsets[2], object.quantityOnHand);
}

InventoryModel _inventoryModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InventoryModel(
    lastRestockDate: reader.readDateTime(offsets[0]),
    minStockLevel: reader.readLong(offsets[1]),
    quantityOnHand: reader.readLong(offsets[2]),
  );
  object.id = id;
  return object;
}

P _inventoryModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _inventoryModelGetId(InventoryModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _inventoryModelGetLinks(InventoryModel object) {
  return [object.frame, object.lens];
}

void _inventoryModelAttach(
    IsarCollection<dynamic> col, Id id, InventoryModel object) {
  object.id = id;
  object.frame.attach(col, col.isar.collection<FrameModel>(), r'frame', id);
  object.lens.attach(col, col.isar.collection<LensModel>(), r'lens', id);
}

extension InventoryModelQueryWhereSort
    on QueryBuilder<InventoryModel, InventoryModel, QWhere> {
  QueryBuilder<InventoryModel, InventoryModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterWhere>
      anyQuantityOnHand() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'quantityOnHand'),
      );
    });
  }
}

extension InventoryModelQueryWhere
    on QueryBuilder<InventoryModel, InventoryModel, QWhereClause> {
  QueryBuilder<InventoryModel, InventoryModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<InventoryModel, InventoryModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<InventoryModel, InventoryModel, QAfterWhereClause>
      quantityOnHandEqualTo(int quantityOnHand) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'quantityOnHand',
        value: [quantityOnHand],
      ));
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterWhereClause>
      quantityOnHandNotEqualTo(int quantityOnHand) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'quantityOnHand',
              lower: [],
              upper: [quantityOnHand],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'quantityOnHand',
              lower: [quantityOnHand],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'quantityOnHand',
              lower: [quantityOnHand],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'quantityOnHand',
              lower: [],
              upper: [quantityOnHand],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterWhereClause>
      quantityOnHandGreaterThan(
    int quantityOnHand, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'quantityOnHand',
        lower: [quantityOnHand],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterWhereClause>
      quantityOnHandLessThan(
    int quantityOnHand, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'quantityOnHand',
        lower: [],
        upper: [quantityOnHand],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterWhereClause>
      quantityOnHandBetween(
    int lowerQuantityOnHand,
    int upperQuantityOnHand, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'quantityOnHand',
        lower: [lowerQuantityOnHand],
        includeLower: includeLower,
        upper: [upperQuantityOnHand],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension InventoryModelQueryFilter
    on QueryBuilder<InventoryModel, InventoryModel, QFilterCondition> {
  QueryBuilder<InventoryModel, InventoryModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterFilterCondition>
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

  QueryBuilder<InventoryModel, InventoryModel, QAfterFilterCondition>
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

  QueryBuilder<InventoryModel, InventoryModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<InventoryModel, InventoryModel, QAfterFilterCondition>
      lastRestockDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastRestockDate',
        value: value,
      ));
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterFilterCondition>
      lastRestockDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastRestockDate',
        value: value,
      ));
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterFilterCondition>
      lastRestockDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastRestockDate',
        value: value,
      ));
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterFilterCondition>
      lastRestockDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastRestockDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterFilterCondition>
      minStockLevelEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minStockLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterFilterCondition>
      minStockLevelGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minStockLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterFilterCondition>
      minStockLevelLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minStockLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterFilterCondition>
      minStockLevelBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minStockLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterFilterCondition>
      quantityOnHandEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantityOnHand',
        value: value,
      ));
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterFilterCondition>
      quantityOnHandGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantityOnHand',
        value: value,
      ));
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterFilterCondition>
      quantityOnHandLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantityOnHand',
        value: value,
      ));
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterFilterCondition>
      quantityOnHandBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantityOnHand',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension InventoryModelQueryObject
    on QueryBuilder<InventoryModel, InventoryModel, QFilterCondition> {}

extension InventoryModelQueryLinks
    on QueryBuilder<InventoryModel, InventoryModel, QFilterCondition> {
  QueryBuilder<InventoryModel, InventoryModel, QAfterFilterCondition> frame(
      FilterQuery<FrameModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'frame');
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterFilterCondition>
      frameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'frame', 0, true, 0, true);
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterFilterCondition> lens(
      FilterQuery<LensModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'lens');
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterFilterCondition>
      lensIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'lens', 0, true, 0, true);
    });
  }
}

extension InventoryModelQuerySortBy
    on QueryBuilder<InventoryModel, InventoryModel, QSortBy> {
  QueryBuilder<InventoryModel, InventoryModel, QAfterSortBy>
      sortByLastRestockDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRestockDate', Sort.asc);
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterSortBy>
      sortByLastRestockDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRestockDate', Sort.desc);
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterSortBy>
      sortByMinStockLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minStockLevel', Sort.asc);
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterSortBy>
      sortByMinStockLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minStockLevel', Sort.desc);
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterSortBy>
      sortByQuantityOnHand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantityOnHand', Sort.asc);
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterSortBy>
      sortByQuantityOnHandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantityOnHand', Sort.desc);
    });
  }
}

extension InventoryModelQuerySortThenBy
    on QueryBuilder<InventoryModel, InventoryModel, QSortThenBy> {
  QueryBuilder<InventoryModel, InventoryModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterSortBy>
      thenByLastRestockDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRestockDate', Sort.asc);
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterSortBy>
      thenByLastRestockDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRestockDate', Sort.desc);
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterSortBy>
      thenByMinStockLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minStockLevel', Sort.asc);
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterSortBy>
      thenByMinStockLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minStockLevel', Sort.desc);
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterSortBy>
      thenByQuantityOnHand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantityOnHand', Sort.asc);
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QAfterSortBy>
      thenByQuantityOnHandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantityOnHand', Sort.desc);
    });
  }
}

extension InventoryModelQueryWhereDistinct
    on QueryBuilder<InventoryModel, InventoryModel, QDistinct> {
  QueryBuilder<InventoryModel, InventoryModel, QDistinct>
      distinctByLastRestockDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastRestockDate');
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QDistinct>
      distinctByMinStockLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minStockLevel');
    });
  }

  QueryBuilder<InventoryModel, InventoryModel, QDistinct>
      distinctByQuantityOnHand() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantityOnHand');
    });
  }
}

extension InventoryModelQueryProperty
    on QueryBuilder<InventoryModel, InventoryModel, QQueryProperty> {
  QueryBuilder<InventoryModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<InventoryModel, DateTime, QQueryOperations>
      lastRestockDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastRestockDate');
    });
  }

  QueryBuilder<InventoryModel, int, QQueryOperations> minStockLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minStockLevel');
    });
  }

  QueryBuilder<InventoryModel, int, QQueryOperations> quantityOnHandProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantityOnHand');
    });
  }
}
