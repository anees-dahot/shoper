import 'dart:convert';

import 'package:get/get.dart';
import 'package:shoper/constants/flutter_toast.dart';
import 'package:shoper/model/product.dart';
import 'package:shoper/utils.dart';
import 'package:http/http.dart' as http;

class WishListService {
  void addToWishlist(String userId, String productId) async {
    List<ProductModel> data = [];
final userToken = userBox.values.first.token;
    try {
      final res =await http.post(
        Uri.parse("$baseUrl/api/product/add-to-wishlist"),
        body: {
          'userId': userId,
          'productId' : productId
        },
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userToken
        },
        
      );

      if (res.statusCode == 200) {
        successMessage('Added to wishlist');
      } else if (res.statusCode == 400) {
        errorsMessage(jsonDecode(res.body)['msg']);
        print("400 ${jsonDecode(res.body)['msg']}");
      } else {
        errorsMessage(
          jsonDecode(res.body)['error'],
        );
        print("500 ${jsonDecode(res.body)['error']}");
      }
    } catch (e) {
      print(e);
    }
  }
}
