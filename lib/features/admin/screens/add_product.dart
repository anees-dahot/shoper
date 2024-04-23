import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoper/features/admin/widgets/categories_dropdown.dart';
import 'package:shoper/widgets/custom_button.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/image_selector_widget.dart';

class AddProduct extends StatefulWidget {
  static const routeName = "add-product";
  AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController productNameController = TextEditingController();

  final TextEditingController productDescController = TextEditingController();

  final TextEditingController productPriceController = TextEditingController();

  final TextEditingController productQuantityController =
      TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
  String _selectedValue = "adidas";    
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
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImageSelectorWidget(width: width, height: height),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFIeld(
                      controller: productNameController,
                      hintText: 'Product Name',
                      width: width * 0.95,
                      height: height * 0.08),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFIeld(
                      controller: productDescController,
                      numberOfLines: 30,
                      hintText: 'Description',
                      width: width * 0.95,
                      height: height * 0.3),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFIeld(
                      controller: productPriceController,
                      hintText: 'Price',
                      width: width * 0.95,
                      height: height * 0.08),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFIeld(
                      controller: productQuantityController,
                      hintText: 'Quantity',
                      width: width * 0.95,
                      height: height * 0.08),
                  const SizedBox(
                    height: 20,
                  ),
                  MyDropdown(
                    width: width * 0.95,
                    height: height * 0.08,
                    items: const [
                      'adidas',
                      'nike',
                      'puma',
                      'converse',
                    ],
                    initialValue: "adidas", // Optional
                    selectedValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value!;
                        print(_selectedValue);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: 'Save',
                    onTap: () {},
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
