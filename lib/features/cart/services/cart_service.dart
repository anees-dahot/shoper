import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../constants/flutter_toast.dart';
import '../../../model/cart.dart';
import '../../../utils.dart';

class CartService {

Future<void> addToCart({
    required String sellerId,
    required String productName,
    required String productId,
    required String imageUrl,
    required int quantity,
    required double originalPrice,
    required String description,
   required String colors,
   required int sizes,
    int? salePercentage, // New parameter for sale percentage
  }) async {
    final user = userBox.values.first;

    try {
      // Calculate the final price based on sale percentage
      double finalPrice = calculateFinalPrice(originalPrice, salePercentage);

      CartModel cartModel = CartModel(
        buyerId: user.id,
        sellerId: sellerId,
        productName: productName,
        imageUrl: imageUrl,
        quantity: quantity,
        price: finalPrice, // Use the calculated final price
        description: description,
        productId: productId,
        color: colors,
        size: sizes
      );

      final res = await http.post(
        Uri.parse('$baseUrl/api/product/add-to-cart'),
        body: cartModel.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token
        },
      );

      if (res.statusCode == 200) {
        successMessage(jsonDecode(res.body)['msg']);
      } else if (res.statusCode == 400) {
        errorsMessage(jsonDecode(res.body)['msg']);
        print("400 ${jsonDecode(res.body)['msg']}");
      } else {
        errorsMessage(jsonDecode(res.body)['error']);
        print("500 ${jsonDecode(res.body)['error']}");
      }
    } catch (e) {
      errorsMessage(e.toString());
      print(e.toString());
    }
  }

// Helper function to calculate the final price
  double calculateFinalPrice(double originalPrice, int? salePercentage) {
    if (salePercentage == null || salePercentage <= 0) {
      return originalPrice;
    }
    double discountAmount = originalPrice * (salePercentage / 100);
    return originalPrice - discountAmount;
  }

  Future<void> deleteFromCart(String id) async {
    final user = userBox.values.first;

    try {
      final res = await http.post(
        Uri.parse('$baseUrl/api/product/delete-cart-item/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token
        },
      );

      if (res.statusCode == 200) {
        successMessage(jsonDecode(res.body)['msg']);
      } else if (res.statusCode == 400) {
        errorsMessage(jsonDecode(res.body)['msg']);
        print("400 ${jsonDecode(res.body)['msg']}");
      } else {
        errorsMessage(jsonDecode(res.body)['error']);
        print("500 ${jsonDecode(res.body)['error']}");
      }
    } catch (e) {
      errorsMessage(e.toString());
      print(e.toString());
    }
  }

  Future<List<CartModel>> getCartItem() async {
    List<CartModel> cartItems = [];
    try {
      final user = userBox.values.first;
      final url =
          Uri.parse('$baseUrl/api/product/get-addtocart-products/${user.id}');
      final res = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token
        },
      );

      if (res.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(res.body)['cartItem'];
        cartItems = jsonData.map((json) => CartModel.fromMap(json)).toList();
      } else if (res.statusCode == 400) {
        print("400 ${jsonDecode(res.body)['msg']}");
      } else {
        print("500 ${jsonDecode(res.body)['error']}");
      }
    } catch (e) {
      errorsMessage(e.toString());
      print(e.toString());
    }
    return cartItems;
  }

}