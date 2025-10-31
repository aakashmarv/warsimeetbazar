class OrderListResponse {
  final String status;
  final List<Order> orders;

  OrderListResponse({
    required this.status,
    required this.orders,
  });

  factory OrderListResponse.fromJson(Map<String, dynamic> json) {
    return OrderListResponse(
      status: json["status"] ?? "",
      orders: json["orders"] != null
          ? List<Order>.from(json["orders"].map((x) => Order.fromJson(x)))
          : [],
    );
  }
}
class Order {
  final int id;
  final String orderNumber;
  final int? partnerId;
  final double totalAmount;
  final String paymentStatus;
  final String orderStatus;
  final String createdAt;
  final String? deliveredAt;
  final List<OrderItem> orderItems;

  Order({
    required this.id,
    required this.orderNumber,
    required this.partnerId,
    required this.totalAmount,
    required this.paymentStatus,
    required this.orderStatus,
    required this.createdAt,
    required this.deliveredAt,
    required this.orderItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"] ?? 0,
      orderNumber: json["order_number"] ?? "",
      partnerId: json["partner_id"],
      totalAmount: double.tryParse(json["total_amount"].toString()) ?? 0.0,
      paymentStatus: json["payment_status"] ?? "",
      orderStatus: json["order_status"] ?? "",
      createdAt: json["created_at"] ?? "",
      deliveredAt: json["delivered_at"],
      orderItems: json["order_items"] != null
          ? List<OrderItem>.from(
              json["order_items"].map((x) => OrderItem.fromJson(x)))
          : [],
    );
  }
}
class OrderItem {
  final int id;
  final int productId;
  final int quantity;
  final double price;
  final double total;

  OrderItem({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.total,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json["id"] ?? 0,
      productId: json["product_id"] ?? 0,
      quantity: json["quantity"] ?? 0,
      price: double.tryParse(json["price"].toString()) ?? 0.0,
      total: double.tryParse(json["total"].toString()) ?? 0.0,
    );
  }
}
