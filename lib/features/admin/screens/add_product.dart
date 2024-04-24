import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoper/features/admin/widgets/categories_dropdown.dart';
import 'package:shoper/widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
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

  final productDetailsForm = GlobalKey<FormState>();

  final TextEditingController productQuantityController =
      TextEditingController();



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
              child: Form(
                key: productDetailsForm,
                child: Column(
                  children: [
                    ImageSelectorWidget(width: width, height: height),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:  10.0),
                      child: CustomTextField(
                          controller: productNameController,
                          hintText: 'Product Name',
                       ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                     padding: const EdgeInsets.symmetric(horizontal:  10.0),
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
                      padding: const EdgeInsets.symmetric(horizontal:  10.0),
                      child: CustomTextField(
                          controller: productPriceController,
                          hintText: 'Price',
                       ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                     padding: const EdgeInsets.symmetric(horizontal:  10.0),
                      child: CustomTextField(
                          controller: productQuantityController,
                          hintText: 'Quantity',
                       ),
                    ),
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
                      onTap: () {
                        if (productDetailsForm.currentState!.validate()) {
                          print('sds');
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
