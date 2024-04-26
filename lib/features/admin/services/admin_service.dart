import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoper/constants/flutter_toast.dart';
import 'package:shoper/model/product.dart';
import 'package:http/http.dart' as http;
import 'package:shoper/provider/user_controller.dart';

class AdminService {
  final baseUrl = 'http://192.168.8.104:3000';

  void sellProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required int quantity,
      required String category,
      required List<File> images}) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      final cloudinary = CloudinaryPublic('doaewaso1', 'one9vigp');
      List<String> imageUrl = [];
      for (int i = 0; i < images.length; i++) {
        final CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrl.add(res.secureUrl);
      }
      ProductModel productModel = ProductModel(
          name: name,
          price: price,
          description: description,
          quantity: quantity,
          category: category,
          images: imageUrl);

      http.Response res = await http.post(
        Uri.parse('$baseUrl/admin/sell-product'),
        body: productModel.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token
        },
      );
      if (res.statusCode == 200) {
        successMessage('Logged in successfully');
      } else if (res.statusCode == 400) {
        errorsMessage(jsonDecode(res.body)['msg']);
        print(jsonDecode(res.body)['msg']);
      } else {
        errorsMessage(
          jsonDecode(res.body)['error'],
        );
        print(jsonDecode(res.body)['error']);
      }
    } catch (e) {
      errorsMessage(e.toString());
    }
  }
}
