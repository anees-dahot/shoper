import 'package:get/get.dart';
import 'package:shoper/constants/flutter_toast.dart';
import 'package:shoper/features/wishlist/services/wishlist_service.dart';
import 'package:shoper/model/product.dart';
import 'package:shoper/utils.dart';

class WishListController extends GetxController {
  WishListService wishListService = WishListService();
  var wishListItems = <ProductModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isInWishlist = false.obs;


  


  void addToWishList(String productId, String userId) {
    wishListService.addToWishlist(userId, productId);
    isProductIsInWishlist(productId, userId);
    update();
  }

  void removedFromWishlist(String productId, String userId) {
    wishListService.removeFromWishlist(userId, productId);
    isProductIsInWishlist(productId, userId);

    update();
  }

  void isProductIsInWishlist(String productId, String userId) async {
    final isIn = await wishListService.isProductIsInWishlist(userId, productId);
    if (isIn) {
      isInWishlist(true);
    } else {
      isInWishlist(false);
    }
  }

  void getWIshListProduct(String userId) async {
    try{
      isLoading(true);
      var items = await wishListService.getWIshListProducts(userId);
    if(items.isNotEmpty){
      wishListItems.assignAll(items);
    }
    }catch(e){
      errorsMessage(e.toString());
    }finally{
      isLoading(false);
    }
    update();
  }
}
