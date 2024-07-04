import 'package:get/get.dart';
import 'package:shoper/constants/flutter_toast.dart';
import 'package:shoper/features/cart/controller/cart_controller.dart';
import 'package:shoper/features/checkout/services/checkout_service.dart';

import '../../../model/order.dart';

class CheckoutController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool orderPlaced = false.obs;
  CheckoutService checkoutService = CheckoutService();
  CartController cartController = Get.put(CartController());

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

    } finally {
      isLoading(false);
successMessage('Order placed successfully');
    }
  }
}
