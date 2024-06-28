import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoper/features/wishlist/controller/wishlist_controller.dart';
import 'package:shoper/features/wishlist/services/wishlist_service.dart';

import '../../../utils.dart';

class WishlistScreen extends StatefulWidget {
  static const String routeName = 'wishlist';

  WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final WishListController wishListController = Get.put(WishListController());
  WishListService wishListService = WishListService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wishListController.getWIshListProduct(userBox.values.first.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: GetBuilder<WishListController>(
        builder: (controller) => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : (controller.wishListItems.isEmpty)
                ? const Center(child: Text('No items in wishlist'))
                : ListView.builder(
                    itemCount: controller.wishListItems.length,
                    itemBuilder: (context, index) {
                      final data = controller.wishListItems[index];
                      return ListTile(
                        title: Text(data.name!),
                        subtitle: Text(data.description!),
                        // trailing: IconButton(
                        //   icon: Icon(Icons.delete),
                          // onPressed: () => wishListController.deleteWishListItem(index),
                        // ),
                      );
                    },
                  ),
      ),
    );
  }
}
