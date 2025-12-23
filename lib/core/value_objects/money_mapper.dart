import 'package:osm/core/value_objects/money.dart';

class MoneyMapper {
  static Money fromPaise(int value) => Money(value / 100);

  static int toPaise(Money money) => (money.value * 100).round();
}
