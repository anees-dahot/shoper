import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoper/features/admin/controller/admin_controller.dart';
import 'package:shoper/features/orders/controller/order_controller.dart';
import '../../../model/order.dart';

class AdminOrderScreen extends StatefulWidget {
  static const String routeName = 'admin-order-screen';

  const AdminOrderScreen({super.key});

  @override
  State<AdminOrderScreen> createState() => _AdminOrderScreenState();
}

class _AdminOrderScreenState extends State<AdminOrderScreen> {
  final OrderController orderController = Get.put(OrderController());
  final AdminController adminController = Get.put(AdminController());

  @override
  void initState() {
    super.initState();
    orderController.getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Orders'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrderList('pending'),
            _buildOrderList('completed'),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(String status) {
    return GetBuilder<OrderController>(
      builder: (controller) {
        return Obx(() {
          final orders = controller.orders
              .where(
                  (order) => order.status.toLowerCase() == status.toLowerCase())
              .toList();

          print('Status: $status, Orders count: ${orders.length}');

          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (orders.isEmpty) {
            return Center(child: Text('No $status orders'));
          } else {
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ExpansionTile(
                    title: Text('Order #${order.id ?? (index + 1)}'),
                    subtitle: Text(
                        'Total: \$${order.totalAmount.toStringAsFixed(2)}'),
                    children: [
                      _buildOrderDetails(order),
                      _buildActionButtons(order),
                    ],
                  ),
                );
              },
            );
          }
        });
      },
    );
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

  Widget _buildActionButtons(Order order) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: order.status.toLowerCase() == 'completed'
                ? null
                : () => _markAsCompleted(order),
            icon: const Icon(
              Icons.check_sharp,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: order.status.toLowerCase() == 'completed'
                ? null
                : () => _deleteOrder(order),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }

  void _markAsCompleted(Order order) {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Action'),
          content: const Text(
              'Are you sure you want to mark this order as completed?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                adminController.markCompleted(order.id!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteOrder(Order order) {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text(
              'Are you sure you want to delete this order? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                // Call the method to delete the order
                orderController.deleteOrder(order.id!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
