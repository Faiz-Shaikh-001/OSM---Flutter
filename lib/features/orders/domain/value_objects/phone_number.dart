class PhoneNumber {
  final String value;

  PhoneNumber(this.value) {
    final cleaned = value.replaceAll(RegExp(r'\D'), '');
    if (cleaned.length < 10) {
      throw ArgumentError('Invalid phone number');
    }
  }

  @override
  String toString() => value;
}
