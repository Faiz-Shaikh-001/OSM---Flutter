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
    r'addPower': PropertySchema(
      id: 0,
      name: r'addPower',
      type: IsarType.double,
    ),
    r'axis': PropertySchema(
      id: 1,
      name: r'axis',
      type: IsarType.long,
    ),
    r'cylindrical': PropertySchema(
      id: 2,
      name: r'cylindrical',
      type: IsarType.double,
    ),
    r'itemType': PropertySchema(
      id: 3,
      name: r'itemType',
      type: IsarType.string,
      enumMap: _OrderItemModelitemTypeEnumValueMap,
    ),
    r'materialType': PropertySchema(
      id: 4,
      name: r'materialType',
      type: IsarType.string,
      enumMap: _OrderItemModelmaterialTypeEnumValueMap,
    ),
    r'productCode': PropertySchema(
      id: 5,
      name: r'productCode',
      type: IsarType.string,
    ),
    r'productName': PropertySchema(
      id: 6,
      name: r'productName',
      type: IsarType.string,
    ),
    r'quantity': PropertySchema(
      id: 7,
      name: r'quantity',
      type: IsarType.long,
    ),
    r'refractiveIndex': PropertySchema(
      id: 8,
      name: r'refractiveIndex',
      type: IsarType.double,
    ),
    r'spherical': PropertySchema(
      id: 9,
      name: r'spherical',
      type: IsarType.double,
    ),
    r'unitPrice': PropertySchema(
      id: 10,
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
  writer.writeDouble(offsets[0], object.addPower);
  writer.writeLong(offsets[1], object.axis);
  writer.writeDouble(offsets[2], object.cylindrical);
  writer.writeString(offsets[3], object.itemType.name);
  writer.writeString(offsets[4], object.materialType?.name);
  writer.writeString(offsets[5], object.productCode);
  writer.writeString(offsets[6], object.productName);
  writer.writeLong(offsets[7], object.quantity);
  writer.writeDouble(offsets[8], object.refractiveIndex);
  writer.writeDouble(offsets[9], object.spherical);
  writer.writeLong(offsets[10], object.unitPrice);
}

OrderItemModel _orderItemModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = OrderItemModel(
    addPower: reader.readDoubleOrNull(offsets[0]),
    axis: reader.readLongOrNull(offsets[1]),
    cylindrical: reader.readDoubleOrNull(offsets[2]),
    itemType: _OrderItemModelitemTypeValueEnumMap[
            reader.readStringOrNull(offsets[3])] ??
        OrderItemTypeModel.frame,
    materialType: _OrderItemModelmaterialTypeValueEnumMap[
        reader.readStringOrNull(offsets[4])],
    productCode: reader.readString(offsets[5]),
    productName: reader.readString(offsets[6]),
    quantity: reader.readLong(offsets[7]),
    refractiveIndex: reader.readDoubleOrNull(offsets[8]),
    spherical: reader.readDoubleOrNull(offsets[9]),
    unitPrice: reader.readLong(offsets[10]),
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
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (_OrderItemModelitemTypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          OrderItemTypeModel.frame) as P;
    case 4:
      return (_OrderItemModelmaterialTypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset)) as P;
    case 9:
      return (reader.readDoubleOrNull(offset)) as P;
    case 10:
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
      addPowerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'addPower',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      addPowerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'addPower',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      axisIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'axis',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      axisIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'axis',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      axisEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'axis',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      axisGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'axis',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      axisLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'axis',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      axisBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'axis',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      cylindricalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cylindrical',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      cylindricalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cylindrical',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      cylindricalEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cylindrical',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      cylindricalGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cylindrical',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      cylindricalLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cylindrical',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      cylindricalBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cylindrical',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
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
      refractiveIndexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'refractiveIndex',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      refractiveIndexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'refractiveIndex',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      refractiveIndexEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'refractiveIndex',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      refractiveIndexGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'refractiveIndex',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      refractiveIndexLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'refractiveIndex',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      refractiveIndexBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'refractiveIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      sphericalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'spherical',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      sphericalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'spherical',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      sphericalEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spherical',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      sphericalGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'spherical',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      sphericalLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'spherical',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      sphericalBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'spherical',
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
  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByAddPower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addPower', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByAddPowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addPower', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByAxis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'axis', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByAxisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'axis', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByCylindrical() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cylindrical', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByCylindricalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cylindrical', Sort.desc);
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByRefractiveIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refractiveIndex', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByRefractiveIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refractiveIndex', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortBySpherical() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spherical', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortBySphericalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spherical', Sort.desc);
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
  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByAddPower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addPower', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByAddPowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addPower', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByAxis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'axis', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByAxisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'axis', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByCylindrical() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cylindrical', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByCylindricalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cylindrical', Sort.desc);
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByRefractiveIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refractiveIndex', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByRefractiveIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'refractiveIndex', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenBySpherical() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spherical', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenBySphericalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spherical', Sort.desc);
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
  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByAddPower() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'addPower');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByAxis() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'axis');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct>
      distinctByCylindrical() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cylindrical');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByItemType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'itemType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct>
      distinctByMaterialType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'materialType', caseSensitive: caseSensitive);
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

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct>
      distinctByRefractiveIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'refractiveIndex');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct>
      distinctBySpherical() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'spherical');
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

  QueryBuilder<OrderItemModel, double?, QQueryOperations> addPowerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'addPower');
    });
  }

  QueryBuilder<OrderItemModel, int?, QQueryOperations> axisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'axis');
    });
  }

  QueryBuilder<OrderItemModel, double?, QQueryOperations>
      cylindricalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cylindrical');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemTypeModel, QQueryOperations>
      itemTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'itemType');
    });
  }

  QueryBuilder<OrderItemModel, LensMaterialTypeModel?, QQueryOperations>
      materialTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'materialType');
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

  QueryBuilder<OrderItemModel, double?, QQueryOperations>
      refractiveIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'refractiveIndex');
    });
  }

  QueryBuilder<OrderItemModel, double?, QQueryOperations> sphericalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spherical');
    });
  }

  QueryBuilder<OrderItemModel, int, QQueryOperations> unitPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unitPrice');
    });
  }
}
