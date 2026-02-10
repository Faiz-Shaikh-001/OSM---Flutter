import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:osm/features/dashboard/data/sources/accessory_search_source.dart';
import 'package:osm/features/dashboard/data/sources/frame_search_source.dart';
import 'package:osm/features/dashboard/data/sources/lens_search_source.dart';
import 'package:osm/features/inventory/domain/entities/accessory/accessory.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';
import 'package:osm/features/orders/presentation/value_objects/product_search_result.dart';

part 'product_search_event.dart';
part 'product_search_state.dart';

class ProductSearchBloc extends Bloc<ProductSearchEvent, ProductSearchState> {
  final FrameSearchSource frameSearch;
  final LensSearchSource lensSearch;
  final AccessorySearchSource accessorySearch;

  ProductSearchBloc({
    required this.frameSearch,
    required this.lensSearch,
    required this.accessorySearch,
  }) : super(ProductSearchInitial()) {
    on<ProductSearchQueryChanged>(_onQueryChanged);
    on<ProductSearchQrScanned>(_onQrScanned);
    on<ProductSearchCleared>(_onCleared);
  }

  Future<void> _onQueryChanged(
    ProductSearchQueryChanged event,
    Emitter<ProductSearchState> emit,
  ) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(ProductSearchInitial());
      return;
    }

    emit(const ProductSearchLoading());

    try {
      final results = await Future.wait([
        frameSearch.search(query),
        lensSearch.search(query),
        accessorySearch.search(query),
      ]);

      final frames = results[0] as List<Frame>;
      final lenses = results[1] as List<Lens>;
      final accessories = results[2] as List<Accessory>;

      final merged = <ProductSearchResult>[
        ...frames.expand(_mapFrameVariants),
        ...lenses.map(_mapLens),
        ...accessories.map(_mapAccessory),
      ];


      if (merged.isEmpty) {
        emit(const ProductSearchEmpty());
      } else {
        emit(ProductSearchLoaded(merged));
      }
    } catch (e) {
      emit(const ProductSearchError('Failed to search products'));
    }
  }

  void _onQrScanned(
    ProductSearchQrScanned event,
    Emitter<ProductSearchState> emit,
  ) {
    // todo: implement logic
  }

  void _onCleared(
    ProductSearchCleared event,
    Emitter<ProductSearchState> emit,
  ) {
    emit(ProductSearchInitial());
  }
}

Iterable<ProductSearchResult> _mapFrameVariants(Frame f) {
  return f.variants.map((v) {
    return ProductSearchResult(
      id: f.id.toString(),
      name: '${f.companyName} ${f.name} - ${v.colorName} - ${v.size}',
      sku: v.sku,
      code: v.productCode,
      type: ProductSearchType.frame,
      price: v.salesPrice,
      raw: v,
    );
  });
}

ProductSearchResult _mapLens(Lens l) {
  return ProductSearchResult(
    id: l.id.toString(),
    sku: l.sku,
    name: l.productName,
    code: l.productCode!,
    type: ProductSearchType.lens,
    price: l.salesPrice,
    raw: l,
  );
}

ProductSearchResult _mapAccessory(Accessory a) {
  return ProductSearchResult(
    id: a.id.toString(),
    sku: a.sku,
    name: a.name,
    code: a.sku,
    type: ProductSearchType.accessory,
    price: a.salesPrice,
    raw: a,
  );
}
