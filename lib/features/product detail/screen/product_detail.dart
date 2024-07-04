// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoper/features/product%20detail/provider/product_detail_controller.dart';
import 'package:shoper/features/product%20detail/services/product_service.dart';
import 'package:shoper/features/product%20detail/widgets/images_carousel.dart';
import 'package:shoper/features/product%20detail/widgets/review_card.dart';
import '../../../model/product.dart';
import '../../cart/controller/cart_controller.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({super.key, required this.products});

  static const routeName = 'product-detail';
  ProductModel products;
  int rating = 0;
  int quantity = 1;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  TextEditingController addReview = TextEditingController();
  ProductSerivce productSerivce = ProductSerivce();
  ProductDetailController productDetailController =
      Get.put(ProductDetailController());
  CartController cartController = Get.put(CartController());

  String? selectedColor;
  String? selectedSize;

  @override
  void dispose() {
    super.dispose();
    addReview.dispose();
  }

  @override
  void initState() {
    super.initState();
    productDetailController.getReviews(widget.products.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.products.name!,
            style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageCarousel(imageUrls: widget.products.images!),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.products.name!,
                        style: GoogleFonts.lato(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: [
                          Text(
                            '\$${widget.products.price!.toStringAsFixed(2)}',
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${widget.products.quantity!} In Stock',
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: widget.products.quantity! == 0
                                    ? Colors.red
                                    : Colors.green),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Description',
                    style: GoogleFonts.lato(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.products.description!,
                    style: GoogleFonts.lato(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Colors',
                    style: GoogleFonts.lato(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.products.colors?.length ?? 0,
                      itemBuilder: (context, index) {
                        final color = widget.products.colors![index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColor = color;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(int.parse('0xff$color')),
                              shape: BoxShape.circle,
                              border: selectedColor == color
                                  ? Border.all(color: Colors.black, width: 2)
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Sizes',
                    style: GoogleFonts.lato(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Wrap(
                    spacing: 10,
                    children: widget.products.sizes!.map((size) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = size.toString();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: selectedSize == size.toString()
                                ? Colors.black
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Text(
                            size.toString(),
                            style: GoogleFonts.lato(
                              color: selectedSize == size.toString()
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Reviews',
                    style: GoogleFonts.raleway(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  _buildReviewInput(),
                  const SizedBox(height: 16),
                  _buildReviewList(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildReviewInput() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Your Review',
              style:
                  GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            RatingBar.builder(
              initialRating: widget.rating.toDouble(),
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 24,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (newRating) {
                setState(() {
                  widget.rating = newRating.toInt();
                });
              },
            ),
            const SizedBox(height: 8),
            TextField(
              controller: addReview,
              decoration: InputDecoration(
                hintText: 'Write your review...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _submitReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Submit Review',
                  style: GoogleFonts.lato(
                      textStyle: const TextStyle(color: Colors.white))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewList() {
    return Obx(
      () => productDetailController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : productDetailController.reviews.isEmpty
              ? Container()
              : Column(
                  children: productDetailController.reviews
                      .map((review) => ReviewCard(
                            user: review.user,
                            content: review.review,
                            stars: review.stars,
                          ))
                      .toList(),
                ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (widget.quantity > 1) {
                      setState(() {
                        widget.quantity--;
                      });
                    }
                  },
                ),
                Text(
                  widget.quantity.toString(),
                  style: GoogleFonts.lato(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      widget.quantity++;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Obx(
              () => ElevatedButton(
                onPressed:
                    cartController.isAddingToCart.value ? null : _addToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: cartController.isAddingToCart.value
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Add to Cart',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _submitReview() {
    if (addReview.text.isNotEmpty) {
      productSerivce
          .postReview(
        context: context,
        review: addReview.text,
        time: DateTime.now().toString(),
        stars: widget.rating,
        productId: widget.products.id.toString(),
      )
          .then((_) {
        addReview.clear();
        setState(() {
          productDetailController.getReviews(widget.products.id!);
          widget.rating = 0;
        });
      });
    }
  }

  void _addToCart() {
    if (selectedColor == null || selectedSize == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select color and size')),
      );
      return;
    }

    cartController.addToCart(
      sellerId: widget.products.seller!,
      productName: widget.products.name!,
      productId: widget.products.id!,
      imageUrl: widget.products.images!.first,
      quantity: widget.quantity,
      price: widget.products.price!,
      description: widget.products.description!,
      colors: selectedColor!,
      sizes: int.parse(selectedSize!),
      sale: widget.products.sale!,
    );
  }
}
