import 'package:get/get.dart';
import 'package:shoper/constants/flutter_toast.dart';
import 'package:shoper/features/admin/services/admin_service.dart';
import 'package:shoper/model/order.dart';

class AdminController extends GetxController {
  RxBool isLoading = false.obs;
  var orders = <Order>[].obs;
  AdminService adminService = AdminService();

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
      adminService.markAsCompleted(orderId);
    int index = orders.indexWhere((order) => order.id == orderId);
      if (index != -1) {
        orders[index].status = 'completed';
        orders.refresh(); // This will notify listeners that the list has changed
      }

    } catch (e) {
      errorsMessage(e.toString());
    }
  }
}
