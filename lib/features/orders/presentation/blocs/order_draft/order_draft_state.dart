part of 'order_draft_bloc.dart';

class OrderDraftState extends Equatable {
  final OrderDraft draft;
  final Prescription? selectedPrescription;

  const OrderDraftState(this.draft, {this.selectedPrescription});

  factory OrderDraftState.initial() {
    return OrderDraftState(OrderDraft.empty());
  }

  OrderDraftState copyWith({
    OrderDraft? draft,
    Prescription? selectedPrescription,
    bool clearPrescription = false,
  }) {
    return OrderDraftState(
      draft ?? this.draft,
      selectedPrescription: clearPrescription
          ? null
          : (selectedPrescription ?? this.selectedPrescription),
    );
  }

  bool get canGoToProducts => draft.isCustomerSelected && draft.isStoreSelected;

  bool get canGoToPayment => draft.hasItems;

  bool get canSubmit =>
      draft.isCustomerSelected && draft.isStoreSelected && draft.hasItems;

  @override
  List<Object?> get props => [draft, selectedPrescription];
}
