import 'package:hive/hive.dart';
import 'package:shoper/model/user.dart';

import 'model/product.dart';

var userBox = Hive.box<UserModel>('user');
// wishlist_box.dart
final wishlistBox = Hive.box<ProductModel>('wishlistBox');

// cart_box.dart
// final cartBox = Hive.box<ProductModel>('cartBox');