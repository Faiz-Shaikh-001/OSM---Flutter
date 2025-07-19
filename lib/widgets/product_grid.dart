import 'package:flutter/material.dart';
import 'package:osm/pages/item_screen.dart';
import 'package:osm/widgets/grid_card.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
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
