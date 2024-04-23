import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoper/features/admin/widgets/categories_dropdown.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/image_selector_widget.dart';

class AddProduct extends StatelessWidget {
  static const routeName = "add-product";
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    List<String> categories = [
      'adidas',
      'nike',
      'puma',
      'converse',
    ];
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Text(
                  'Add Product',
                  style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                    fontSize: 20,
                  )),
                ),
              ],
            ),
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageSelectorWidget(width: width, height: height),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFIeld(
                    hintText: 'Product Name',
                    width: width * 0.9,
                    height: height * 0.08),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFIeld(
                    numberOfLines: 30,
                    hintText: 'Description',
                    width: width * 0.9,
                    height: height * 0.3),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFIeld(
                    hintText: 'Price',
                    width: width * 0.9,
                    height: height * 0.08),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFIeld(
                    hintText: 'Quantity',
                    width: width * 0.9,
                    height: height * 0.08),
                const SizedBox(
                  height: 20,
                ),
                MyDropdown(
                    width: width * 0.9,
                    height: height * 0.08,
                  items: ["Item 1", "Item 2", "Item 3"],
                  initialValue: "Item 2", // Optional
                )
              ],
            ),
          )),
    );
  }
}
