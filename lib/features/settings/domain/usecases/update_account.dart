import '../entities/account.dart';
import '../repositories/account_repository.dart';

class UpdateAccount {
  final AccountRepository repo;
  UpdateAccount(this.repo);

  Future<void> call(Account account) => repo.updateAccount(account);
}
