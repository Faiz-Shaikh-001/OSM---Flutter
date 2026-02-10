part of 'lens_list_bloc.dart';

@immutable
sealed class LensListState {}

final class LensListInitial extends LensListState {}

class LensListLoading extends LensListState {}

class LensListLoaded extends LensListState {
  final List<Lens> lenses;
  LensListLoaded(this.lenses);
}

class LensListActionSuccess extends LensListState {
  final String message;
  LensListActionSuccess(this.message);
}

class LensListError extends LensListState {
  final String message;
  LensListError(this.message);
}