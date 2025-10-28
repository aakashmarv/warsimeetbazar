class AddToCartRequest {
  final List<OrderItem> items;

  AddToCartRequest({required this.items});

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class OrderItem {
  final int productId;
  final int quantity;
  final double price;
  final double total;
  final String status;

  OrderItem({
    required this.productId,
    required this.quantity,
    required this.price,
    required this.total,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'price': price,
      'total': total,
      'status': status,
    };
  }
}
