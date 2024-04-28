import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoper/constants/flutter_toast.dart';
import 'package:shoper/features/admin/screens/add_product.dart';
import 'package:shoper/features/admin/services/admin_service.dart';
import 'package:shoper/model/product.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  static const String routeName = '/admin-home';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  AdminService adminService = AdminService();
  // List<ProductModel>? products = [];

  // getProduct(BuildContext context) async {
  //   await adminService.getProducts(context).then((value) {
  //     setState(() {
  //       products = value;
  //     });

  //     print(products);
  //   }).onError((error, stackTrace) {
  //     errorsMessage(error.toString());
  //   });
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getProduct(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 100.0, right: 40),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(50)),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddProduct.routeName);
              },
              icon: const Icon(
                CupertinoIcons.add,
                color: Colors.white,
              ),
            ),
          )),
      body: FutureBuilder<List<ProductModel>>(
              future: adminService.getProducts(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final products = snapshot.data!;
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ListTile(
                        title: Text(product.name),
                        subtitle: Text(product.description),
                        trailing: Text('\$${product.price.toStringAsFixed(2)}'),
                        // You can add onTap handler to navigate to product details page
                        onTap: () {
                          // Navigate to product details page
                        },
                      );
                    },
                  );
                }
              },
            ),
    );
  }
}
