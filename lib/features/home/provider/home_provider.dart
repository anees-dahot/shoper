
import 'package:get/get.dart';
import 'package:shoper/constants/flutter_toast.dart';
import 'package:shoper/features/product%20detail/services/product_service.dart';
import '../../../model/product.dart';

class HomeController extends GetxController {
  final ProductSerivce productService = ProductSerivce();
  var saleProducts = <ProductModel>[].obs;
  var trendingProducts = <ProductModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSaleProducts();
    fetchTrendingProducts();
  }

  void fetchSaleProducts() async {
    try {
      isLoading(true);
      var products = await productService.getSaleProducts();
      if (products != null) {
        saleProducts.assignAll(products);
      }
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
      if (products != null) {
        trendingProducts.assignAll(products);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      errorsMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
