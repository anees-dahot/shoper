import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoper/features/orders/screen/orders_screen.dart';
import '../../orders/controller/order_controller.dart';
import '../../../model/order.dart'; // Make sure to import your Order and OrderItem models

class YourOrdersWidget extends StatefulWidget {
  YourOrdersWidget({Key? key}) : super(key: key);

  @override
  State<YourOrdersWidget> createState() => _YourOrdersWidgetState();
}

class _YourOrdersWidgetState extends State<YourOrdersWidget> {
  final OrderController orderController = Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    orderController.getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        children: [
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Orders',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: (){
Navigator.pushNamed(context, OrdersPage.routeName);
                  },
                  child: const Text(
                    'See All',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GetBuilder<OrderController>(
              builder: (controller) {
                return Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.orders.isEmpty) {
                    return const Center(child: Text('No orders'));
                  } else {
                    // Flatten the list of items from all orders
                    List<OrderItem> allItems = controller.orders
                        .expand((order) => order.items)
                        .toList();

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: allItems.length,
                      itemBuilder: (context, index) {
                        final item = allItems[index];

                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  item.imageUrl,
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.width * 0.4,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.productName,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '\$${item.price.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      'Quantity: ${item.quantity}',
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}