import 'package:get/get.dart';
import 'package:shoper/features/admin/services/admin_service.dart';
import 'package:shoper/model/order.dart';

class AdminController extends GetxController{

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


}