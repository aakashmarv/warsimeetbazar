class PlaceOrderRequest {
  final int? userId;
  final String? recipientName;
  final String? recipientPhone;
  final String? deliveryAddress;
  final String? deliveryCity;
  final String? deliveryState;
  final String? deliveryPostcode;
  final double? totalAmount;
  final String? paymentStatus;
  final String? orderStatus;
  final String? notes;
  final String? dispatchedAt;
  final String? deliveredAt;
  final double? latitude;
  final double? longitude;

  PlaceOrderRequest({
    this.userId,
    this.recipientName,
    this.recipientPhone,
    this.deliveryAddress,
    this.deliveryCity,
    this.deliveryState,
    this.deliveryPostcode,
    this.totalAmount,
    this.paymentStatus,
    this.orderStatus,
    this.notes,
    this.dispatchedAt,
    this.deliveredAt,
    this.latitude,
    this.longitude,
  });

  factory PlaceOrderRequest.fromJson(Map<String, dynamic> json) {
    return PlaceOrderRequest(
      userId: json['user_id'] as int?,
      recipientName: json['recipient_name'] as String?,
      recipientPhone: json['recipient_phone'] as String?,
      deliveryAddress: json['delivery_address'] as String?,
      deliveryCity: json['delivery_city'] as String?,
      deliveryState: json['delivery_state'] as String?,
      deliveryPostcode: json['delivery_postcode'] as String?,
      totalAmount: (json['total_amount'] != null)
          ? (json['total_amount'] as num).toDouble()
          : null,
      paymentStatus: json['payment_status'] as String?,
      orderStatus: json['order_status'] as String?,
      notes: json['notes'] as String?,
      dispatchedAt: json['dispatched_at'] as String?,
      deliveredAt: json['delivered_at'] as String?,
      latitude: (json['lattitude'] != null)
          ? (json['lattitude'] as num).toDouble()
          : null,
      longitude: (json['longitude'] != null)
          ? (json['longitude'] as num).toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'recipient_name': recipientName,
      'recipient_phone': recipientPhone,
      'delivery_address': deliveryAddress,
      'delivery_city': deliveryCity,
      'delivery_state': deliveryState,
      'delivery_postcode': deliveryPostcode,
      'total_amount': totalAmount,
      'payment_status': paymentStatus,
      'order_status': orderStatus,
      'notes': notes,
      'dispatched_at': dispatchedAt,
      'delivered_at': deliveredAt,
      'lattitude': latitude,
      'longitude': longitude,
    };
  }
}
