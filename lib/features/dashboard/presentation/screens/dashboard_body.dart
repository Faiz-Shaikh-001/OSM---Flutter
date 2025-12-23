import 'package:flutter/material.dart';
import 'package:osm/features/dashboard/presentation/blocs/activity/activity_bloc.dart';
import 'package:osm/features/dashboard/presentation/models/activity_ui_model.dart';
import 'package:osm/features/dashboard/presentation/widgets/dashboard_history_section.dart';
import 'package:osm/features/dashboard/presentation/widgets/dashboard_recent_activities_section.dart';
import 'package:osm/features/dashboard/presentation/widgets/dashboard_summary_section.dart';
import 'package:osm/features/dashboard/presentation/widgets/global_search_delegate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildDashboardBody extends StatefulWidget {
  const BuildDashboardBody({super.key});

  @override
  State<BuildDashboardBody> createState() => _BuildDashboardBodyState();
}

class _BuildDashboardBodyState extends State<BuildDashboardBody> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ActivityBloc>().add(const WatchActivitiesEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildSearchBar(context),
            SizedBox(height: 30),
            DashboardSummarySection(),
            SizedBox(height: 30),
            DashboardHistorySection(),
            SizedBox(height: 30),
            _buildRecentActivities(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivities() {
    return BlocBuilder<ActivityBloc, ActivityState>(
      builder: (context, state) {
        if (state is ActivityLoading) {
          return const CircularProgressIndicator();
        }

        if (state is ActivityLoaded) {
          return DashboardRecentActivitiesSection(
            activities: state.activities
                .map(ActivityUiModel.fromEntity)
                .toList(),
          );
        }

        if (state is ActivityError) {
          return Text(state.message);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSearchBar(BuildContext content) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(content).size.width * .9,
      child: GestureDetector(
        onTap: () => showSearch(
          context: context,
          delegate: GlobalSearchDelegate(),
        ),
        child: AbsorbPointer(
          child: TextField(
            controller: _searchController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Search Orders, Customer, Product...',
              suffixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//   Widget _buildGlobalSearchDelegate(
//     BuildContext context,
//     TextEditingController controller,
//   ) {
//     return GestureDetector(
//       onTap: () async {
//         final result = await showSearch(
//           context: context,
//           delegate: GlobalSearchDelegate(
//             widget.lensRepository,
//             widget.frameRepository,
//             widget.orderRepository,
//             widget.customerRepository,
//           ),
//         );
//         if (result != null) {
//           if (result is OrderModel) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) {
//                   return OrderDetailsScreen(order: result);
//                 },
//               ),
//             );
//           } else if (result is FrameModel) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) {
//                   return ItemPage(
//                     product: result,
//                     productType: ProductType.frame,
//                   );
//                 },
//               ),
//             );
//           } else if (result is LensModel) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) {
//                   return ItemPage(
//                     product: result,
//                     productType: ProductType.lens,
//                   );
//                 },
//               ),
//             );
//           } else if (result is CustomerModel) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) {
//                   return CustomerDetailsScreen(customer: result);
//                 },
//               ),
//             );
//           }
//         }
//       },
//       child: AbsorbPointer(
//         child: TextField(
//           controller: controller,
//           readOnly: true,
//           decoration: InputDecoration(
//             labelText: 'Search Orders, Customer, Product,...',
//             suffixIcon: Icon(Icons.search),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//           ),
//           onChanged: (text) {
//             print('Text changed: $text');
//           },
//           obscureText: false, // Set to true for password fields
//         ),
//       ),
//     );
//   }
// }
