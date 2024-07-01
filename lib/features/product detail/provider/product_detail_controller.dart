// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import 'package:shoper/constants/flutter_toast.dart';
import 'package:shoper/model/reviews.dart';

import '../services/product_service.dart';

class ProductDetailController extends GetxController {
  var reviews = <ReviewsModel>[].obs;
  RxBool isLoading = false.obs;

  final ProductSerivce _productService = ProductSerivce();

  void getReviews(String productId) async {
    try {
      isLoading(true);

      final response = await _productService.fetchReviews(productId);
      reviews.assignAll(response);

      isLoading(false);
    } catch (e) {
      errorsMessage(e.toString());
    }
  }

  void addToCart(
      {required String productName,
      required String imageUrl,
      required int quantity,
      required double price,
      required String description}) async {
    try {
      isLoading(true);
      await _productService.addToCart(
          productName: productName,
          imageUrl: imageUrl,
          quantity: quantity,
          price: price,
          description: description);
    } catch (e) {
      errorsMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
