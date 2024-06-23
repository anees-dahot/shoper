import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoper/features/home/provider/home_provider.dart';
import 'package:shoper/features/product%20detail/services/product_service.dart';

import '../../../model/product.dart';
import '../../product detail/screen/product_detail.dart';

class OnSale extends StatefulWidget {
  OnSale({super.key});

  @override
  State<OnSale> createState() => _OnSaleState();
}

class _OnSaleState extends State<OnSale> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     
    });
  }

  @override
 
  Widget build(BuildContext context) {
    void getData(){
      
    }
    final ProductSerivce productService = ProductSerivce();
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.45,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'On Sale',
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Consumer<HomeProvider>(
            builder: (context, homeProvider, child) {
              if (homeProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (homeProvider.errorMessage.isNotEmpty) {
                return Center(
                    child: Text('Error: ${homeProvider.errorMessage}'));
              } else {
                final data = homeProvider.saleProducts;

                return Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10.0),
                    itemBuilder: (context, index) {
                      final product = data[index];
                      final hasSale = product.sale! > 0.0;

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
                                              horizontal: 10.0, vertical: 5.0),
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
                                          priceRow(product, hasSale),
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
                                            onPressed: () {},
                                            icon: Icon(CupertinoIcons.heart)),
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
                );
              }
            },
          ),
        ],
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
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 94, 93, 93),
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
