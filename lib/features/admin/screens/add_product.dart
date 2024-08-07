import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoper/constants/utils.dart';
import 'package:shoper/features/admin/controller/admin_controller.dart';
import 'package:shoper/features/admin/widgets/categories_dropdown.dart';
import 'package:shoper/features/admin/widgets/color_picker.dart';
import 'package:shoper/features/admin/widgets/product_image_slider.dart';
import 'package:shoper/features/admin/widgets/size_picker.dart';
import 'package:shoper/widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../services/admin_service.dart';
import '../widgets/image_selector_widget.dart';

class AddProduct extends StatefulWidget {
  static const routeName = "add-product";
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController productNameController = TextEditingController();

  final TextEditingController productDescController = TextEditingController();

  final TextEditingController productPriceController = TextEditingController();
  final AdminController adminController = Get.put(AdminController());

  final productDetailsForm = GlobalKey<FormState>();
  List<String> colors = [];
  List<int> sizes = [];

  final TextEditingController productQuantityController =
      TextEditingController();
  final TextEditingController colorsController = TextEditingController();
  final TextEditingController sizesController = TextEditingController();

  List<File> images = [];
  String selectedValue = 'Adidas';
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    productDescController.dispose();
    productPriceController.dispose();
    productQuantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    AdminService adminService = AdminService();

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
              child: Form(
                key: productDetailsForm,
                child: Column(
                  children: [
                    images.isEmpty
                        ? ImageSelectorWidget(
                            onTap: selectImages,
                            width: width,
                            height: height,
                          )
                        : GestureDetector(
                            onTap: selectImages,
                            child: ProductImageSlider(imageUrls: images)),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: CustomTextField(
                        controller: productNameController,
                        hintText: 'Product Name',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: CustomTextField(
                        controller: productDescController,
                        numberOfLines: 7,
                        hintText: 'Description',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: CustomTextField(
                        controller: productPriceController,
                        hintText: 'Price',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: CustomTextField(
                        controller: productQuantityController,
                        hintText: 'Quantity',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ColorPicker(
                        colorsController: colorsController, colors: colors),
                    SizePicker(sizesController: sizesController, sizes: sizes),
                    //  sizes.isEmpty ?  const SizedBox(
                    //     height: 20,
                    //   ) : Container(

                    //   ) ,
                    MyDropdown(
                      width: width * 0.95,
                      height: height * 0.08,
                      items: const [
                        'Adidas',
                        'Nike',
                        'Puma',
                        'Converse',
                        'Gucci',
                        'Skechers',
                        'Power',
                        'Batac',
                      ],
                      selectedValue: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value!;
                          print(selectedValue);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                   Obx(() =>  adminController.isLoading.value ? const Center(child: CircularProgressIndicator(),) : CustomButton(
                      text: 'Save',
                      onTap: () {
                        if (productDetailsForm.currentState!.validate()) {
                          adminController.addProduct(
                            context: context,
                            name: productNameController.text,
                            description: productDescController.text,
                            price: double.parse(productPriceController.text),
                            quantity: int.parse(productQuantityController.text),
                            category: selectedValue,
                            images: images,
                            colors: colors,
                            sizes: sizes,
                          );
                        }
                      },
                      color: Colors.black,
                    ),
                ),

                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
