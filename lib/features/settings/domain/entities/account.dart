class Account {
  final String name;
  final String email;
  final String phone;
  final String businessName;
  final String address;

  const Account({
    required this.name,
    required this.email,
    required this.phone,
    required this.businessName,
    required this.address,
  });

  factory Account.initial() {
    return const Account(
      name: '',
      email: '',
      phone: '',
      businessName: '',
      address: '',
    );
  }

  Account copyWith({
    String? name,
    String? email,
    String? phone,
    String? businessName,
    String? address,
  }) {
    return Account(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      businessName: businessName ?? this.businessName,
      address: address ?? this.address,
    );
  }
}
