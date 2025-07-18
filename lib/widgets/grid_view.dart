import 'package:flutter/material.dart';
import 'package:osm/pages/item_page.dart';
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
        return GridCard(
          index: index,
          onTap: () async {
            final image = NetworkImage("https://picsum.dev/image$index/view");
            await precacheImage(image, context);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ItemPage(title: "Item$index", index: index),
              ),
            );
          },
        );
      }),
    );
  }
}
