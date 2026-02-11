import '../../domain/entities/account.dart';
import '../../domain/repositories/account_repository.dart';
import '../sources/account_local_source.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountLocalSource local;

  AccountRepositoryImpl(this.local);

  @override
  Future<Account> getAccount() => local.getAccount();

  @override
  Future<void> updateAccount(Account account) =>
      local.saveAccount(account);

  @override
  Future<void> clearAccount() => local.clear();
}
