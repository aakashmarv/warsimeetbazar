// class PlaceorderResponse {
//   String status;
//   String message;
//   OrderData order;

//   PlaceorderResponse({
//     required this.status,
//     required this.message,
//     required this.order,
//   });

//   factory PlaceorderResponse.fromJson(Map<String, dynamic> json) => PlaceorderResponse(
//         status: json['status'],
//         message: json['message'],
//         order: OrderData.fromJson(json['order']),
//       );

//   Map<String, dynamic> toJson() => {
//         'status': status,
//         'message': message,
//         'order': order.toJson(),
//       };
// }

// class OrderData {
//   int id;
//   String orderNumber;
//   int userId;
//   String recipientName;
//   String recipientPhone;
//   String deliveryAddress;
//   String deliveryCity;
//   String deliveryState;
//   String deliveryPostcode;
//   double totalAmount;
//   String paymentStatus;
//   String orderStatus;
//   String? notes;
//   DateTime? dispatchedAt;
//   DateTime? deliveredAt;
//   DateTime updatedAt;
//   DateTime createdAt;

//   OrderData({
//     required this.id,
//     required this.orderNumber,
//     required this.userId,
//     required this.recipientName,
//     required this.recipientPhone,
//     required this.deliveryAddress,
//     required this.deliveryCity,
//     required this.deliveryState,
//     required this.deliveryPostcode,
//     required this.totalAmount,
//     required this.paymentStatus,
//     required this.orderStatus,
//     this.notes,
//     this.dispatchedAt,
//     this.deliveredAt,
//     required this.updatedAt,
//     required this.createdAt,
//   });

//   factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
//         id: json['id'],
//         orderNumber: json['order_number'],
//         userId: json['user_id'],
//         recipientName: json['recipient_name'],
//         recipientPhone: json['recipient_phone'],
//         deliveryAddress: json['delivery_address'],
//         deliveryCity: json['delivery_city'],
//         deliveryState: json['delivery_state'],
//         deliveryPostcode: json['delivery_postcode'],
//         totalAmount: (json['total_amount'] as num).toDouble(),
//         paymentStatus: json['payment_status'],
//         orderStatus: json['order_status'],
//         notes: json['notes'],
//         dispatchedAt: json['dispatched_at'] != null
//             ? DateTime.parse(json['dispatched_at'])
//             : null,
//         deliveredAt: json['delivered_at'] != null
//             ? DateTime.parse(json['delivered_at'])
//             : null,
//         updatedAt: DateTime.parse(json['updated_at']),
//         createdAt: DateTime.parse(json['created_at']),
//       );

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'order_number': orderNumber,
//         'user_id': userId,
//         'recipient_name': recipientName,
//         'recipient_phone': recipientPhone,
//         'delivery_address': deliveryAddress,
//         'delivery_city': deliveryCity,
//         'delivery_state': deliveryState,
//         'delivery_postcode': deliveryPostcode,
//         'total_amount': totalAmount,
//         'payment_status': paymentStatus,
//         'order_status': orderStatus,
//         'notes': notes,
//         'dispatched_at': dispatchedAt?.toIso8601String(),
//         'delivered_at': deliveredAt?.toIso8601String(),
//         'updated_at': updatedAt.toIso8601String(),
//         'created_at': createdAt.toIso8601String(),
//       };
// }





class PlaceorderResponse {
  final String status;
  final String message;
  final Order? order;

  PlaceorderResponse({
    required this.status,
    required this.message,
    this.order,
  });

  factory PlaceorderResponse.fromJson(Map<String, dynamic> json) {
    final orderData = json['order'];

    return PlaceorderResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      order: (orderData is Map<String, dynamic>)
          ? Order.fromJson(orderData)
          : null, // 👈 safely ignore if it's a list or null
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

  Order({this.orderNumber});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderNumber: json['order_number'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_number': orderNumber,
    };
  }
}
