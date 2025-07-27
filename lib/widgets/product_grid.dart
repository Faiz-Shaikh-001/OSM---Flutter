import 'package:flutter/material.dart';
import 'package:osm/screens/item_screen.dart';
import 'package:osm/widgets/grid_card.dart';
import 'package:osm/data/models/frame_enums.dart';
import 'package:osm/data/models/frame_model.dart';

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
            final currentContext = context;
            await precacheImage(image, context);

            final dummyFrameModel = FrameModel(
              companyName: 'DummyCo',
              frameType:
                  FrameType.fullMetal, // Using an actual FrameType enum value
              name: 'DummyFrame ${index + 1}',
              // variants list can be empty or have a dummy variant
              variants: [],
            );
            final dummyColor = Color(
              0xFF000000 + (index * 0x101010) % 0xFFFFFF,
            );

            // Example dummy color
            final dummyColorName =
                'Color ${index + 1}'; // Simple dummy color name
            final dummySize = 50 + (index % 10); // Dummy size

            final dummyProductCode = FrameVariant.generateProductCode(
              dummyFrameModel.frameType,
              dummyFrameModel.companyName,
              dummyFrameModel.name,
              'DUMMY-${index + 1}', // variantCode (FrameVariant's code field)
              dummyColorName,
              dummySize,
            );

            final dummyFrameVariant = FrameVariant(
              code: 'DUMMY-${index + 1}',
              color: dummyColor,
              colorName: dummyColorName,
              size: dummySize,
              productCode: dummyProductCode,
              quantity: 10 + index,
              purchasePrice: 20.0 + index,
              salesPrice: 50.0 + index,
              imageUrls: ["https://picsum.dev/image/$index/view"],
            );

            // Add the dummy variant to the dummy frame model for passing
            dummyFrameModel.variants.add(dummyFrameVariant);

            if (mounted) {
              Navigator.push(
                currentContext,
                MaterialPageRoute(
                  builder: (context) => ItemPage(
                    frameModel: dummyFrameModel,
                    frameVariant: dummyFrameVariant,
                  ),
                ),
              );
            } else {
              return;
            }
          },
        );
      }),
    );
  }
}
