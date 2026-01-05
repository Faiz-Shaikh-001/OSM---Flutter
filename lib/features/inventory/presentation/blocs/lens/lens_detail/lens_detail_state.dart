part of 'lens_detail_bloc.dart';

@immutable
sealed class LensDetailState {}

final class LensDetailInitial extends LensDetailState {}

class LensDetailLoading extends LensDetailState {}

class LensDetailLoaded extends LensDetailState {
  final Lens lens;
  LensDetailLoaded(this.lens);
}

class LensDetailError extends LensDetailState {
  final String message;
  LensDetailError(this.message);
}
