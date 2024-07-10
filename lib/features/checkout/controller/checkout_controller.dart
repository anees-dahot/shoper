import 'package:get/get.dart';
import 'package:shoper/features/cart/controller/cart_controller.dart';
import 'package:shoper/features/checkout/services/checkout_service.dart';

import '../../../model/order.dart';
import '../../orders/controller/order_controller.dart';

class CheckoutController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool orderPlaced = false.obs;
  CheckoutService checkoutService = CheckoutService();
  CartController cartController = Get.put(CartController());
  OrderController orderController = Get.put(OrderController());
  


 
  void placeOrder({
    required List<OrderItem> items,
    required String sellerId,
    required String buyerId,
    required String shippingAddress,
    required String paymentMethod,
    required double totalAmount,
  }) async {
    try {
      isLoading(true);
      checkoutService.placeOrder(
          items: items,
          sellerId: sellerId,
          buyerId: buyerId,
          shippingAddress: shippingAddress,
          paymentMethod: paymentMethod,
          totalAmount: totalAmount);
      cartController.cartItems.clear();
      cartController.cartItemsLength.value = 0;
      orderPlaced(true);
      orderController.getOrders();

    } finally {
      isLoading(false);
     
    }
  }

  
}
