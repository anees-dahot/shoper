import 'package:get/get.dart';
import 'package:shoper/features/admin/services/admin_service.dart';
import 'package:shoper/features/orders/services/order_service.dart';

import '../../../model/order.dart';
import '../../admin/controller/admin_controller.dart';

class OrderController extends GetxController {
  RxBool isLoading = false.obs;
  var orders = <Order>[].obs;
  OrderServices orderServices = OrderServices();
  AdminService adminService = AdminService();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getOrders();
  }

  void getOrders() async {
    try {
      isLoading(true);
      orders.clear();
      final response = await orderServices.getOrders();
      if (response.isNotEmpty) {
        orders.assignAll(response);
      }
    } finally {
      isLoading(false);
    }
  }

  void deleteOrder(String orderId) async {
    try {
      adminService.deleteOrder(orderId);
      orders.removeWhere((element) => element.id == orderId);
    } catch (e) {
      print(e.toString());
    }
  }

  void markOrderAsCompleted(String orderId)  {
    final adminController = Get.find<AdminController>();
     adminController.markCompleted(orderId);
    getOrders(); // Refresh orders after marking as completed
  }
}
