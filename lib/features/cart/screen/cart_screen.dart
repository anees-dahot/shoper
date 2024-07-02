import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoper/features/product%20detail/provider/product_detail_controller.dart';
import '../../../model/cart.dart';

class CartScreen extends StatelessWidget {
  final ProductDetailController cartController = Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (cartController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (cartController.cartItems.isEmpty) {
                return const Center(child:  Text('Your cart is empty'));
              } else {
                return ListView.builder(
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartController.cartItems[index];
                    return CartItemTile(
                      item: item,
                      onRemove: () => cartController.deleteFromCart(item.productId),
                    );
                  },
                );
              }
            }),
          ),
          Container(
            height: Get.height * 0.25,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  final totalPrice = cartController.cartItems.fold<double>(
                    0,
                    (sum, item) => sum + item.price,
                  );
                  final totalQuantity = cartController.cartItems.fold<int>(
                    0,
                    (sum, item) => sum + item.quantity,
                  );
               

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Price of Items:', style: TextStyle(fontSize: 16)),
                          Text('\$${totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Quantity:', style: TextStyle(fontSize: 16)),
                          Text('$totalQuantity', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      
                      
                    ],
                  );
                }),
                const Divider(thickness: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Obx(() {
                      final totalPrice = cartController.cartItems.fold<double>(
                    0,
                    (sum, item) => sum + item.price,
                  );
                  final totalQuantity = cartController.cartItems.fold<int>(
                    0,
                    (sum, item) => sum + item.quantity,
                  );
                         final subtotal = totalPrice * totalQuantity;
                      return Text(
                        '\$${subtotal.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Implement checkout functionality
                  },
                  child: const Text('Proceed to Checkout', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartItemTile extends StatelessWidget {
  final CartModel item;
  final VoidCallback onRemove;

  const CartItemTile({Key? key, required this.item, required this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(item.imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Quantity: ${item.quantity}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}