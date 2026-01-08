part of 'order_draft_bloc.dart';

class OrderDraftState extends Equatable {
  final OrderDraft draft;

  const OrderDraftState(this.draft);

  factory OrderDraftState.initial() {
    return OrderDraftState(OrderDraft.empty());
  }

  bool get canGoToProducts => draft.isCustomerSelected && draft.isStoreSelected;

  bool get canGoToPayment => draft.hasItems;

  bool get canSubmit =>
      draft.isCustomerSelected && draft.isStoreSelected && draft.hasItems;

  @override
  List<Object?> get props => [draft];
}
