import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoper/features/product%20detail/screen/product_detail.dart';
import 'package:shoper/model/product.dart';

import '../../product detail/services/product_service.dart';

class DealOfTheDay extends StatelessWidget {
  DealOfTheDay({super.key});

  final List<String> imageUrls = [
    'https://fastly.picsum.photos/id/807/2000/2000.jpg?hmac=QF7ItcVSx-ffgZAFjn_pa1Tiwn9LLi1UzMNmX8W6uaQ',
    'https://i.pcmag.com/imagery/reviews/00W0JgzHikgfvGNQaKnk3fU-1.fit_lim.size_120x68.v1701739889.jpg',
    'https://i.pcmag.com/imagery/reviews/02diPul1HrVKpsDR3DGqJUw-1.fit_lim.size_120x68.v1709770971.jpg',
    'https://i.pcmag.com/imagery/reviews/01DwPnq2ew5930qO5p4LXWH-1.fit_lim.size_120x68.v1677608790.jpg',
    'https://i.pcmag.com/imagery/reviews/00W0JgzHikgfvGNQaKnk3fU-1.fit_lim.size_120x68.v1701739889.jpg',
    'https://i.pcmag.com/imagery/reviews/02diPul1HrVKpsDR3DGqJUw-1.fit_lim.size_120x68.v1709770971.jpg',
    'https://i.pcmag.com/imagery/reviews/01DwPnq2ew5930qO5p4LXWH-1.fit_lim.size_120x68.v1677608790.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    ProductSerivce productSerivce = ProductSerivce();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.43,
      // color: Colors.grey.shade200, // Light grey background
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Made just for you',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w800),
                    )),
                // Text(
                //   'See All',
                //   style:
                //       TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                // ),
              ],
            ),
          ),
          FutureBuilder<List<ProductModel>>(
              future: productSerivce.getTrendingProducts(context),
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
                        final products = data[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, ProductDetail.routeName, arguments: products);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10.0),
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    products.images![0],
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.width *
                                        0.4, // Maintain image size
                                    fit: BoxFit.cover, // Fill the container
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              products.name!,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              products.price.toString(),
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
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
