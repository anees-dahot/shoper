import 'package:get/get.dart';
import 'package:shoper/model/product.dart';
import 'package:shoper/utils.dart';

class WishListService {



Future<List<ProductModel>> getWishlistItem() async{
List<ProductModel> data = [];
try{
  final wishListBoxItems = wishlistBox.values.toList();
data.assignAll(wishListBoxItems);
}catch(e){
  print(e);
}
return data;

}



}