import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoper/features/orders/controller/order_controller.dart';
import '../../../model/order.dart';

class OrdersPage extends StatefulWidget {
  static const String routeName = 'buyer-order-screen';

  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final OrderController orderController = Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    orderController.getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Orders'),
        ),
        body: GetBuilder<OrderController>(
          builder: (controller) {
            return Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.orders.isEmpty) {
                return const Center(child:  Text('No orders'));
              } else {
                return ListView.builder(
                  itemCount: controller.orders.length,
                  itemBuilder: (context, index) {
                    final order = controller.orders[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ExpansionTile(
                        title: const Text('Order'),
                        subtitle: Text(
                            'Total: \$${order.totalAmount.toStringAsFixed(2)}'),
                        children: [
                          _buildOrderDetails(order),
                        ],
                      ),
                    );
                  },
                );
              }
            });
          },
        ));
  }

  Widget _buildOrderDetails(Order order) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Shipping Address: ${order.shippingAddress}'),
          Text('Payment Method: ${order.paymentMethod}'),
          const SizedBox(height: 8),
          const Text('Items:', style: TextStyle(fontWeight: FontWeight.bold)),
          ...order.items.map((item) => _buildOrderItem(item)),
        ],
      ),
    );
  }

  Widget _buildOrderItem(OrderItem item) {
    return ListTile(
      leading: Image.network(item.imageUrl,
          width: 50, height: 50, fit: BoxFit.cover),
      title: Text(item.productName),
      subtitle: Text('Size: ${item.size}, Color: ${item.color}'),
      trailing: Text('${item.quantity} x \$${item.price.toStringAsFixed(2)}'),
    );
  }
}
