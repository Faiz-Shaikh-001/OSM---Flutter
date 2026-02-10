class Quantity {
  final int value;

  Quantity(this.value) {
    if (value <= 0) {
      throw ArgumentError('Quantity must be greater than zero');
    }
  }

  Quantity operator +(Quantity other) =>
      Quantity(value + other.value);

  Quantity operator -(Quantity other) {
    final result = value - other.value;
    if (result <= 0) {
      throw ArgumentError('Quantity cannot be zero or negative');
    }
    return Quantity(result);
  }

  @override
  String toString() => value.toString();
}
