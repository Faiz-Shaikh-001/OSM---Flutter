import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/account.dart';
import '../../domain/usecases/get_account.dart';
import '../../domain/usecases/update_account.dart';

/// EVENTS
abstract class AccountEvent {}

class LoadAccount extends AccountEvent {}

class UpdateProfile extends AccountEvent {
  final String name;
  final String email;
  final String phone;
  final String businessName;
  final String address;
  final String? profileImagePath;

  UpdateProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.businessName,
    required this.address,
    this.profileImagePath,
  });
}

/// STATES
abstract class AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final Account account;
  AccountLoaded(this.account);
}

/// BLOC
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetAccount getAccount;
  final UpdateAccount updateAccount;

  AccountBloc({required this.getAccount, required this.updateAccount})
    : super(AccountLoading()) {
    on<LoadAccount>(_onLoad);
    on<UpdateProfile>(_onUpdate);
  }

  Future<void> _onLoad(LoadAccount event, Emitter<AccountState> emit) async {
    final account = await getAccount();
    emit(AccountLoaded(account));
  }

  Future<void> _onUpdate(
    UpdateProfile event,
    Emitter<AccountState> emit,
  ) async {
    if (state is! AccountLoaded) return;

    final updated = (state as AccountLoaded).account.copyWith(
      name: event.name,
      email: event.email,
      phone: event.phone,
      businessName: event.businessName,
      address: event.address,
      profileImagePath: event.profileImagePath,
    );

    await updateAccount(updated);
    emit(AccountLoaded(updated));
  }
}
