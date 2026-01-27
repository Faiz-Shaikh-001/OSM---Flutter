part of 'product_search_bloc.dart';

sealed class ProductSearchEvent extends Equatable {
  const ProductSearchEvent();

  @override
  List<Object> get props => [];
}

class ProductSearchQueryChanged extends ProductSearchEvent {
  final String query;

  const ProductSearchQueryChanged(this.query);
}

class ProductSearchQrScanned extends ProductSearchEvent {
  final String code;

  const ProductSearchQrScanned(this.code);
}

class ProductSearchCleared extends ProductSearchEvent {
  const ProductSearchCleared();
}