import 'package:hive/hive.dart';
import 'package:shoper/model/user.dart';

var userBox = Hive.box<UserModel>('user');