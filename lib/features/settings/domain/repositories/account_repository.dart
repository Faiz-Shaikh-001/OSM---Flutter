import '../entities/account.dart';

abstract class AccountRepository {
  Future<Account> getAccount();
  Future<void> updateAccount(Account account);
  Future<void> clearAccount();
}
