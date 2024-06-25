import 'package:flutter/material.dart';
import 'package:shoper/model/reviews.dart';
import 'package:get/get.dart';
import '../services/product_service.dart';

class ProductDetailProvider extends GetxController {
  List<ReviewsModel> _reviews = [];
  RxBool _isLoading = false.obs;

  final ProductSerivce _productService = ProductSerivce();

  Future<void> getReviews(String productId, BuildContext context) async {
    _isLoading.value = true;

    final response = await _productService.fetchReviews(productId, context);
    _reviews = response;

    _isLoading.value = false;
  }
}
