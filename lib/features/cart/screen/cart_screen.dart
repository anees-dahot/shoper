import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoper/constants/flutter_toast.dart';
import 'package:shoper/features/cart/controller/cart_controller.dart';
import '../../../model/cart.dart';
import '../../checkout/screens/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cartController =
      Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            StickyHeader(cartController: cartController),
            Expanded(
              child: Obx(() {
                if (cartController.isAddingToCart.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (cartController.cartItems.isEmpty) {
                  return const Center(
                      child: Text('Your cart is empty',
                          style: TextStyle(fontSize: 18)));
                } else {
                  return ListView.builder(
                    itemCount: cartController.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartController.cartItems[index];
                      return Dismissible(
                        key: Key(item.productId),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Remove Item"),
                                content: const Text(
                                    "Are you sure you want to remove this item?"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("CANCEL"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      cartController
                                          .deleteFromCart(item.productId);
                                      Navigator.of(context).pop(true);
                                      cartController.cartItemsLength.value--;
                                    },
                                    child: const Text("REMOVE"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        onDismissed: (direction) {
                          cartController.deleteFromCart(item.productId);
                        
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: CartItemTile(item: item),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class StickyHeader extends StatelessWidget {
  final CartController cartController;

  const StickyHeader({super.key, required this.cartController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My Cart',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Obx(() {
                final totalItems = cartController.cartItems.fold<int>(
                  0,
                  (sum, item) => sum + item.quantity,
                );
                return Text(
                  '$totalItems items',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                );
              }),
            ],
          ),
          const SizedBox(height: 16),
          Obx(() {
            final subtotal = cartController.cartItems.fold<double>(
              0,
              (sum, item) => sum + (item.price * item.quantity),
            );
            final tax = subtotal * 0.1; // Assuming 10% tax
            final total = subtotal + tax;

            return Column(
              children: [
                _buildPriceLine('Subtotal', subtotal),
                _buildPriceLine('Tax (10%)', tax),
                const Divider(height: 16),
                _buildPriceLine('Total', total, isTotal: true),
              ],
            );
          }),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
             if(cartController.cartItems.isNotEmpty){
               Navigator.of(context).pushNamed(CheckoutScreen.routeName);
             }else{
              errorsMessage('Cart is empty');
             }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Proceed to Checkout',
                style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceLine(String label, double amount, {bool isTotal = false, double? salePercent}) {
  double finalAmount = amount;
  String priceDisplay = '\$${amount.toStringAsFixed(2)}';

  if (salePercent != null && salePercent > 0) {
    finalAmount = amount * (1 - salePercent / 100);
    priceDisplay = '\$${finalAmount.toStringAsFixed(2)}';
    
    // Add strikethrough price if there's a sale
    if (!isTotal) {
      priceDisplay = '\$${amount.toStringAsFixed(2)} $priceDisplay';
    }
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        if (!isTotal && salePercent != null && salePercent > 0)
          Text(
            '${salePercent.toStringAsFixed(0)}% OFF',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        RichText(
          text: TextSpan(
            children: [
              if (!isTotal && salePercent != null && salePercent > 0)
                TextSpan(
                  text: '\$${amount.toStringAsFixed(2)} ',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              TextSpan(
                text: '\$${finalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: isTotal ? 18 : 16,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                  color: isTotal ? Colors.red : Colors.black,
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

  const CartItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: item.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
               placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    Text(
                      'Quantity: ${item.quantity}',
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
