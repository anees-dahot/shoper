import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shoper/model/order.dart';

import '../../../constants/flutter_toast.dart';
import '../../../utils.dart';

class CheckoutService {
  void placeOrder({
    required String sellerId,
    required String buyerId,
    required List<OrderItem> items,
    required String shippingAddress,
    required String paymentMethod,
    required double totalAmount,
  }) async {
    try {
      final user = userBox.values.first;
      Order order  = Order(sellerId: sellerId, buyerId: buyerId, items: items, shippingAddress: shippingAddress, paymentMethod: paymentMethod, totalAmount: totalAmount);
     
          final jsonBody = jsonEncode(order);
      final res = await http.post(
        Uri.parse('$baseUrl/api/orders'),
        body: jsonBody,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token
        },
      );

      if (res.statusCode == 200) {
        print(res.body);
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
      errorsMessage(e.toString());
      print(e.toString());
    }
  }
}
