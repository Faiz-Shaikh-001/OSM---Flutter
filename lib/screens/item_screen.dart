import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:osm/data/models/frame_enums.dart';
import 'package:osm/widgets/qr_generator.dart';
import '../widgets/color_dropdown_widget.dart';
import '../widgets/size_dropdown_widget.dart';
import '../widgets/custom_button.dart';
import '../data/models/frame_model.dart';
import 'package:osm/screens/update_stock_screen.dart';

class ItemPage extends StatefulWidget {
  final FrameModel frameModel;
  final FrameVariant frameVariant;

  const ItemPage({
    super.key,
    required this.frameModel,
    required this.frameVariant,
  });

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    final FrameModel currentFrame = widget.frameModel;
    final FrameVariant currentVariant = widget.frameVariant;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Product Details")),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroImage(
                currentVariant.imageUrls.isNotEmpty
                    ? currentVariant.imageUrls.first
                    : "https://placehold.co/600x400/cccccc/000000?text=No+Image",
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: _buildProductDetails(
                  context,
                  currentFrame,
                  currentVariant,
                ),
              ),

              //Update Stock Button Navigation
              CustomButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UpdateStockScreen(),
                      settings: RouteSettings(
                        arguments: {
                          'name': currentFrame.name,
                          'quantity': 10,
                          'color': 'Red',
                          'size': 'Medium',
                          'purchase_price': 50.0,
                          'selling_price': 99.99,
                          'stock': 99,
                          'image': currentVariant.imageUrls.isNotEmpty
                              ? currentVariant.imageUrls.first
                              : null,
                        },
                      ),
                    ),
                  );
                },
                label: 'Edit Stock',
              ),

              const SizedBox(height: 10),
              CustomButton(
                onPressed: () async {
                  if (mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QrGeneratorWidget(
                          frame: currentFrame,
                          variant: currentVariant,
                        ),
                      ),
                    );
                  } else {
                    return;
                  }
                },
                label: 'Generate QR Code',
                icon: Icons.qr_code,
                background: Color(0xfff0f4f9),
                foreGround: Colors.black,
              ),
              const SizedBox(height: 25),
              CustomButton(
                onPressed: () {
                  debugPrint(
                    'Delete product: ${currentFrame.name} - ${currentVariant.productCode}',
                  );
                },
                label: 'Delete Product',
                icon: Icons.delete_forever_outlined,
                background: Color(0xfff0f4f9),
                foreGround: Colors.red,
              ),
              const SizedBox(height: 25),
              const DeleteWarningBanner(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroImage(String imageUrl) {
    return Hero(
      tag:
          'itemIndex_${widget.frameModel.id}_${widget.frameVariant.productCode}',
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 300,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const SizedBox(
          width: double.infinity,
          height: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.error), Text('Error loading image')],
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetails(
    BuildContext context,
    FrameModel frame,
    FrameVariant variant,
  ) {
    final titleStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    final labelStyle = TextStyle(fontSize: 20, color: Colors.grey);
    final priceStyle = TextStyle(
      fontSize: 25,
      color: Colors.blue,
      fontWeight: FontWeight.bold,
    );
    final stockStyle = TextStyle(fontSize: 20, color: Colors.blueGrey);
    final captionStyle = TextStyle(fontSize: 15, color: Colors.blueGrey);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${frame.companyName} - ${frame.name}", style: titleStyle),
        Text('SKU: ${variant.productCode}', style: labelStyle),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '\$${variant.salesPrice?.toStringAsFixed(2)}',
              style: priceStyle,
            ),
            Text('In Stock: ${variant.quantity}', style: stockStyle),
          ],
        ),
        const SizedBox(height: 25),
        const ColorDropDownWidget(), // TODO: Make these dynamic
        const SizeDropdownWidget(), // TODO: make these dynamic
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Category', style: captionStyle),
            Text(frame.frameType.displayName, style: TextStyle(fontSize: 15)),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class DeleteWarningBanner extends StatelessWidget {
  const DeleteWarningBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: .2, color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        width: MediaQuery.of(context).size.width * .9,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.warning, color: Colors.red),
            const SizedBox(width: 10),
            Expanded(
              child: const Text(
                'Deleting this product will permanently remove it from the inventory. This action cannot be undone.',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
