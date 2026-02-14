// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetOrderItemModelCollection on Isar {
  IsarCollection<OrderItemModel> get orderItemModels => this.collection();
}

const OrderItemModelSchema = CollectionSchema(
  name: r'OrderItemModel',
  id: 3320497907544385651,
  properties: {
    r'basePrice': PropertySchema(
      id: 0,
      name: r'basePrice',
      type: IsarType.long,
    ),
    r'coatingSurcharges': PropertySchema(
      id: 1,
      name: r'coatingSurcharges',
      type: IsarType.long,
    ),
    r'coatings': PropertySchema(
      id: 2,
      name: r'coatings',
      type: IsarType.stringList,
    ),
    r'itemType': PropertySchema(
      id: 3,
      name: r'itemType',
      type: IsarType.string,
      enumMap: _OrderItemModelitemTypeEnumValueMap,
    ),
    r'leftAdd': PropertySchema(
      id: 4,
      name: r'leftAdd',
      type: IsarType.double,
    ),
    r'leftAxis': PropertySchema(
      id: 5,
      name: r'leftAxis',
      type: IsarType.long,
    ),
    r'leftCylinder': PropertySchema(
      id: 6,
      name: r'leftCylinder',
      type: IsarType.double,
    ),
    r'leftSphere': PropertySchema(
      id: 7,
      name: r'leftSphere',
      type: IsarType.double,
    ),
    r'materialSurcharge': PropertySchema(
      id: 8,
      name: r'materialSurcharge',
      type: IsarType.long,
    ),
    r'materialType': PropertySchema(
      id: 9,
      name: r'materialType',
      type: IsarType.string,
      enumMap: _OrderItemModelmaterialTypeEnumValueMap,
    ),
    r'pdLeft': PropertySchema(
      id: 10,
      name: r'pdLeft',
      type: IsarType.double,
    ),
    r'pdRight': PropertySchema(
      id: 11,
      name: r'pdRight',
      type: IsarType.double,
    ),
    r'productCode': PropertySchema(
      id: 12,
      name: r'productCode',
      type: IsarType.string,
    ),
    r'productName': PropertySchema(
      id: 13,
      name: r'productName',
      type: IsarType.string,
    ),
    r'quantity': PropertySchema(
      id: 14,
      name: r'quantity',
      type: IsarType.long,
    ),
    r'rightAdd': PropertySchema(
      id: 15,
      name: r'rightAdd',
      type: IsarType.double,
    ),
    r'rightAxis': PropertySchema(
      id: 16,
      name: r'rightAxis',
      type: IsarType.long,
    ),
    r'rightCylinder': PropertySchema(
      id: 17,
      name: r'rightCylinder',
      type: IsarType.double,
    ),
    r'rightSphere': PropertySchema(
      id: 18,
      name: r'rightSphere',
      type: IsarType.double,
    ),
    r'unitPrice': PropertySchema(
      id: 19,
      name: r'unitPrice',
      type: IsarType.long,
    )
  },
  estimateSize: _orderItemModelEstimateSize,
  serialize: _orderItemModelSerialize,
  deserialize: _orderItemModelDeserialize,
  deserializeProp: _orderItemModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'order': LinkSchema(
      id: 8855800014475170768,
      name: r'order',
      target: r'OrderModel',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _orderItemModelGetId,
  getLinks: _orderItemModelGetLinks,
  attach: _orderItemModelAttach,
  version: '3.1.0+1',
);

int _orderItemModelEstimateSize(
  OrderItemModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.coatings;
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
  bytesCount += 3 + object.itemType.name.length * 3;
  {
    final value = object.materialType;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  bytesCount += 3 + object.productCode.length * 3;
  bytesCount += 3 + object.productName.length * 3;
  return bytesCount;
}

void _orderItemModelSerialize(
  OrderItemModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.basePrice);
  writer.writeLong(offsets[1], object.coatingSurcharges);
  writer.writeStringList(offsets[2], object.coatings);
  writer.writeString(offsets[3], object.itemType.name);
  writer.writeDouble(offsets[4], object.leftAdd);
  writer.writeLong(offsets[5], object.leftAxis);
  writer.writeDouble(offsets[6], object.leftCylinder);
  writer.writeDouble(offsets[7], object.leftSphere);
  writer.writeLong(offsets[8], object.materialSurcharge);
  writer.writeString(offsets[9], object.materialType?.name);
  writer.writeDouble(offsets[10], object.pdLeft);
  writer.writeDouble(offsets[11], object.pdRight);
  writer.writeString(offsets[12], object.productCode);
  writer.writeString(offsets[13], object.productName);
  writer.writeLong(offsets[14], object.quantity);
  writer.writeDouble(offsets[15], object.rightAdd);
  writer.writeLong(offsets[16], object.rightAxis);
  writer.writeDouble(offsets[17], object.rightCylinder);
  writer.writeDouble(offsets[18], object.rightSphere);
  writer.writeLong(offsets[19], object.unitPrice);
}

OrderItemModel _orderItemModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = OrderItemModel(
    basePrice: reader.readLong(offsets[0]),
    coatingSurcharges: reader.readLongOrNull(offsets[1]) ?? 0,
    coatings: reader.readStringList(offsets[2]),
    itemType: _OrderItemModelitemTypeValueEnumMap[
            reader.readStringOrNull(offsets[3])] ??
        OrderItemTypeModel.frame,
    leftAdd: reader.readDoubleOrNull(offsets[4]),
    leftAxis: reader.readLongOrNull(offsets[5]),
    leftCylinder: reader.readDoubleOrNull(offsets[6]),
    leftSphere: reader.readDoubleOrNull(offsets[7]),
    materialSurcharge: reader.readLongOrNull(offsets[8]) ?? 0,
    materialType: _OrderItemModelmaterialTypeValueEnumMap[
        reader.readStringOrNull(offsets[9])],
    pdLeft: reader.readDoubleOrNull(offsets[10]),
    pdRight: reader.readDoubleOrNull(offsets[11]),
    productCode: reader.readString(offsets[12]),
    productName: reader.readString(offsets[13]),
    quantity: reader.readLong(offsets[14]),
    rightAdd: reader.readDoubleOrNull(offsets[15]),
    rightAxis: reader.readLongOrNull(offsets[16]),
    rightCylinder: reader.readDoubleOrNull(offsets[17]),
    rightSphere: reader.readDoubleOrNull(offsets[18]),
    unitPrice: reader.readLong(offsets[19]),
  );
  object.id = id;
  return object;
}

P _orderItemModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 2:
      return (reader.readStringList(offset)) as P;
    case 3:
      return (_OrderItemModelitemTypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          OrderItemTypeModel.frame) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 9:
      return (_OrderItemModelmaterialTypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    case 11:
      return (reader.readDoubleOrNull(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readLong(offset)) as P;
    case 15:
      return (reader.readDoubleOrNull(offset)) as P;
    case 16:
      return (reader.readLongOrNull(offset)) as P;
    case 17:
      return (reader.readDoubleOrNull(offset)) as P;
    case 18:
      return (reader.readDoubleOrNull(offset)) as P;
    case 19:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _OrderItemModelitemTypeEnumValueMap = {
  r'frame': r'frame',
  r'lens': r'lens',
  r'accessory': r'accessory',
};
const _OrderItemModelitemTypeValueEnumMap = {
  r'frame': OrderItemTypeModel.frame,
  r'lens': OrderItemTypeModel.lens,
  r'accessory': OrderItemTypeModel.accessory,
};
const _OrderItemModelmaterialTypeEnumValueMap = {
  r'mineral': r'mineral',
  r'plastic': r'plastic',
  r'polycarbonate': r'polycarbonate',
  r'trivex': r'trivex',
  r'organic': r'organic',
};
const _OrderItemModelmaterialTypeValueEnumMap = {
  r'mineral': LensMaterialTypeModel.mineral,
  r'plastic': LensMaterialTypeModel.plastic,
  r'polycarbonate': LensMaterialTypeModel.polycarbonate,
  r'trivex': LensMaterialTypeModel.trivex,
  r'organic': LensMaterialTypeModel.organic,
};

Id _orderItemModelGetId(OrderItemModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _orderItemModelGetLinks(OrderItemModel object) {
  return [object.order];
}

void _orderItemModelAttach(
    IsarCollection<dynamic> col, Id id, OrderItemModel object) {
  object.id = id;
  object.order.attach(col, col.isar.collection<OrderModel>(), r'order', id);
}

extension OrderItemModelQueryWhereSort
    on QueryBuilder<OrderItemModel, OrderItemModel, QWhere> {
  QueryBuilder<OrderItemModel, OrderItemModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension OrderItemModelQueryWhere
    on QueryBuilder<OrderItemModel, OrderItemModel, QWhereClause> {
  QueryBuilder<OrderItemModel, OrderItemModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterWhereClause> idBetween(
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

extension OrderItemModelQueryFilter
    on QueryBuilder<OrderItemModel, OrderItemModel, QFilterCondition> {
  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      basePriceEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'basePrice',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      basePriceGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'basePrice',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      basePriceLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'basePrice',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      basePriceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'basePrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      coatingSurchargesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coatingSurcharges',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      coatingSurchargesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'coatingSurcharges',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      coatingSurchargesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'coatingSurcharges',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      coatingSurchargesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'coatingSurcharges',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      coatingsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'coatings',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      coatingsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'coatings',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      coatingsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coatings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      coatingsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'coatings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      coatingsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'coatings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      coatingsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'coatings',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      coatingsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'coatings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      coatingsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'coatings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      coatingsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'coatings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      coatingsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'coatings',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      coatingsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coatings',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      coatingsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'coatings',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      coatingsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'coatings',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      coatingsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'coatings',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      coatingsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'coatings',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      coatingsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'coatings',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      coatingsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'coatings',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      coatingsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'coatings',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      itemTypeEqualTo(
    OrderItemTypeModel value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'itemType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      itemTypeGreaterThan(
    OrderItemTypeModel value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'itemType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      itemTypeLessThan(
    OrderItemTypeModel value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'itemType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      itemTypeBetween(
    OrderItemTypeModel lower,
    OrderItemTypeModel upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'itemType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      itemTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'itemType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      itemTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'itemType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      itemTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'itemType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      itemTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'itemType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      itemTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'itemType',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      itemTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'itemType',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      leftAddIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'leftAdd',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      leftAddIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'leftAdd',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      leftAxisIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'leftAxis',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      leftAxisIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'leftAxis',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      leftAxisEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'leftAxis',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      leftCylinderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'leftCylinder',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      leftCylinderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'leftCylinder',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      leftSphereIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'leftSphere',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      leftSphereIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'leftSphere',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      leftSphereEqualTo(
    double? value, {
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      leftSphereGreaterThan(
    double? value, {
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      leftSphereLessThan(
    double? value, {
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      leftSphereBetween(
    double? lower,
    double? upper, {
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      materialSurchargeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'materialSurcharge',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      materialSurchargeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'materialSurcharge',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      materialSurchargeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'materialSurcharge',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      materialSurchargeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'materialSurcharge',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      materialTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'materialType',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      materialTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'materialType',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      materialTypeEqualTo(
    LensMaterialTypeModel? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'materialType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      materialTypeGreaterThan(
    LensMaterialTypeModel? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'materialType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      materialTypeLessThan(
    LensMaterialTypeModel? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'materialType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      materialTypeBetween(
    LensMaterialTypeModel? lower,
    LensMaterialTypeModel? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'materialType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      materialTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'materialType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      materialTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'materialType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      materialTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'materialType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      materialTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'materialType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      materialTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'materialType',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      materialTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'materialType',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      pdLeftIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pdLeft',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      pdLeftIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pdLeft',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      pdRightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pdRight',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      pdRightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pdRight',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      productCodeEqualTo(
    String value, {
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      productCodeGreaterThan(
    String value, {
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      productCodeLessThan(
    String value, {
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      productCodeBetween(
    String lower,
    String upper, {
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      productCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'productCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      productCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'productCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      productCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productCode',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      productCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'productCode',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      productNameEqualTo(
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      productNameLessThan(
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      productNameBetween(
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      productNameEndsWith(
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      productNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      productNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'productName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      productNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productName',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      productNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'productName',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      quantityEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      quantityGreaterThan(
    int value, {
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      quantityLessThan(
    int value, {
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      quantityBetween(
    int lower,
    int upper, {
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      rightAddIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rightAdd',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      rightAddIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rightAdd',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      rightAxisIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rightAxis',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      rightAxisIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rightAxis',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      rightAxisEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rightAxis',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      rightCylinderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rightCylinder',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      rightCylinderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rightCylinder',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      rightSphereIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rightSphere',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      rightSphereIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rightSphere',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      rightSphereEqualTo(
    double? value, {
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      rightSphereGreaterThan(
    double? value, {
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      rightSphereLessThan(
    double? value, {
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      rightSphereBetween(
    double? lower,
    double? upper, {
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      unitPriceEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unitPrice',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      unitPriceGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unitPrice',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      unitPriceLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unitPrice',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      unitPriceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unitPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension OrderItemModelQueryObject
    on QueryBuilder<OrderItemModel, OrderItemModel, QFilterCondition> {}

extension OrderItemModelQueryLinks
    on QueryBuilder<OrderItemModel, OrderItemModel, QFilterCondition> {
  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition> order(
      FilterQuery<OrderModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'order');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      orderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'order', 0, true, 0, true);
    });
  }
}

extension OrderItemModelQuerySortBy
    on QueryBuilder<OrderItemModel, OrderItemModel, QSortBy> {
  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByBasePrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'basePrice', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByBasePriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'basePrice', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByCoatingSurcharges() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coatingSurcharges', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByCoatingSurchargesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coatingSurcharges', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByItemType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemType', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByItemTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemType', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByLeftAdd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftAdd', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByLeftAddDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftAdd', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByLeftAxis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftAxis', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByLeftAxisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftAxis', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByLeftCylinder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftCylinder', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByLeftCylinderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftCylinder', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByLeftSphere() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftSphere', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByLeftSphereDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftSphere', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByMaterialSurcharge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialSurcharge', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByMaterialSurchargeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialSurcharge', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByMaterialType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialType', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByMaterialTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialType', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByPdLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdLeft', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByPdLeftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdLeft', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByPdRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdRight', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByPdRightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdRight', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByProductCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productCode', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByProductCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productCode', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByProductName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productName', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByProductNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productName', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByRightAdd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightAdd', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByRightAddDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightAdd', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByRightAxis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightAxis', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByRightAxisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightAxis', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByRightCylinder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightCylinder', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByRightCylinderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightCylinder', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByRightSphere() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightSphere', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByRightSphereDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightSphere', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByUnitPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unitPrice', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByUnitPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unitPrice', Sort.desc);
    });
  }
}

extension OrderItemModelQuerySortThenBy
    on QueryBuilder<OrderItemModel, OrderItemModel, QSortThenBy> {
  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByBasePrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'basePrice', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByBasePriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'basePrice', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByCoatingSurcharges() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coatingSurcharges', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByCoatingSurchargesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coatingSurcharges', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByItemType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemType', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByItemTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemType', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByLeftAdd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftAdd', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByLeftAddDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftAdd', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByLeftAxis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftAxis', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByLeftAxisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftAxis', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByLeftCylinder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftCylinder', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByLeftCylinderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftCylinder', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByLeftSphere() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftSphere', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByLeftSphereDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftSphere', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByMaterialSurcharge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialSurcharge', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByMaterialSurchargeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialSurcharge', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByMaterialType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialType', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByMaterialTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialType', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByPdLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdLeft', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByPdLeftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdLeft', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByPdRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdRight', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByPdRightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdRight', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByProductCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productCode', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByProductCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productCode', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByProductName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productName', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByProductNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productName', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByRightAdd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightAdd', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByRightAddDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightAdd', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByRightAxis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightAxis', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByRightAxisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightAxis', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByRightCylinder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightCylinder', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByRightCylinderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightCylinder', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByRightSphere() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightSphere', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByRightSphereDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rightSphere', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByUnitPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unitPrice', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByUnitPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unitPrice', Sort.desc);
    });
  }
}

extension OrderItemModelQueryWhereDistinct
    on QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> {
  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct>
      distinctByBasePrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'basePrice');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct>
      distinctByCoatingSurcharges() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coatingSurcharges');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByCoatings() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coatings');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByItemType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'itemType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByLeftAdd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leftAdd');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByLeftAxis() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leftAxis');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct>
      distinctByLeftCylinder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leftCylinder');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct>
      distinctByLeftSphere() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leftSphere');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct>
      distinctByMaterialSurcharge() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'materialSurcharge');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct>
      distinctByMaterialType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'materialType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByPdLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pdLeft');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByPdRight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pdRight');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByProductCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'productCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByProductName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'productName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantity');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByRightAdd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rightAdd');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct>
      distinctByRightAxis() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rightAxis');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct>
      distinctByRightCylinder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rightCylinder');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct>
      distinctByRightSphere() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rightSphere');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct>
      distinctByUnitPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unitPrice');
    });
  }
}

extension OrderItemModelQueryProperty
    on QueryBuilder<OrderItemModel, OrderItemModel, QQueryProperty> {
  QueryBuilder<OrderItemModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<OrderItemModel, int, QQueryOperations> basePriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'basePrice');
    });
  }

  QueryBuilder<OrderItemModel, int, QQueryOperations>
      coatingSurchargesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coatingSurcharges');
    });
  }

  QueryBuilder<OrderItemModel, List<String>?, QQueryOperations>
      coatingsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coatings');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemTypeModel, QQueryOperations>
      itemTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'itemType');
    });
  }

  QueryBuilder<OrderItemModel, double?, QQueryOperations> leftAddProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leftAdd');
    });
  }

  QueryBuilder<OrderItemModel, int?, QQueryOperations> leftAxisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leftAxis');
    });
  }

  QueryBuilder<OrderItemModel, double?, QQueryOperations>
      leftCylinderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leftCylinder');
    });
  }

  QueryBuilder<OrderItemModel, double?, QQueryOperations> leftSphereProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leftSphere');
    });
  }

  QueryBuilder<OrderItemModel, int, QQueryOperations>
      materialSurchargeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'materialSurcharge');
    });
  }

  QueryBuilder<OrderItemModel, LensMaterialTypeModel?, QQueryOperations>
      materialTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'materialType');
    });
  }

  QueryBuilder<OrderItemModel, double?, QQueryOperations> pdLeftProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pdLeft');
    });
  }

  QueryBuilder<OrderItemModel, double?, QQueryOperations> pdRightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pdRight');
    });
  }

  QueryBuilder<OrderItemModel, String, QQueryOperations> productCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'productCode');
    });
  }

  QueryBuilder<OrderItemModel, String, QQueryOperations> productNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'productName');
    });
  }

  QueryBuilder<OrderItemModel, int, QQueryOperations> quantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantity');
    });
  }

  QueryBuilder<OrderItemModel, double?, QQueryOperations> rightAddProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rightAdd');
    });
  }

  QueryBuilder<OrderItemModel, int?, QQueryOperations> rightAxisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rightAxis');
    });
  }

  QueryBuilder<OrderItemModel, double?, QQueryOperations>
      rightCylinderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rightCylinder');
    });
  }

  QueryBuilder<OrderItemModel, double?, QQueryOperations>
      rightSphereProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rightSphere');
    });
  }

  QueryBuilder<OrderItemModel, int, QQueryOperations> unitPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unitPrice');
    });
  }
}
