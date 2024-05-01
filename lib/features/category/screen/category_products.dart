import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoper/features/category/services/category_service.dart';
import 'package:shoper/features/home/services/home_services.dart';
import 'package:shoper/features/product%20detail/screen/product_detail.dart';

class CategoryProducts extends StatelessWidget {
  CategoryProducts({super.key, required this.category});

  static const routeName = '/category-products';
  CategoryService categoryService = CategoryService();
  String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back_ios_new_outlined)),
            Text(category)
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: categoryService.getCategoryPorducts(category, context),
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
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, ProductDetail.routeName,
                            arguments: products[index]),
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
                                  products[index].images.isEmpty
                                      ? 'https://fastly.picsum.photos/id/807/2000/2000.jpg?hmac=QF7ItcVSx-ffgZAFjn_pa1Tiwn9LLi1UzMNmX8W6uaQ'
                                      : products[index].images[0],
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: MediaQuery.of(context).size.height *
                                      0.2, // Maintain image size
                                  fit: BoxFit.cover, // Fill the container
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      products[index].name,
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
                                        products[index].description,
                                        style: GoogleFonts.lato(
                                          textStyle: const TextStyle(
                                            fontSize: 14.0,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        maxLines: 2,
                                      ),
                                    ),
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
          ))
        ],
      ),
    );
  }
}
