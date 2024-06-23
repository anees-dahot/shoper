import 'package:flutter/material.dart';
import 'package:shoper/model/reviews.dart';

import '../services/product_service.dart';

class ProductDetailProvider extends ChangeNotifier{

List<ReviewsModel> _reviews = [];
  bool _isLoading = false;

  List<ReviewsModel> get revoews => _reviews;
  bool get isLoading => _isLoading;

  final ProductSerivce _productService = ProductSerivce();


  Future<void> getReviews(String productId, BuildContext context) async{


_isLoading =true;
notifyListeners();

final response = await _productService.fetchReviews(productId, context);
_reviews = response;

_isLoading =false;
notifyListeners();


  }



}