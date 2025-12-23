// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_store_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetActiveStoreModelCollection on Isar {
  IsarCollection<ActiveStoreModel> get activeStoreModels => this.collection();
}

const ActiveStoreModelSchema = CollectionSchema(
  name: r'ActiveStoreModel',
  id: 8082946904044182322,
  properties: {
    r'storeLocationId': PropertySchema(
      id: 0,
      name: r'storeLocationId',
      type: IsarType.long,
    )
  },
  estimateSize: _activeStoreModelEstimateSize,
  serialize: _activeStoreModelSerialize,
  deserialize: _activeStoreModelDeserialize,
  deserializeProp: _activeStoreModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _activeStoreModelGetId,
  getLinks: _activeStoreModelGetLinks,
  attach: _activeStoreModelAttach,
  version: '3.1.0+1',
);

int _activeStoreModelEstimateSize(
  ActiveStoreModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _activeStoreModelSerialize(
  ActiveStoreModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.storeLocationId);
}

ActiveStoreModel _activeStoreModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ActiveStoreModel(
    storeLocationId: reader.readLong(offsets[0]),
  );
  object.id = id;
  return object;
}

P _activeStoreModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _activeStoreModelGetId(ActiveStoreModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _activeStoreModelGetLinks(ActiveStoreModel object) {
  return [];
}

void _activeStoreModelAttach(
    IsarCollection<dynamic> col, Id id, ActiveStoreModel object) {
  object.id = id;
}

extension ActiveStoreModelQueryWhereSort
    on QueryBuilder<ActiveStoreModel, ActiveStoreModel, QWhere> {
  QueryBuilder<ActiveStoreModel, ActiveStoreModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ActiveStoreModelQueryWhere
    on QueryBuilder<ActiveStoreModel, ActiveStoreModel, QWhereClause> {
  QueryBuilder<ActiveStoreModel, ActiveStoreModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ActiveStoreModel, ActiveStoreModel, QAfterWhereClause>
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

  QueryBuilder<ActiveStoreModel, ActiveStoreModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ActiveStoreModel, ActiveStoreModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ActiveStoreModel, ActiveStoreModel, QAfterWhereClause> idBetween(
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

extension ActiveStoreModelQueryFilter
    on QueryBuilder<ActiveStoreModel, ActiveStoreModel, QFilterCondition> {
  QueryBuilder<ActiveStoreModel, ActiveStoreModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ActiveStoreModel, ActiveStoreModel, QAfterFilterCondition>
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

  QueryBuilder<ActiveStoreModel, ActiveStoreModel, QAfterFilterCondition>
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

  QueryBuilder<ActiveStoreModel, ActiveStoreModel, QAfterFilterCondition>
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

  QueryBuilder<ActiveStoreModel, ActiveStoreModel, QAfterFilterCondition>
      storeLocationIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'storeLocationId',
        value: value,
      ));
    });
  }

  QueryBuilder<ActiveStoreModel, ActiveStoreModel, QAfterFilterCondition>
      storeLocationIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'storeLocationId',
        value: value,
      ));
    });
  }

  QueryBuilder<ActiveStoreModel, ActiveStoreModel, QAfterFilterCondition>
      storeLocationIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'storeLocationId',
        value: value,
      ));
    });
  }

  QueryBuilder<ActiveStoreModel, ActiveStoreModel, QAfterFilterCondition>
      storeLocationIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'storeLocationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ActiveStoreModelQueryObject
    on QueryBuilder<ActiveStoreModel, ActiveStoreModel, QFilterCondition> {}

extension ActiveStoreModelQueryLinks
    on QueryBuilder<ActiveStoreModel, ActiveStoreModel, QFilterCondition> {}

extension ActiveStoreModelQuerySortBy
    on QueryBuilder<ActiveStoreModel, ActiveStoreModel, QSortBy> {
  QueryBuilder<ActiveStoreModel, ActiveStoreModel, QAfterSortBy>
      sortByStoreLocationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storeLocationId', Sort.asc);
    });
  }

  QueryBuilder<ActiveStoreModel, ActiveStoreModel, QAfterSortBy>
      sortByStoreLocationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storeLocationId', Sort.desc);
    });
  }
}

extension ActiveStoreModelQuerySortThenBy
    on QueryBuilder<ActiveStoreModel, ActiveStoreModel, QSortThenBy> {
  QueryBuilder<ActiveStoreModel, ActiveStoreModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ActiveStoreModel, ActiveStoreModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ActiveStoreModel, ActiveStoreModel, QAfterSortBy>
      thenByStoreLocationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storeLocationId', Sort.asc);
    });
  }

  QueryBuilder<ActiveStoreModel, ActiveStoreModel, QAfterSortBy>
      thenByStoreLocationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storeLocationId', Sort.desc);
    });
  }
}

extension ActiveStoreModelQueryWhereDistinct
    on QueryBuilder<ActiveStoreModel, ActiveStoreModel, QDistinct> {
  QueryBuilder<ActiveStoreModel, ActiveStoreModel, QDistinct>
      distinctByStoreLocationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'storeLocationId');
    });
  }
}

extension ActiveStoreModelQueryProperty
    on QueryBuilder<ActiveStoreModel, ActiveStoreModel, QQueryProperty> {
  QueryBuilder<ActiveStoreModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ActiveStoreModel, int, QQueryOperations>
      storeLocationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'storeLocationId');
    });
  }
}
