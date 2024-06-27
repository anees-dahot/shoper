import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoper/features/home/provider/home_controller.dart';
import '../../../model/product.dart';
import '../../product detail/screen/product_detail.dart';

class DealOFDay extends StatefulWidget {
  DealOFDay({super.key});

  @override
  State<DealOFDay> createState() => _DealOFDayState();
}

class _DealOFDayState extends State<DealOFDay> {
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.45,
        child: Column(children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Deals of the day',
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
                    itemCount: homeController.trendingProducts.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10.0),
                    itemBuilder: (context, index) {
                      final product = homeController.trendingProducts[index];
                      final hasSale = product.sale! > 0.0;
                      bool inWishlist =
                          homeController.isProductInWishlist(product);
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
                            color: Color(0xffFFF5E1),
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
                                child: Image.network(
                                  product.images![0],
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.width * 0.4,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // Product details
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                textStyle: TextStyle(
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                          const SizedBox(height: 8.0),
                                          // Prices
                                          Text(
                                            "\$${product.price!.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: const Color.fromARGB(
                                                  255, 94, 93, 93),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // const SizedBox(height: 8.0),
                                    // Rating section
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ReviewWidget(product: product),
                                        IconButton(
                                          onPressed: ()  {inWishlist
                                              ? homeController
                                                  .removeFromWishlist(
                                                      product.id!)
                                              : homeController
                                                  .addToWishlist(product); setState(() {
                                                    
                                                  });},
                                          icon: inWishlist
                                              ? const Icon(
                                                  CupertinoIcons.heart_solid,
                                                  color: Colors.red,
                                                )
                                              : const Icon(
                                                  CupertinoIcons.heart,
                                                  color: Colors.red,
                                                ),
                                        )
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
        ]),
      ),
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
              Text(
                "(0.0)",
                style: const TextStyle(color: Colors.grey),
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
