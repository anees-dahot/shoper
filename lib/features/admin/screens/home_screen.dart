import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoper/features/admin/screens/add_product.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const String routeName = '/admin-home';

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
      body: Column(
        children: [],
      ),
    );
  }
}
