// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import 'package:shoper/constants/flutter_toast.dart';
import 'package:shoper/model/cart.dart';
import 'package:shoper/model/reviews.dart';

import '../services/product_service.dart';

class ProductDetailController extends GetxController {
  var reviews = <ReviewsModel>[].obs;
  var cartItems = <CartModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isAddingToCart = false.obs;
  RxInt cartItemsLength = 0.obs;

  final ProductSerivce _productService = ProductSerivce();

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  void getReviews(String productId) async {
    try {
      isLoading(true);

      final response = await _productService.fetchReviews(productId);
    if(response.isNotEmpty){
      reviews.assignAll(response);
    }

      isLoading(false);
    } catch (e) {
      errorsMessage(e.toString());
      print(e.toString());
    }
  }

  void getCartItems() async {
    try {
      cartItems.clear();
      isLoading(true);

      final response = await _productService.getCartItem();
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
      isLoading(false);
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
      await _productService.addToCart(
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
    await _productService.deleteFromCart(id);
    getCartItems();
    cartItems.removeWhere((item) => item.productId == id);
  
    successMessage("Removed from wishlist");
  }


}
