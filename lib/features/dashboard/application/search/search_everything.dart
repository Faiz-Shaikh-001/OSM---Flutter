import 'package:osm/core/either.dart';
import 'package:osm/features/dashboard/data/sources/customer_search_source.dart';
import 'package:osm/features/dashboard/data/sources/frame_search_source.dart';
import 'package:osm/features/dashboard/data/sources/lens_search_source.dart';
import 'package:osm/features/dashboard/data/sources/order_search_source.dart';
import 'package:osm/features/dashboard/domain/entities/search_result.dart';
import 'package:osm/features/dashboard/domain/failures/search_failure.dart';
import 'package:osm/features/dashboard/domain/value_objects/search_query.dart';

class SearchEverything {
  final OrderSearchSource orderSearch;
  final CustomerSearchSource customerSearch;
  final FrameSearchSource frameSearch;
  final LensSearchSource lensSearch;

  SearchEverything({
    required this.orderSearch,
    required this.customerSearch,
    required this.frameSearch,
    required this.lensSearch,
  });

  Future<Either<SearchFailure, List<SearchResult>>> call(
    SearchQuery query,
  ) async {
    if (query.isEmpty) {
      return const Right([]);
    }

    try {
      final results = <SearchResult>[];

      final orders = await orderSearch.search(query.value);
      final customers = await customerSearch.search(query.value);
      final frames = await frameSearch.search(query.value);
      final lenses = await lensSearch.search(query.value);

      results
        ..addAll(
          orders.map(
            (o) => SearchResult(
              type: SearchResultType.order,
              title: 'Order #${o.id.value}',
              subtitle: o.customerId.value,
              reference: o,
            ),
          ),
        )
        ..addAll(
          customers.map(
            (c) => SearchResult(
              type: SearchResultType.customer,
              title: c.fullName,
              subtitle: c.primaryPhoneNumber,
              reference: c,
            ),
          ),
        )
        ..addAll(
          frames.map(
            (f) => SearchResult(
              type: SearchResultType.frame,
              title: f.name,
              subtitle: f.companyName,
              reference: f,
            ),
          ),
        )
        ..addAll(
          lenses.map(
            (l) => SearchResult(
              type: SearchResultType.lens,
              title: l.productName,
              subtitle: l.companyName,
              reference: l,
            ),
          ),
        );

      return Right(results);
    } catch (_) {
      return const Left(SearchUnknownFailure());
    }
  }
}
