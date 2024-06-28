import 'package:hive/hive.dart';
import 'package:shoper/model/user.dart';

import 'model/product.dart';

var userBox = Hive.box<UserModel>('user');
// wishlist_box.dart
final wishlistBox = Hive.box<ProductModel>('wishlistBox');

 const baseUrl = 'http://192.168.43.101:3000';

// cart_box.dart
// final cartBox = Hive.box<ProductModel>('cartBox');