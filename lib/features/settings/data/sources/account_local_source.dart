import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/account.dart';

class AccountLocalSource {
  static const _key = 'account_data';

  Future<Account> getAccount() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null) {
      return Account.initial();
    }

    final map = json.decode(jsonString);
    return Account(
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      businessName: map['businessName'] ?? '',
      address: map['address'] ?? '',
    );
  }

  Future<void> saveAccount(Account account) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key,
      json.encode({
        'name': account.name,
        'email': account.email,
        'phone': account.phone,
      }),
    );
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
