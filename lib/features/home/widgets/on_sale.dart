import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoper/features/product%20detail/services/product_service.dart';

import '../../../model/product.dart';
import '../../product detail/screen/product_detail.dart';

class OnSale extends StatelessWidget {
  OnSale({super.key});

  final List<String> imageUrls = [
    'https://fastly.picsum.photos/id/807/2000/2000.jpg?hmac=QF7ItcVSx-ffgZAFjn_pa1Tiwn9LLi1UzMNmX8W6uaQ',
    'https://i.pcmag.com/imagery/reviews/00W0JgzHikgfvGNQaKnk3fU-1.fit_lim.size_120x68.v1701739889.jpg',
    'https://i.pcmag.com/imagery/reviews/02diPul1HrVKpsDR3DGqJUw-1.fit_lim.size_120x68.v1709770971.jpg',
    'https://i.pcmag.com/imagery/reviews/01DwPnq2ew5930qO5p4LXWH-1.fit_lim.size_120x68.v1677608790.jpg',
    'https://i.pcmag.com/imagery/reviews/00W0JgzHikgfvGNQaKnk3fU-1.fit_lim.size_120x68.v1701739889.jpg',
    'https://i.pcmag.com/imagery/reviews/02diPul1HrVKpsDR3DGqJUw-1.fit_lim.size_120x68.v1709770971.jpg',
    'https://i.pcmag.com/imagery/reviews/01DwPnq2ew5930qO5p4LXWH-1.fit_lim.size_120x68.v1677608790.jpg',
  ];

  ProductSerivce productSerivce = ProductSerivce();
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      // color: Colors.grey.shade200, // Light grey background
      child: Column(
        children: [
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'On Sale',
                   style: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800),)
                ),
                // Text(
                //   'See All',
                //   style:
                //       TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                // ),
              ],
            ),
          ),
        FutureBuilder<List<ProductModel>>(
              future: productSerivce.getSaleProducts(context),
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final data = snapshot.data!;
                  

                  return Expanded(
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: data.length,
    itemBuilder: (context, index) {
      final product = data[index];
      final hasSale = product.sale! > 0.0;

      String getSalePrice() {
        if (hasSale) {
          var salePercent = product.sale! / 100;
          var salePrice = product.price! * salePercent;
          var finalPrice = product.price! - salePrice;
          return finalPrice.toStringAsFixed(2);
        } else {
          return product.price!.toStringAsFixed(2);
        }
      }

      return GestureDetector(
        onTap: () => Navigator.pushNamed(context, ProductDetail.routeName, arguments: product),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Product image with optional sale badge
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                child: Stack(
                  children: [
                    Image.network(
                      product.images![0],
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width * 0.3,
                      fit: BoxFit.cover,
                    ),
                    if (hasSale)
                      Positioned(
                        top: 10.0,
                        left: 10.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            "Sale",
                            style: const TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
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
                    Text(
                      product.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    // Prices
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (hasSale)
                          Text(
                            "\$${product.price!.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Text(
                          "\$${getSalePrice()}",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: hasSale ? Colors.red : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    // Rating (optional)
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow[700], size: 20),
                        Icon(Icons.star, color: Colors.yellow[700], size: 20),
                        Icon(Icons.star, color: Colors.yellow[700], size: 20),
                        Icon(Icons.star, color: Colors.yellow[700], size: 20),
                        Icon(Icons.star_half, color: Colors.yellow[700], size: 20),
                        const SizedBox(width: 8.0),
                        Text(
                          "(4.5)", // Example rating
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    // Call to action button
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, ProductDetail.routeName, arguments: product),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                      ),
                      child: const Text(
                        'View Details',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
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
);


                }
              }),
        ],
      ),
    );
  }
}
