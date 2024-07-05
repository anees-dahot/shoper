import 'package:get/get.dart';
import 'package:shoper/features/orders/services/order_service.dart';

import '../../../model/order.dart';

class OrderController extends GetxController {
  RxBool isLoading = false.obs;
  var orders = <Order>[].obs;
  OrderServices orderServices = OrderServices();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getOrders();
  }

  void getOrders() async {
    try {
      isLoading(true);
      final response = await orderServices.getOrders();
      if (response.isNotEmpty) {
        orders.assignAll(response);
      }
    } finally {
      isLoading(false);
    }
  }
}
