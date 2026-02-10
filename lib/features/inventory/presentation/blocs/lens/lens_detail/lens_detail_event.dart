part of 'lens_detail_bloc.dart';

@immutable
sealed class LensDetailEvent {}

class GetLensByIdEvent extends LensDetailEvent {
  final LensId id;
  GetLensByIdEvent(this.id);
}