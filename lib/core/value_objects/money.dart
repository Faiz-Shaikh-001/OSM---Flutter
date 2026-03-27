class Money {
  final double value;

  const Money(this.value) : assert(value >= 0, 'Money cannot be negative');

  Money operator +(Money other) => Money(value + other.value);
  Money operator -(Money other) {
    final result = value - other.value;
    if (result < 0) {
      throw ArgumentError('Resulting money cannot be negative');
    }
    return Money(result);
  }

  bool operator >(Money other) => value > other.value;
  bool operator <(Money other) => value < other.value;

  bool get isZero => value == 0;

  @override
  String toString() => value.toStringAsFixed(2);
}
