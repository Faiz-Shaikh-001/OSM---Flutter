import '../../domain/entities/account.dart';
import '../../domain/repositories/account_repository.dart';
import '../sources/account_local_source.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountLocalSource localSource;

  const AccountRepositoryImpl(this.localSource);

  @override
  Future<Account> getAccount() => localSource.getAccount();

  @override
  Future<void> updateAccount(Account account) =>
      localSource.saveAccount(account);

  @override
  Future<void> clearAccount() => localSource.clear();
}
