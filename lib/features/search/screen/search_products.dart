import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoper/features/search/services/search_service.dart';

import '../../product detail/screen/product_detail.dart';

class SearchProducts extends StatelessWidget {
  static const routeName = '/search-products';
  final String query;

  SearchProducts({super.key, required this.query});

  SearchService searchService = SearchService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_ios_new_outlined)),
              const Text('Search')
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder(
          future: searchService.getSearchProducts(query, context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products available'));
            } else {
              final products = snapshot.data!;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final colors = products[index].colors;
                    final sizes = products[index].sizes;
                    return GestureDetector(
                      // onTap: () => Navigator.pushNamed(
                      //     context, ProductDetail.routeName,
                      //     arguments: products[index]),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                products[index].images!.isEmpty
                                    ? 'https://fastly.picsum.photos/id/807/2000/2000.jpg?hmac=QF7ItcVSx-ffgZAFjn_pa1Tiwn9LLi1UzMNmX8W6uaQ'
                                    : products[index].images![0],
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: MediaQuery.of(context).size.height *
                                    0.2, // Maintain image size
                                fit: BoxFit.cover, // Fill the container
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    products[index].name!,
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    maxLines: 2,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: Text(
                                      products[index].description!,
                                      style: GoogleFonts.lato(
                                        textStyle: const TextStyle(
                                          fontSize: 14.0,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 200,
                                    child: Expanded(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: colors!.length,
                                        itemBuilder: (context, index) {
                                          // Check if colors list is empty before accessing elements

                                          return Container(
                                            margin: const EdgeInsets.only(
                                                right: 10, top: 10),
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: Color(int.parse(
                                                  '0xff${colors[index]}')),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            // ...
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: 40,
                                      width: 200,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: sizes!.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                             margin: const EdgeInsets.only(
                                                right: 10, top: 10),
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child:
                                                Text(sizes[index].toString()),
                                          );
                                        },
                                      )),
                                  products[index].quantity == 0
                                      ? const Text(
                                          'Out of Stock',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.green),
                                        )
                                      : const Text(
                                          'In Stock',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green),
                                        ),
                                  Text(
                                    '\$${products[index].price.toString()}',
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
              );
            }
          },
        ));
  }
}
