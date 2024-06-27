import 'package:get/get.dart';
import 'package:shoper/constants/flutter_toast.dart';
import 'package:shoper/features/wishlist/services/wishlist_service.dart';
import 'package:shoper/model/product.dart';

class WishListController extends GetxController {
  WishListService wishListService = WishListService();
  var wishListItems = <ProductModel>[].obs;
  RxBool isLoading = false.obs;

  
 

  void getWishListItems() async {
    wishListItems.clear();
  
    try {
        isLoading(true);
      var items = await wishListService.getWishlistItem();
      if (items != null) {
        wishListItems.assignAll(items);
      }
       update();
       print('added');
    
    } catch (e) {
      errorsMessage(e.toString());
     
    }finally{
        isLoading(false);
       update();
    }
  }
}
