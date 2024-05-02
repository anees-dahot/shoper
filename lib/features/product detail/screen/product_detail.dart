import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoper/features/product%20detail/services/product_service.dart';
import 'package:shoper/features/product%20detail/widgets/images_carousel.dart';
import 'package:shoper/model/reviews.dart';
import '../../../model/product.dart';
import '../widgets/custom_rating_widget.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({super.key, required this.products});

  static const routeName = 'product-detail';
  ProductModel products;
    int rating = 2;
 

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  TextEditingController addReview = TextEditingController();

  ProductSerivce productSerivce = ProductSerivce();
   Future<Map<String, dynamic>>? _reviewsFuture;


  @override
  void initState() {
    super.initState();
    _reviewsFuture = productSerivce.fetchReviews(widget.products.id.toString(), context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addReview.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    ProductSerivce productService = ProductSerivce();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_ios_new_outlined)),
            const Text('Back')
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageCarousel(
                imageUrls: widget.products.images,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                widget.products.name,
                style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w700)),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                'Description',
                style:
                    GoogleFonts.lato(textStyle: const TextStyle(fontSize: 10)),
              ),
              Text(
                widget.products.description,
                style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500)),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.products.quantity == 0
                        ? Text(
                            'Out of Stock',
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red)),
                          )
                        : Text(
                            '${widget.products.quantity.toString()} in Stock ',
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green)),
                          ),
                    Text(
                      widget.products.price.toString(),
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              CustomRatingWidget(
                width: width,
                height: height,
                rating: widget.rating.toInt(),
                addReview: addReview,
                ontap: () {
                  productSerivce.postReview(
                      context: context,
                      review: addReview.text,
                      time: '23323',
                      stars: widget.rating,
                      productId: widget.products.id.toString());
                  addReview.clear();
                  setState((){});
                },
              ),
              Visibility(
                  visible: widget.products.reviews!.length != 0,
                  child: FutureBuilder<Map<String, dynamic>>(
        future: _reviewsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final reviews = snapshot.data!['reviews'] as List;

          return ListView.builder(
            shrinkWrap: true,
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return Text(review['stars'].toString());
            },
          );
        },
      ), )
            ],
          ),
        ),
      ),
    );
  }
}
