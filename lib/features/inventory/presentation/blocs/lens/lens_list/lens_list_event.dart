part of 'lens_list_bloc.dart';

@immutable
sealed class LensListEvent {}

class LoadLensesEvent extends LensListEvent {}

class SearchLensesByCompanyEvent extends LensListEvent {
  final String companyName;
  SearchLensesByCompanyEvent(this.companyName);
}

class SearchLensesByProductNameEvent extends LensListEvent {
  final String productName;
  SearchLensesByProductNameEvent(this.productName);
}

class SearchLensesByTypeEvent extends LensListEvent {
  final LensType type;
  SearchLensesByTypeEvent(this.type);
}

class CreateLensEvent extends LensListEvent {
  final CreateLensInput input;
  CreateLensEvent(this.input);
}

class UpdateLensEvent extends LensListEvent {
  final Lens lens;
  UpdateLensEvent(this.lens);
}

class DeleteLensEvent extends LensListEvent {
  final LensId id;
  DeleteLensEvent(this.id);
}