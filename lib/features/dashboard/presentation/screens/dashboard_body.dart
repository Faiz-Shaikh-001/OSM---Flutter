import 'package:flutter/material.dart';
import 'package:osm/core/utils/product_type.dart';
import 'package:osm/features/customer/data/customer_model.dart';
import 'package:osm/features/customer/data/customer_repository.dart';
import 'package:osm/features/customer/presentation/screens/customer_details_screen.dart';
import 'package:osm/features/dashboard/presentation/widgets/dashboard_history_section.dart';
import 'package:osm/features/dashboard/presentation/widgets/dashboard_recent_activities_section.dart';
import 'package:osm/features/dashboard/presentation/widgets/dashboard_summary_section.dart';
import 'package:osm/features/dashboard/presentation/widgets/global_search_delegate.dart';
import 'package:osm/features/dashboard/viewmodel/activity_view_model.dart';
import 'package:osm/features/inventory/data/models/frame_model.dart';
import 'package:osm/features/inventory/data/models/lens_model.dart';
import 'package:osm/features/inventory/data/repositories/frame_repository.dart';
import 'package:osm/features/inventory/data/repositories/lens_repository.dart';
import 'package:osm/features/inventory/presentation/screens/item_screen.dart';
import 'package:osm/features/orders/data/models/order_model.dart';
import 'package:osm/features/orders/data/repositories/order_repository.dart';
import 'package:osm/features/orders/presentation/screens/order_detail_screen/order_detail_screen.dart';
import 'package:provider/provider.dart';

class BuildDashboardBody extends StatefulWidget {
  final FrameRepository frameRepository;
  final LensRepository lensRepository;
  final CustomerRepository customerRepository;
  final OrderRepository orderRepository;

  const BuildDashboardBody({
    super.key,
    required this.frameRepository,
    required this.lensRepository,
    required this.customerRepository,
    required this.orderRepository,
  });

  @override
  State<BuildDashboardBody> createState() => _BuildDashboardBodyState();
}

class _BuildDashboardBodyState extends State<BuildDashboardBody> {
  final TextEditingController _globalSearchController = TextEditingController();

  @override
  void dispose() {
    _globalSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activities = context.watch<ActivityViewModel>().activities;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * .90,
                  child: _buildGlobalSearchDelegate(
                    context,
                    _globalSearchController,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            DashboardSummarySection(),
            SizedBox(height: 30),
            DashboardHistorySection(),
            SizedBox(height: 30),
            DashboardRecentActivitiesSection(activities: activities)
          ],
        ),
      ),
    );
  }

  Widget _buildGlobalSearchDelegate(
    BuildContext context,
    TextEditingController controller,
  ) {
    return GestureDetector(
      onTap: () async {
        final result = await showSearch(
          context: context,
          delegate: GlobalSearchDelegate(
            widget.lensRepository,
            widget.frameRepository,
            widget.orderRepository,
            widget.customerRepository,
          ),
        );
        if (result != null) {
          if (result is OrderModel) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return OrderDetailsScreen(order: result);
                },
              ),
            );
          } else if (result is FrameModel) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return ItemPage(
                    product: result,
                    productType: ProductType.frame,
                  );
                },
              ),
            );
          } else if (result is LensModel) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return ItemPage(
                    product: result,
                    productType: ProductType.lens,
                  );
                },
              ),
            );
          } else if (result is CustomerModel) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return CustomerDetailsScreen(customer: result);
                },
              ),
            );
          }
        }
      },
      child: AbsorbPointer(
        child: TextField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'Search Orders, Customer, Product,...',
            suffixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onChanged: (text) {
            print('Text changed: $text');
          },
          obscureText: false, // Set to true for password fields
        ),
      ),
    );
  }
}
