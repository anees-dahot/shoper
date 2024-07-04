import 'package:get/get.dart';
import 'package:shoper/features/cart/services/cart_service.dart';

import '../../../constants/flutter_toast.dart';
import '../../../model/cart.dart';

class CartController extends GetxController{
 var cartItems = <CartModel>[].obs;
  RxBool isAddingToCart = false.obs;
  RxInt cartItemsLength = 0.obs;

  CartService cartService = CartService();

   @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

void getCartItems() async {
    try {
      cartItems.clear();
      isAddingToCart(true);

      final response = await cartService.getCartItem();
      if (response.isNotEmpty) {
        cartItems.assignAll(response.map((item) {
          if (item.price is int) {
            item.price = (item.price as int).toDouble();
          }
          return item;
        }));
       
      }
      cartItemsLength.value = cartItems.length;
    } catch (e) {
      errorsMessage(e.toString());
    } finally {
      isAddingToCart(false);
    }
  }

  void addToCart(
      {
        required String sellerId,
        required String productName,
      required String productId,
      required String imageUrl,
      required int quantity,
      required double price,
      required String colors,
      required int sizes,
      required int sale,
      required String description}) async {
    try {
      isAddingToCart(true);
      await cartService.addToCart(
        sellerId: sellerId,
          productName: productName,
          productId: productId,
          imageUrl: imageUrl,
          quantity: quantity,
          originalPrice: price,
          salePercentage: sale,
          description: description,
          colors: colors,
          sizes: sizes);
            getCartItems();
             cartItemsLength.value++;
       
    } catch (e) {
      print(e.toString());
    } finally {
      isAddingToCart(false);
    
    }
  }

  void deleteFromCart(String id) async {
    await cartService.deleteFromCart(id);
    getCartItems();
    cartItems.removeWhere((item) => item.productId == id);
  
    successMessage("Removed from wishlist");
  }


}