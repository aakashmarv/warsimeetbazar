class PlaceorderResponse {
  final String? status;
  final String? message;
  final Order? order;

  PlaceorderResponse({
    this.status,
    this.message,
    this.order,
  });

  factory PlaceorderResponse.fromJson(Map<String, dynamic> json) {
    final orderData = json['order'];

    return PlaceorderResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      order: (orderData is Map<String, dynamic>)
          ? Order.fromJson(orderData)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'order': order?.toJson(),
    };
  }
}

class Order {
  final String? orderNumber;
  final int? userId;
  final double? totalAmount;
  final String? orderStatus;
  final double? latitude;
  final double? longitude;
  final String? updatedAt;
  final String? createdAt;
  final int? id;

  Order({
    this.orderNumber,
    this.userId,
    this.totalAmount,
    this.orderStatus,
    this.latitude,
    this.longitude,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderNumber: json['order_number'] as String?,
      userId: json['user_id'] as int?,
      totalAmount: (json['total_amount'] != null)
          ? (json['total_amount'] as num).toDouble()
          : null,
      orderStatus: json['order_status'] as String?,
      latitude: (json['latitude'] != null)
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude: (json['longitude'] != null)
          ? (json['longitude'] as num).toDouble()
          : null,
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
      id: json['id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_number': orderNumber,
      'user_id': userId,
      'total_amount': totalAmount,
      'order_status': orderStatus,
      'latitude': latitude,
      'longitude': longitude,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
    };
  }
}
