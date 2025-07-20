import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:osm/widgets/qr_generator.dart';
import '../widgets/color_dropdown_widget.dart';
import '../widgets/size_dropdown_widget.dart';
import '../widgets/custom_button.dart';
import '../models/frame_model.dart';

class ItemPage extends StatefulWidget {
  final String title;
  final int index;

  const ItemPage({super.key, required this.title, required this.index});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
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
              _buildHeroImage(widget.index),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: _buildProductDetails(context),
              ),
              CustomButton(onPressed: () {}, label: 'Update Stock'),
              const SizedBox(height: 10),
              CustomButton(
                onPressed: () async {
                  final frame = await Frame.createWithColorName(
                    frameType: FrameType.halfRimless,
                    name: "Aviator Steel",
                    code: "AV123",
                    color: Color(0xff472910),
                    size: 48,
                    quantity: 10,
                    purchasePrice: 100,
                    salesPrice: 100,
                  ); // Output: FRAME-2-AV123-Blac-48

                  if (!mounted) return;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QrGeneratorWidget(frame: frame),
                    ),
                  );
                },
                label: 'Generate QR Code',
                icon: Icons.qr_code,
                background: Color(0xfff0f4f9),
                foreGround: Colors.black,
              ),
              const SizedBox(height: 25),
              CustomButton(
                onPressed: () {},
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

  Widget _buildHeroImage(int index) {
    return Hero(
      tag: 'itemIndex_$index',
      child: CachedNetworkImage(
        imageUrl: "https://picsum.dev/image/$index/view",
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

  Widget _buildProductDetails(BuildContext context) {
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
        Text(widget.title, style: titleStyle),
        Text('SKU: ', style: labelStyle), // TODO: Replace with actual sku
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '\$99.99',
              style: priceStyle,
            ), // TODO: Replace with dynamic price
            Text(
              'In Stock: 99',
              style: stockStyle,
            ), // TODO: Replace with actual stock
          ],
        ),
        const SizedBox(height: 25),
        const ColorDropDownWidget(),
        const SizeDropdownWidget(),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Category', style: captionStyle),
            Text(
              'Aviator',
              style: TextStyle(fontSize: 15),
            ), // TODO: replace with actual category
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
