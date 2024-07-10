class Order {
  final String? id;
  final String sellerId;
  final String buyerId;
  final List<OrderItem> items;
  final String shippingAddress;
  final String paymentMethod;
  final double totalAmount;
  final String status;

  Order({
    this.id,
    required this.sellerId,
    required this.buyerId,
    required this.items,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.totalAmount,
    this.status = 'pending',
  });

  Order copyWith({
    String? id,
    String? sellerId,
    String? buyerId,
    List<OrderItem>? items,
    String? shippingAddress,
    String? paymentMethod,
    double? totalAmount,
    String? status,
  }) {
    return Order(
      id: id ?? this.id,
      sellerId: sellerId ?? this.sellerId,
      buyerId: buyerId ?? this.buyerId,
      items: items ?? this.items,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
    );
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'] ?? '',
      sellerId: json['sellerId'],
      buyerId: json['buyerId'],
      items: (json['items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      shippingAddress: json['shippingAddress'],
      paymentMethod: json['paymentMethod'],
      totalAmount: json['totalAmount'].toDouble(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sellerId': sellerId,
      'buyerId': buyerId,
      'items': items.map((item) => item.toJson()).toList(),
      'shippingAddress': shippingAddress,
      'paymentMethod': paymentMethod,
      'totalAmount': totalAmount,
      'status': status,
    };
  }
}

class OrderItem {
  final String productId;
  final String productName;
  final int quantity;
  final double price;
  final String imageUrl;
  final String color;
  final int size;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.imageUrl,
    required this.color,
    required this.size,
  });

  OrderItem copyWith({
    String? productId,
    String? productName,
    int? quantity,
    double? price,
    String? imageUrl,
    String? color,
    int? size,
  }) {
    return OrderItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      color: color ?? this.color,
      size: size ?? this.size,
    );
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'],
      productName: json['productName'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      color: json['color'],
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'price': price,
      'imageUrl': imageUrl,
      'color': color,
      'size': size,
    };
  }
}