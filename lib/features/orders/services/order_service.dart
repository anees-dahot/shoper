import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../constants/flutter_toast.dart';
import '../../../model/order.dart';
import '../../../utils.dart';

class OrderServices {
  Future<List<Order>> getOrders() async {
    List<Order> orders = [];
    try {
      final user = userBox.values.first;

      final res = await http.get(
        Uri.parse('$baseUrl/api/orders/buyer/${user.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token
        },
      );

      if (res.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(res.body)['orders'];
        orders = jsonData.map((json) => Order.fromJson(json)).toList();
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
    return orders;
  }
}
