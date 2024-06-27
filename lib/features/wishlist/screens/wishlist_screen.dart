import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoper/features/wishlist/controller/wishlist_controller.dart';

class WishlistScreen extends StatefulWidget {
  static const String routeName = 'wishlist';
  WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {

   WishListController wishListController = Get.put(WishListController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wishListController.getWishListItems();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: Column(
        children: [
          GetBuilder<WishListController>(builder: (controller) {
            return Expanded(
                child: ListView.builder(
              itemCount: controller.wishListItems.length,
              itemBuilder: (context, index) {
                final data = controller.wishListItems[index];
                return ListTile(
                  title: Text(data.name!),
                  subtitle: Text(data.description!),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // wishListController.deleteWishListItem(index);
                    },
                  ),
                );
              },
            ));
          })
        ],
      ),
    );
  }
}
