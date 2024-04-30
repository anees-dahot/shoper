import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/flutter_toast.dart';
import '../../../model/product.dart';
import '../../../provider/user_controller.dart';
import 'package:http/http.dart' as http;

class CategoryService{

final baseUrl = 'http://192.168.8.104:3000';

  Future<List<ProductModel>> getCategoryPorducts(
      String category, BuildContext context) async {
    final userToken = Provider.of<UserProvider>(context).user.token;
    List<ProductModel> products = [];
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/api/product?category=$category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userToken
        },
      );

      if (res.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(res.body)['product'];
        products = jsonData.map((json) => ProductModel.fromMap(json)).toList();
        print(products[0].category);
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
      print('cathc error $e');
    }
    return products;
  }


}