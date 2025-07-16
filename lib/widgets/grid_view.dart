import 'package:flutter/material.dart';
import 'package:osm/widgets/grid_card.dart';

class GridViewWidget extends StatefulWidget {
  const GridViewWidget({super.key});

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: .8,
      children: List.generate(100, (index) {
        return GridCard(index: index);
      }),
    );
  }
}
