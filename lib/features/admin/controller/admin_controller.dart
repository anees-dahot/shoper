import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoper/constants/flutter_toast.dart';
import 'package:shoper/features/admin/services/admin_service.dart';
import 'package:shoper/model/order.dart';

class AdminController extends GetxController {
  RxBool isLoading = false.obs;
  var orders = <Order>[].obs;
  AdminService adminService = AdminService();

  void addProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required int quantity,
      required String category,
      required List<File> images,
      required List<String> colors,
      required List<int> sizes}) async {
    try {
      isLoading(true);
      adminService.sellProduct(
          context: context,
          name: name,
          description: description,
          price: price,
          quantity: quantity,
          category: category,
          images: images,
          colors: colors,
          sizes: sizes);
    } finally {
      isLoading(false);
    }
  }

  void getOrders() async {
    try {
      orders.clear();
      isLoading(true);
      final response = await adminService.getOrders();
      if (response.isNotEmpty) {
        orders.assignAll(response);
      }
    } finally {
      isLoading(false);
    }
  }

  void markCompleted(String orderId) async {
    try {
       adminService.markAsCompleted(orderId); // Ensure async operation completes
      final index = orders.indexWhere((item) => item.id == orderId);
      if (index != -1) {
        orders[index] = orders[index].copyWith(status: 'completed');
        orders.refresh(); // Notify listeners about the change
      }
    } catch (e) {
      errorsMessage(e.toString());
    }
  }
}