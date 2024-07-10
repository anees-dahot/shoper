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
      reviews.clear();
      isLoading(true);

      final response = await _productService.fetchReviews(productId);
    if(response.isNotEmpty){
      reviews.assignAll(response);
    }

      isLoading(false);
    } catch (e) {
      errorsMessage(e.toString());
      print(e.toString());
    }
  }

  


}
