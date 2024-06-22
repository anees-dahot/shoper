import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoper/features/admin/services/admin_service.dart';
import 'package:shoper/model/product.dart';
import 'package:shoper/widgets/custom_button.dart';

import '../../../widgets/custom_textfield.dart';

class EditProduct extends StatefulWidget {
  static const routeName = "add-product";

  EditProduct({super.key, required this.products});
  ProductModel products;

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final productDetailsForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController productNameController =
        TextEditingController(text: widget.products.name);

    final TextEditingController productDescController =
        TextEditingController(text: widget.products.description);

    final TextEditingController productPriceController =
        TextEditingController(text: widget.products.price.toString());
    final TextEditingController productQuantityController =
        TextEditingController(text: widget.products.quantity.toString());
    final TextEditingController productSaleController = TextEditingController(
        text: widget.products.sale.toString());

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
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: CustomTextField(
                        labelText: 'Name',
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
                        labelText: 'Dexcription',
                        controller: productDescController,
                        numberOfLines: 7,
                        hintText: widget.products.name!,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: CustomTextField(
                        labelText: 'Price',
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
                        labelText: 'Quantity',
                        controller: productQuantityController,
                        hintText: 'Quantity',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: CustomTextField(
                        labelText: 'Sale',
                        controller: productSaleController,
                        hintText: 'Sale',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      text: 'Save',
                      onTap: () {
                        if (productDetailsForm.currentState!.validate()) {
                          ProductModel productModel = ProductModel(
                            name: productNameController.text,
                            price: double.parse(productPriceController.text),
                            description: productDescController.text,
                            quantity: int.parse(productQuantityController.text),
                            sale: int.parse(productSaleController.text),
                            senderId: widget.products.senderId,
                            category: widget.products.category,
                            images: widget.products.images,
                            reviews: widget.products.reviews,
                            colors: widget.products.colors,
                            sizes: widget.products.sizes,
                          );
                          adminService.updateProduct(
                              context, widget.products.id, productModel);
                        }
                      },
                      color: Colors.black,
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
