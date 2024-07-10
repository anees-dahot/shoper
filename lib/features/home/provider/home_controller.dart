import 'package:get/get.dart';
import 'package:shoper/constants/flutter_toast.dart';
import 'package:shoper/features/product%20detail/services/product_service.dart';

import '../../../model/product.dart';
import '../../../utils.dart';

class HomeController extends GetxController {
  final ProductSerivce productService = ProductSerivce();
  var saleProducts = <ProductModel>[].obs;
  var trendingProducts = <ProductModel>[].obs;
  var newArrivalProducts = <ProductModel>[].obs;
  var isLoading = false.obs;
  RxBool isInWishlist = false.obs;

  

  @override
  void onInit() {
    super.onInit();
    fetchSaleProducts();
    fetchTrendingProducts();
    fetchNewArrivals();
  }

  
  void fetchSaleProducts() async {
    try {
      isLoading(true);
      var products = await productService.getSaleProducts();
      saleProducts.assignAll(products);
        } catch (e) {
      Get.snackbar('Error', e.toString());
      errorsMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void fetchTrendingProducts() async {
    try {
      isLoading(true);
      var products = await productService.getTrendingProducts();
      trendingProducts.assignAll(products);
        } catch (e) {
      Get.snackbar('Error', e.toString());
      errorsMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void fetchNewArrivals() async {
    try {
      isLoading(true);
      var products = await productService.getNewArrivalProducts();
      newArrivalProducts.assignAll(products);
        } catch (e) {
      Get.snackbar('Error', e.toString());
      errorsMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void addToWishlist(ProductModel product) async {
    try {
      
      wishlistBox.add(product);
     
      successMessage('Added to wishlist');
    } catch (e) {
      errorsMessage(e.toString());
    }
  }

 void removeFromWishlist(String productId) async {
    try {
      final productKey = wishlistBox.keys.firstWhere(
        (key) => wishlistBox.get(key)!.id == productId,
        orElse: () => null,
      );
      print(productKey.toString());
      if (productKey != null) {
        wishlistBox.delete(productKey);
        successMessage('Removed from wishlist');
      }
    } catch (e) {
      errorsMessage(e.toString());
    }
  }

  bool isProductInWishlist(ProductModel product) {
    return wishlistBox.values.any((element) => element.id == product.id);
  }

 
}
