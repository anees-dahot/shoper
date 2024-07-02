import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoper/features/home/provider/home_controller.dart';

import '../../../model/product.dart';
import '../../../utils.dart';
import '../../product detail/screen/product_detail.dart';
import '../../wishlist/controller/wishlist_controller.dart';

class NewArrivals extends StatefulWidget {
  const NewArrivals({super.key});

  @override
  State<NewArrivals> createState() => _NewArrivalsState();
}

class _NewArrivalsState extends State<NewArrivals> {
  HomeController homeController = Get.put(HomeController());

  WishListController wishListController = Get.put(WishListController());

  Future<void> fetchWishlistStatus() async {
    final userId = userBox.values.first.id; // Your user ID
    await wishListController.fetchWishlistStatus(
        homeController.trendingProducts, userId);
  }

  @override
  void initState() {
    super.initState();
    fetchWishlistStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.47,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New Arrivals',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Obx(() => homeController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeController.newArrivalProducts.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10.0),
                      itemBuilder: (context, index) {
                        final product =
                            homeController.newArrivalProducts[index];
                        final hasSale = product.sale! > 0.0;
                        final isInWishlist =
                           wishListController.wishlistStatus[product.id] ?? false;

                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            ProductDetail.routeName,
                            arguments: product,
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                              color: const Color(0xffFFF5E1),
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 6,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Product image with sale badge
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(15.0)),
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        product.images![0],
                                        width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        fit: BoxFit.cover,
                                      ),
                                      if (hasSale)
                                        Positioned(
                                          top: 10.0,
                                          left: 10.0,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 5.0),
                                            decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Text(
                                              "${product.sale!}%",
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                // Product details
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Product name
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(product.name!,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.lato(
                                                  textStyle: const TextStyle(
                                                    fontSize: 22.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                            const SizedBox(height: 8.0),
                                            // Prices
                                            priceRow(product, hasSale),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      // Rating section
                                        Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          ReviewWidget(product: product),
                                          Obx(() {
                                            final isInWishlist = wishListController.wishlistStatus[product.id] ?? false;
                                            return IconButton(
                                              onPressed: () async {
                                                final userId = userBox.values.first.id;
                                                if (isInWishlist) {
                                                  wishListController.removedFromWishlist(product.id!, userId);
                                                } else {
                                                  wishListController.addToWishList(product.id!, userId);
                                                }
                                              },
                                              icon: isInWishlist
                                                  ? const Icon(CupertinoIcons.heart_solid, color: Colors.red)
                                                  : const Icon(CupertinoIcons.heart, color: Colors.red),
                                            );
                                          }),
                                        ],
                                      )

                                      //* WishList button
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ))
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  // Extracted function for price formatting
  Widget priceRow(ProductModel product, bool hasSale) {
    String calculateSalePrice(double price, int salePercentage) {
      if (hasSale) {
        var salePercent = salePercentage / 100;
        var salePrice = price * salePercent;
        var finalPrice = price - salePrice;
        return finalPrice.toStringAsFixed(2);
      } else {
        return price.toStringAsFixed(2);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasSale)
          Text(
            "\$${product.price!.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.red,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        Text(
          "\$${calculateSalePrice(product.price!, product.sale!)}",
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 94, 93, 93),
          ),
        ),
      ],
    );
  }
}

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (product.reviews!.isEmpty)
          Row(
            children: [
              Icon(Icons.star_border, color: Colors.yellow[700], size: 20),
              Icon(Icons.star_border, color: Colors.yellow[700], size: 20),
              Icon(Icons.star_border, color: Colors.yellow[700], size: 20),
              Icon(Icons.star_border, color: Colors.yellow[700], size: 20),
              Icon(Icons.star_border, color: Colors.yellow[700], size: 20),
              const SizedBox(width: 8.0),
              const Text(
                "(0.0)",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          )
        else
          Row(
            children: [
              Row(
                children: List.generate(
                  product.reviews!.first.stars,
                  (index) => const Icon(Icons.star, color: Colors.amber),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                product.reviews!.first.stars.toString(),
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
      ],
    );
  }
}
