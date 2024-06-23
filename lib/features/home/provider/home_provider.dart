import 'package:flutter/material.dart';
import 'package:shoper/features/product%20detail/services/product_service.dart';
import 'package:shoper/model/product.dart';

class HomeProvider extends ChangeNotifier{

 List<ProductModel> _saleProducts = [];
 List<ProductModel> _trendingroducts = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<ProductModel> get saleProducts => _saleProducts;
  List<ProductModel> get trendingProducts => _trendingroducts;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  final ProductSerivce _productService = ProductSerivce();



  Future<void> fetchSaleProducts(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
     List<ProductModel> products = [];

    try {
       print('data fecthed');
      await _productService.getSaleProducts(context).then((value) {
         _saleProducts = value;
         print('data fecthed');
      });
      _errorMessage = '';
      
    } catch (e) {
      _errorMessage = e.toString();
      print(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<void> fetchDealOfDayProducts(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
     List<ProductModel> products = [];

    try {
       print('data fecthed');
      await _productService.getTrendingProducts(context).then((value) {
         _trendingroducts = value;
         print('data fecthed');
      });
      _errorMessage = '';
      
    } catch (e) {
      _errorMessage = e.toString();
      print(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }



}