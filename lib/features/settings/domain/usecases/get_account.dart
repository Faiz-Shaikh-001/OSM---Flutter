import '../entities/account.dart';
import '../repositories/account_repository.dart';

class GetAccount {
  final AccountRepository repo;
  GetAccount(this.repo);

  Future<Account> call() => repo.getAccount();
}
