class PlaceorderResponse {
  final bool status;
  final String message;
  final Order order;

  PlaceorderResponse({
    required this.status,
    required this.message,
    required this.order,
  });

  factory PlaceorderResponse.fromJson(Map<String, dynamic> json) {
    return PlaceorderResponse(
      status: json['status'],
      message: json['message'],
      order: Order.fromJson(json['order']),
    );
  }
}

class Order {
  final int id;
  final String orderNumber;
  final int userId;
  final int? partnerId;
  final String? recipientName;
  final String? recipientPhone;
  final String? deliveryAddress;
  final String? deliveryCity;
  final String? deliveryState;
  final String? deliveryPostcode;
  final String latitude;
  final String longitude;
  final String totalAmount;
  final String address;
  final String paymentStatus;
  final String orderStatus;
  final String? notes;
  final String? dispatchedAt;
  final String? deliveredAt;
  final String? cancelledAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<OrderItem> orderItems;

  Order({
    required this.id,
    required this.orderNumber,
    required this.userId,
    required this.partnerId,
    required this.recipientName,
    required this.recipientPhone,
    required this.deliveryAddress,
    required this.deliveryCity,
    required this.deliveryState,
    required this.deliveryPostcode,
    required this.latitude,
    required this.longitude,
    required this.totalAmount,
    required this.address,
    required this.paymentStatus,
    required this.orderStatus,
    required this.notes,
    required this.dispatchedAt,
    required this.deliveredAt,
    required this.cancelledAt,
    required this.createdAt,
    required this.updatedAt,
    required this.orderItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderNumber: json['order_number'],
      userId: json['user_id'],
      partnerId: json['partner_id'],
      recipientName: json['recipient_name'],
      recipientPhone: json['recipient_phone'],
      deliveryAddress: json['delivery_address'],
      deliveryCity: json['delivery_city'],
      deliveryState: json['delivery_state'],
      deliveryPostcode: json['delivery_postcode'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      totalAmount: json['total_amount'],
      address: json['address'],
      paymentStatus: json['payment_status'],
      orderStatus: json['order_status'],
      notes: json['notes'],
      dispatchedAt: json['dispatched_at'],
      deliveredAt: json['delivered_at'],
      cancelledAt: json['cancelled_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      orderItems: (json['order_items'] as List)
          .map((e) => OrderItem.fromJson(e))
          .toList(),
    );
  }
}

class OrderItem {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final String? cuttingType;
  final String? weight;
  final String price;
  final String total;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Product product;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.cuttingType,
    required this.weight,
    required this.price,
    required this.total,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      cuttingType: json['cutting_type'],
      weight: json['weight'],
      price: json['price'],
      total: json['total'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      product: Product.fromJson(json['product']),
    );
  }
}

class Product {
  final int id;
  final int categoryId;
  final int subCategoryId;
  final String name;
  final String description;
  final String price;
  final String image;
  final String? weight;
  final int stock;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.categoryId,
    required this.subCategoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.weight,
    required this.stock,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      categoryId: json['category_id'],
      subCategoryId: json['sub_category_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      weight: json['weight'],
      stock: json['stock'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
