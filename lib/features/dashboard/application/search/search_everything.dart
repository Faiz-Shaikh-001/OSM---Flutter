import 'package:osm/core/either.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/dashboard/data/sources/accessory_search_source.dart';
import 'package:osm/features/dashboard/data/sources/customer_search_source.dart';
import 'package:osm/features/dashboard/data/sources/doctor_search_source.dart';
import 'package:osm/features/dashboard/data/sources/frame_search_source.dart';
import 'package:osm/features/dashboard/data/sources/lens_search_source.dart';
import 'package:osm/features/dashboard/data/sources/order_search_source.dart';
import 'package:osm/features/dashboard/domain/entities/search_result.dart';
import 'package:osm/features/dashboard/domain/failures/search_failure.dart';
import 'package:osm/features/dashboard/domain/value_objects/search_query.dart';
import 'package:osm/features/dashboard/presentation/models/search_results_ui_model.dart';
import 'package:osm/features/doctors/domain/entities/doctor.dart';
import 'package:osm/features/inventory/domain/entities/accessory/accessory.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';
import 'package:osm/features/orders/domain/entities/order.dart';

class SearchEverything {
  final OrderSearchSource _orderSearch;
  final CustomerSearchSource _customerSearch;
  final FrameSearchSource _frameSearch;
  final LensSearchSource _lensSearch;
  final AccessorySearchSource _accessorySearch;
  final DoctorSearchSource _doctorSearch;

  SearchEverything({
    required OrderSearchSource orderSearch,
    required CustomerSearchSource customerSearch,
    required FrameSearchSource frameSearch,
    required LensSearchSource lensSearch,
    required AccessorySearchSource accessorySearch,
    required DoctorSearchSource doctorSearch,
  }) : _orderSearch = orderSearch,
       _customerSearch = customerSearch,
       _frameSearch = frameSearch,
       _lensSearch = lensSearch,
       _accessorySearch = accessorySearch,
       _doctorSearch = doctorSearch;

  Future<Either<SearchFailure, List<SearchResult>>> call(
    SearchQuery query,
  ) async {
    if (query.isEmpty) {
      return const Right([]);
    }

    try {
      final results = <SearchResult>[];

      final responses = await Future.wait([
        _orderSearch.search(query.value),
        _customerSearch.search(query.value),
        _frameSearch.search(query.value),
        _lensSearch.search(query.value),
        _accessorySearch.search(query.value),
        _doctorSearch.search(query.value),
      ]);

      final orders = responses[0] as List<Order>;
      final customers = responses[1] as List<Customer>;
      final frames = responses[2] as List<Frame>;
      final lenses = responses[3] as List<Lens>;
      final accessories = responses[4] as List<Accessory>;
      final doctors = responses[5] as List<Doctor>;

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
          lenses.map(
            (l) => SearchResult(
              type: SearchResultType.lens,
              title: l.productName,
              subtitle: l.companyName,
              reference: l,
            ),
          ),
        )
        ..addAll(
          accessories.map(
            (a) => SearchResult(
              type: SearchResultType.accessory,
              title: a.name,
              subtitle: a.brand,
              reference: a,
            ),
          ),
        )
        ..addAll(
          doctors.map(
            (d) => SearchResult(
              type: SearchResultType.doctor,
              title: d.name,
              subtitle: d.designation,
              reference: d,
            ),
          ),
        );

      for (var frame in frames) {
        for (var variant in frame.variants) {
          results.add(
            SearchResult(
              type: SearchResultType.frame,
              title:
                  "${frame.name} - ${frame.companyName} - ${variant.colorName}",
              subtitle: "SKU: ${variant.sku} | Size: ${variant.size}",
              reference: frame,
            ),
          );
        }
      }

      return Right(results);
    } catch (_) {
      return const Left(SearchUnknownFailure());
    }
  }
}
