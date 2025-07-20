import 'package:flutter/material.dart';
import 'package:osm/widgets/build_text_field_widget.dart';
import 'package:osm/widgets/button_increment_decrement_widget.dart';
import 'package:osm/widgets/custom_button.dart';
import 'package:osm/widgets/image_selector_widget.dart';
import 'dart:io';

class ContactLensFormSection extends StatefulWidget {
  const ContactLensFormSection({super.key});

  @override
  State<ContactLensFormSection> createState() => _ContactLensFormSectionState();
}

class _ContactLensFormSectionState extends State<ContactLensFormSection> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _baseCurveController = TextEditingController();
  final TextEditingController _diameterController = TextEditingController();
  final TextEditingController _sphericalController = TextEditingController();
  final TextEditingController _cylindricalController = TextEditingController();
  final TextEditingController _axisController = TextEditingController();
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
                        controller: _baseCurveController,
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
                BuildTextFieldWidget(
                  isDecimal: true,
                  controller: _axisController,
                  label: "Axis",
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
