import 'dart:convert';

import 'package:shoper/constants/flutter_toast.dart';
import 'package:shoper/utils.dart';
import 'package:http/http.dart' as http;

import '../../../model/product.dart';

class WishListService {
  void addToWishlist(String userId, String productId) async {
    final userToken = userBox.values.first.token;
    print('userId: ${userId}, productId: ${productId}');
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/api/product/add-to-wishlist"),
        body: jsonEncode({'userId': userId, 'productId': productId}),  
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
  
  
  void removeFromWishlist(String userId, String productId) async {
    final userToken = userBox.values.first.token;

    print(userToken);
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/api/product/remove-from-wishlist"),
        body: jsonEncode({'userId': userId, 'productId': productId}),  
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userToken
        },
      );

      if (res.statusCode == 200) {
        successMessage('Removed from wishlist');
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


  Future<List<ProductModel>> getWIshListProducts(String userId) async {
    final userToken = userBox.values.first.token;
     List<ProductModel> products = [];
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/api/product/get-wishlist-products/$userId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userToken
        },
      );

      if (res.statusCode == 200) {
         final List<dynamic> jsonData = jsonDecode(res.body)['wishlistProducts'];
        products = jsonData.map((json) => ProductModel.fromMap(json)).toList();
        print(jsonDecode(res.body));
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
    return products;
  }


  Future<bool> isProductIsInWishlist(String userId, String productId) async {
    final userToken = userBox.values.first.token;

    try {
      final res = await http.get(
        Uri.parse("$baseUrl/api/product/is-in-wishlist?userId=$userId&productId=$productId"),
       
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userToken
        },
         
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        return data['isInWishlist'];
       
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
    return false;
  }
}
