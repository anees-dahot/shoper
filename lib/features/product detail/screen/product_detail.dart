import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoper/features/product%20detail/services/product_service.dart';
import 'package:shoper/features/product%20detail/widgets/images_carousel.dart';
import 'package:shoper/features/product%20detail/widgets/review_card.dart';
import '../../../model/product.dart';
import '../widgets/add_review_textfield.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({super.key, required this.products});

  static const routeName = 'product-detail';
  ProductModel products;
  int rating = 0;
  int quantity = 0;

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
    _reviewsFuture =
        productSerivce.fetchReviews(widget.products.id.toString(), context);
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
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: width * 0.95,
          height: height * 0.1,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(20)),
          child: Row(
            
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.058,
                width: MediaQuery.of(context).size.width * 0.32,
                child: Row(
                  children: [

                    IconButton(
                        onPressed: () {
                          widget.quantity++;
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        )),
                    Text(widget.quantity.toString(), style: const TextStyle(color: Colors.white, fontSize: 20),),
                    IconButton(
                        onPressed: () {
                          if (widget.quantity > 0) {
                            widget.quantity--;
                            setState(() {});
                          }
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.058,
                  width: MediaQuery.of(context).size.width * 0.32,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text('Add To Cart',
                      style: GoogleFonts.lato(
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageCarousel(
                imageUrls: widget.products.images!,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                widget.products.name!,
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
                widget.products.description!,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10.0,
                        spreadRadius: 5.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add Review:',
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )),
                          ),
                          Text(
                            widget.rating
                                .toString(), // Display rating with one decimal
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      RatingBar.builder(
                        initialRating: widget.rating.toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(
                            horizontal: width *
                                0.05), // Adjust padding based on screen size
                        itemSize: width *
                            0.07, // Adjust star size based on screen size
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (newRating) {
                          setState(() {
                            widget.rating = newRating.toInt();
                          });
                          print(widget.rating);
                        },
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          AddReviewTextField(
                              hintText: 'Write Review', controller: addReview),
                          IconButton(
                              onPressed: () {
                                productSerivce
                                    .postReview(
                                        context: context,
                                        review: addReview.text,
                                        time: '23323',
                                        stars: widget.rating,
                                        productId:
                                            widget.products.id.toString())
                                    .then((val) {
                                  addReview.clear();
                                  setState(() {
                                    _reviewsFuture =
                                        productSerivce.fetchReviews(
                                            widget.products.id.toString(),
                                            context);
                                    widget.rating = 0;
                                  });
                                });
                              },
                              icon: const Icon(Icons.send))
                        ],
                      ) // Assuming you have an AddReviewTextField widget
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: widget.products.reviews!.isNotEmpty,
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

                    return Column(
                      children: [
                        for (final review in reviews)
                          ReviewCard(
                              user: review['user'],
                              content: review['review'],
                              stars: review['stars']),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 180,
              )
            ],
          ),
        ),
      ),
    );
  }
}
