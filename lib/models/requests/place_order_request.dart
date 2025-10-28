// class PlaceOrderRequest {
//   int userId;
//   String recipientName;
//   String recipientPhone;
//   String deliveryAddress;
//   String deliveryCity;
//   String deliveryState;
//   String deliveryPostcode;
//   double totalAmount;
//   List<OrderItem> items;
//   String paymentStatus;
//   String orderStatus;
//   String? notes;
//   DateTime? dispatchedAt;
//   DateTime? deliveredAt;

//   PlaceOrderRequest({
//     required this.userId,
//     required this.recipientName,
//     required this.recipientPhone,
//     required this.deliveryAddress,
//     required this.deliveryCity,
//     required this.deliveryState,
//     required this.deliveryPostcode,
//     required this.totalAmount,
//     required this.items,
//     required this.paymentStatus,
//     required this.orderStatus,
//     this.notes,
//     this.dispatchedAt,
//     this.deliveredAt,
//   });

//   factory PlaceOrderRequest.fromJson(Map<String, dynamic> json) => PlaceOrderRequest(
//         userId: json['user_id'],
//         recipientName: json['recipient_name'],
//         recipientPhone: json['recipient_phone'],
//         deliveryAddress: json['delivery_address'],
//         deliveryCity: json['delivery_city'],
//         deliveryState: json['delivery_state'],
//         deliveryPostcode: json['delivery_postcode'],
//         totalAmount: (json['total_amount'] as num).toDouble(),
//         items: (json['items'] as List)
//             .map((e) => OrderItem.fromJson(e))
//             .toList(),
//         paymentStatus: json['payment_status'],
//         orderStatus: json['order_status'],
//         notes: json['notes'],
//         dispatchedAt: json['dispatched_at'] != null
//             ? DateTime.parse(json['dispatched_at'])
//             : null,
//         deliveredAt: json['delivered_at'] != null
//             ? DateTime.parse(json['delivered_at'])
//             : null,
//       );

//   Map<String, dynamic> toJson() => {
//         'user_id': userId,
//         'recipient_name': recipientName,
//         'recipient_phone': recipientPhone,
//         'delivery_address': deliveryAddress,
//         'delivery_city': deliveryCity,
//         'delivery_state': deliveryState,
//         'delivery_postcode': deliveryPostcode,
//         'total_amount': totalAmount,
//         'items': items.map((e) => e.toJson()).toList(),
//         'payment_status': paymentStatus,
//         'order_status': orderStatus,
//         'notes': notes,
//         'dispatched_at': dispatchedAt?.toIso8601String(),
//         'delivered_at': deliveredAt?.toIso8601String(),
//       };
// }

// class OrderItem {
//   int orderId;
//   int productId;
//   int quantity;
//   String cuttingType;
//   double price;
//   double total;
//   String status;

//   OrderItem({
//     required this.orderId,
//     required this.productId,
//     required this.quantity,
//     required this.cuttingType,
//     required this.price,
//     required this.total,
//     required this.status,
//   });

//   factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
//         orderId: json['order_id'],
//         productId: json['product_id'],
//         quantity: json['quantity'],
//         cuttingType: json['cutting_type'],
//         price: (json['price'] as num).toDouble(),
//         total: (json['total'] as num).toDouble(),
//         status: json['status'],
//       );

//   Map<String, dynamic> toJson() => {
//         'order_id': orderId,
//         'product_id': productId,
//         'quantity': quantity,
//         'cutting_type': cuttingType,
//         'price': price,
//         'total': total,
//         'status': status,
//       };
// }
