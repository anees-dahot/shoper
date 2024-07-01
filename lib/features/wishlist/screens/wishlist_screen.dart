import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoper/features/wishlist/controller/wishlist_controller.dart';

import '../../../utils.dart';
import '../../product detail/screen/product_detail.dart';

class WishlistScreen extends StatefulWidget {
  static const String routeName = 'wishlist';

 const  WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final WishListController wishListController = Get.put(WishListController());

  @override
  void initState() {
    super.initState();
    wishListController.getWishListProducts(userBox.values.first.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: Obx(
        () => wishListController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : wishListController.wishListItems.isEmpty
                ? const Center(child: Text('No items in wishlist'))
                : ListView.builder(
                    itemCount: wishListController.wishListItems.length,
                    itemBuilder: (context, index) {
                      final product = wishListController.wishListItems[index];

                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          ProductDetail.routeName,
                          arguments: product,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 6,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  product.images!.isEmpty
                                      ? 'https://fastly.picsum.photos/id/807/2000/2000.jpg?hmac=QF7ItcVSx-ffgZAFjn_pa1Tiwn9LLi1UzMNmX8W6uaQ'
                                      : product.images![0],
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.22,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          product.name!,
                                          style: GoogleFonts.lato(
                                            textStyle: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          maxLines: 2,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            wishListController
                                                .removedFromWishlist(
                                                    product.id!,
                                                    userBox.values.first.id);
                                          },
                                          icon: Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Text(
                                        product.description!,
                                        style: GoogleFonts.lato(
                                          textStyle:
                                              const TextStyle(fontSize: 14.0),
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    ColorDots(colors: product.colors!),
                                    SizeLabels(sizes: product.sizes!),
                                    Text(
                                      product.quantity == 0
                                          ? 'Out of Stock'
                                          : 'In Stock',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: product.quantity == 0
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ),
                                    Text(
                                      '\$${product.price.toString()}',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}

class ColorDots extends StatelessWidget {
  final List<String> colors;

  const ColorDots({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 10, top: 10),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Color(int.parse('0xff${colors[index]}')),
              borderRadius: BorderRadius.circular(100),
            ),
          );
        },
      ),
    );
  }
}

class SizeLabels extends StatelessWidget {
  final List<int> sizes;

  const SizeLabels({super.key, required this.sizes});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sizes.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 10, top: 10),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(sizes[index].toString()),
          );
        },
      ),
    );
  }
}
