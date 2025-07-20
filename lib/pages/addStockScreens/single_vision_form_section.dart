import 'package:flutter/material.dart';
import 'package:osm/widgets/build_text_field_widget.dart';
import 'package:osm/widgets/button_increment_decrement_widget.dart';
import 'package:osm/widgets/custom_button.dart';
import 'package:osm/widgets/image_selector_widget.dart';
import 'dart:io';

import '../../models/lens_model.dart';

class SingleVisionFormSection extends StatefulWidget {
  const SingleVisionFormSection({super.key});

  @override
  State<SingleVisionFormSection> createState() =>
      _SingleVisionFormSectionState();
}

class _SingleVisionFormSectionState extends State<SingleVisionFormSection> {
  final _formKey = GlobalKey<FormState>();

  LensMaterialType? _materialType;
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _indexController = TextEditingController();
  final TextEditingController _diameterController = TextEditingController();
  final TextEditingController _sphericalController = TextEditingController();
  final TextEditingController _cylindricalController = TextEditingController();
  final TextEditingController _pairController = TextEditingController();
  final TextEditingController _purchasePriceController =
      TextEditingController();
  final TextEditingController _salesPriceController = TextEditingController();

  final List<File> _selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ImageSelectorWidget(
              selectedImages: _selectedImages,
              onImagesChanged: (imgs) => setState(
                () => _selectedImages
                  ..clear()
                  ..addAll(imgs),
              ),
            ),

            DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Material Type'),
              value: _materialType,
              items: LensMaterialType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.displayName),
                );
              }).toList(),
              onChanged: (type) => setState(() => _materialType = type),
              validator: (value) =>
                  value == null ? 'Select Material Type' : null,
            ),

            BuildTextFieldWidget(
              controller: _companyNameController,
              label: "Company Name",
            ),
            BuildTextFieldWidget(
              controller: _productNameController,
              label: "Product Name",
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .43,
                      child: BuildTextFieldWidget(
                        isDecimal: true,
                        controller: _indexController,
                        label: "Index",
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .45,
                      child: Expanded(
                        child: BuildTextFieldWidget(
                          isDecimal: true,
                          controller: _diameterController,
                          label: "DIA",
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .43,
                      child: BuildTextFieldWidget(
                        isDecimal: true,
                        controller: _sphericalController,
                        label: "SPH",
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .45,
                      child: BuildTextFieldWidget(
                        isDecimal: true,
                        controller: _cylindricalController,
                        label: "CYL",
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: BuildTextFieldWidget(
                        controller: _pairController,
                        label: "Pair",
                      ),
                    ),
                    ButtonCounter(controller: _pairController),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .43,
                  child: BuildTextFieldWidget(
                    controller: _purchasePriceController,
                    label: "Purchase Price",
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .45,
                  child: BuildTextFieldWidget(
                    controller: _salesPriceController,
                    label: "Sales Price",
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            CustomButton(
              onPressed: () {
                SnackBar(content: Text("Submitted"));
              },
              label: "Submit",
              icon: Icons.check,
            ),
          ],
        ),
      ),
    );
  }
}
