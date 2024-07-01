import 'package:get/get.dart';
import 'package:shoper/constants/flutter_toast.dart';
import 'package:shoper/features/wishlist/services/wishlist_service.dart';
import 'package:shoper/model/product.dart';

class WishListController extends GetxController {
  WishListService wishListService = WishListService();
  var wishListItems = <ProductModel>[].obs;
  var wishlistStatus = <String, bool>{}.obs;
  RxBool isLoading = false.obs;

  void addToWishList(String productId, String userId)  {
    try {
       wishListService.addToWishlist(userId, productId);
      wishlistStatus[productId] = true;
      wishListItems.refresh();
      successMessage("Added to wishlist");
    } catch (e) {
      errorsMessage("Failed to add to wishlist: ${e.toString()}");
    }
  }

  void removedFromWishlist(String productId, String userId)  {
    try {
       wishListService.removeFromWishlist(userId, productId);
      wishlistStatus[productId] = false;
      wishListItems.removeWhere((product) => product.id == productId);
      successMessage("Removed from wishlist");
    } catch (e) {
      errorsMessage("Failed to remove from wishlist: ${e.toString()}");
    }
  }

  Future<void> fetchWishlistStatus(List<ProductModel> products, String userId) async {
    for (var product in products) {
      final isInWishlist = await isProductIsInWishlist(product.id!, userId);
      wishlistStatus[product.id!] = isInWishlist;
    }
  }

  Future<bool> isProductIsInWishlist(String productId, String userId) async {
    try {
      final isIn = await wishListService.isProductIsInWishlist(userId, productId);
      return isIn;
    } catch (e) {
      errorsMessage("Failed to check wishlist status: ${e.toString()}");
      return false;
    }
  }

  void getWishListProducts(String userId) async {
    try {
      wishListItems.clear();
      isLoading(true);
      var newItems = await wishListService.getWIshListProducts(userId);
      wishListItems.assignAll(newItems);
    } catch (e) {
      errorsMessage("Failed to fetch wishlist products: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }
}
