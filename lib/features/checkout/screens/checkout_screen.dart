import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoper/features/cart/controller/cart_controller.dart';

import '../../../model/order.dart';
import '../controller/checkout_controller.dart';

class CheckoutScreen extends StatefulWidget {
  static const String routeName = 'checkout-screen';
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final CartController cartController = Get.put(CartController());
  final CheckoutController checkoutController = Get.put(CheckoutController());

  final TextEditingController addressController = TextEditingController();
  String paymentMethod = 'Credit Card';

  @override
  Widget build(BuildContext context) {
    final total = cartController.cartItems.fold<double>(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Checkout', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Shipping Address'),
              _buildAddressInput(),
              const SizedBox(height: 24),
              _buildSectionTitle('Payment Method'),
              _buildPaymentMethodSelector(),
              const SizedBox(height: 24),
              _buildSectionTitle('Order Summary'),
              _buildOrderSummary(),
              const SizedBox(height: 24),
              _buildTotalAmount(),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    List<OrderItem> orderItems = cartController.cartItems
                        .map((item) => OrderItem(
                            productId: item.productId,
                            productName: item.productName,
                            quantity: item.quantity,
                            price: item.price,
                            imageUrl: item.imageUrl,
                            color: item.color!,
                            size: item.size!))
                        .toList();

                    checkoutController.placeOrder(
                        items: orderItems,
                        sellerId: cartController.cartItems.first.sellerId,
                        buyerId: cartController.cartItems.first.buyerId,
                        shippingAddress: addressController.text,
                        paymentMethod: paymentMethod,
                        totalAmount: total);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: checkoutController.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Place Order',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildAddressInput() {
    return TextFormField(
      controller: addressController,
      decoration: InputDecoration(
        hintText: 'Enter your shipping address',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
      maxLines: 3,
    );
  }

  Widget _buildPaymentMethodSelector() {
    final paymentMethods = [
      {'name': 'Credit Card', 'icon': Icons.credit_card},
      {'name': 'PayPal', 'icon': Icons.payment},
      {'name': 'Bank Transfer', 'icon': Icons.account_balance},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: paymentMethod,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
          onChanged: (String? newValue) {
            setState(() {
              paymentMethod = newValue!;
            });
          },
          items: paymentMethods
              .map<DropdownMenuItem<String>>((Map<String, dynamic> method) {
            return DropdownMenuItem<String>(
              value: method['name'],
              child: Row(
                children: [
                  Icon(method['icon'], color: Colors.blue, size: 24),
                  const SizedBox(width: 12),
                  Text(method['name'], style: const TextStyle(fontSize: 16)),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Obx(() {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cartController.cartItems.length,
        separatorBuilder: (context, index) => const Divider(height: 24),
        itemBuilder: (context, index) {
          final item = cartController.cartItems[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  item.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.productName,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(
                        '${item.quantity} x \$${item.price.toStringAsFixed(2)}'),
                  ],
                ),
              ),
              Text(
                '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          );
        },
      );
    });
  }

  Widget _buildTotalAmount() {
    return Obx(() {
      final total = cartController.cartItems.fold<double>(
        0,
        (sum, item) => sum + (item.price * item.quantity),
      );
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Total',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(
            '\$${total.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      );
    });
  }
}
