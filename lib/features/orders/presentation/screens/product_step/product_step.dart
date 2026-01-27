import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/features/dashboard/data/sources/accessory_search_source.dart';
import 'package:osm/features/dashboard/data/sources/frame_search_source.dart';
import 'package:osm/features/dashboard/data/sources/lens_search_source.dart';
import 'package:osm/features/dashboard/data/sources_impl/accessory_search_source_impl.dart';
import 'package:osm/features/dashboard/data/sources_impl/frame_search_source_impl.dart';
import 'package:osm/features/dashboard/data/sources_impl/lens_search_source_impl.dart';
import 'package:osm/features/orders/presentation/blocs/order_draft/order_draft_bloc.dart';
import 'package:osm/features/orders/presentation/blocs/product_search/product_search_bloc.dart';
import 'package:osm/features/orders/presentation/screens/product_step/product_search_screen.dart';
import 'package:osm/features/orders/presentation/screens/product_step/widgets/empty_state_view.dart';
import 'package:osm/features/orders/presentation/screens/product_step/widgets/product_list_view.dart';
import 'package:provider/provider.dart';

class ProductStep extends StatelessWidget {
  final VoidCallback onNext;

  const ProductStep({super.key, required this.onNext});

  void onSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MultiProvider(
          providers: [
            Provider<AccessorySearchSource>(
              create: (context) =>
                  AccessorySearchSourceImpl(context.read<IsarService>()),
            ),
            Provider<FrameSearchSource>(
              create: (context) =>
                  FrameSearchSourceImpl(context.read<IsarService>()),
            ),
            Provider<LensSearchSource>(
              create: (context) =>
                  LensSearchSourceImpl(context.read<IsarService>()),
            ),
            BlocProvider(
              create: (context) => ProductSearchBloc(
                frameSearch: context.read<FrameSearchSource>(),
                lensSearch: context.read<LensSearchSource>(),
                accessorySearch: context.read<AccessorySearchSource>(),
              ),
            ),
          ],
          child: const ProductSearchScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDraftBloc, OrderDraftState>(
      builder: (context, state) {
        final items = state.draft.items;

        if (items.isEmpty) {
          return EmptyStateView(
            onScan: () {
              debugPrint("Scan pressed");
            },
            onSearch: () {
              onSearch(context);
            },
          );
        }

        return ProductListView(
          items: items,
          onSearch: () {
            onSearch(context);
          },
        );
      },
    );
  }
}
