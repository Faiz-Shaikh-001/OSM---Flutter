part of 'product_search_bloc.dart';

sealed class ProductSearchState extends Equatable {
  const ProductSearchState();

  @override
  List<Object> get props => [];
}

final class ProductSearchInitial extends ProductSearchState {}

final class ProductSearchLoading extends ProductSearchState {
  const ProductSearchLoading();
}

final class ProductSearchLoaded extends ProductSearchState {
  final List<ProductSearchResult> results;

  const ProductSearchLoaded(this.results);
}

final class ProductSearchEmpty extends ProductSearchState {
  const ProductSearchEmpty();
}

final class ProductSearchError extends ProductSearchState {
  final String message;

  const ProductSearchError(this.message);
}
