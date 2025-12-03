// class PlaceorderResponse {
//   final bool? status;
//   final String? message;
//   final Order? order;

//   PlaceorderResponse({this.status, this.message, this.order});

//   factory PlaceorderResponse.fromJson(Map<String, dynamic>? json) {
//     if (json == null) return PlaceorderResponse();
//     return PlaceorderResponse(
//       status: json['status'] as bool?,
//       message: json['message'] as String?,
//       order: json['order'] != null ? Order.fromJson(json['order']) : null,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'status': status,
//         'message': message,
//         'order': order?.toJson(),
//       };
// }


// //   Map<String, dynamic> toJson() {
// //     return {
// //       'status': status,
// //       'message': message,
// //       'order': order?.toJson(),                                    
// //     };
// //   }
// // }

// class Order {
//   final int? id;
//   final String? orderNumber;
//   final int? userId;
//   final int? partnerId;
//   final String? recipientName;
//   final String? recipientPhone;
//   final String? deliveryAddress;
//   final String? deliveryCity;
//   final String? deliveryState;
//   final String? deliveryPostcode;
//   final double? latitude;
//   final double? longitude;
//   final double? totalAmount;
//   final String? paymentStatus;
//   final String? orderStatus;
//   final String? notes;
//   final String? dispatchedAt;
//   final String? deliveredAt;
//   final String? cancelledAt;
//   final int? address;
//   final String? createdAt;
//   final String? updatedAt;
//   final List<OrderItem>? orderItems;

//   Order({
//     this.id,
//     this.orderNumber,
//     this.userId,
//     this.partnerId,
//     this.recipientName,
//     this.recipientPhone,
//     this.deliveryAddress,
//     this.deliveryCity,
//     this.deliveryState,
//     this.deliveryPostcode,
//     this.latitude,
//     this.longitude,
//     this.totalAmount,
//     this.paymentStatus,
//     this.orderStatus,
//     this.notes,
//     this.dispatchedAt,
//     this.deliveredAt,
//     this.cancelledAt,
//     this.address,
//     this.createdAt,
//     this.updatedAt,
//     this.orderItems,
//   });

//   factory Order.fromJson(Map<String, dynamic> json) {
//     return Order(
//       id: json['id'] as int?,
//       orderNumber: json['order_number'] as String?,
//       userId: json['user_id'] as int?,
//       partnerId: json['partner_id'] as int?,
//       recipientName: json['recipient_name'] as String?,
//       recipientPhone: json['recipient_phone'] as String?,
//       deliveryAddress: json['delivery_address'] as String?,
//       deliveryCity: json['delivery_city'] as String?,
//       deliveryState: json['delivery_state'] as String?,
//       deliveryPostcode: json['delivery_postcode'] as String?,
//       latitude: _toDouble(json['latitude']),
//       longitude: _toDouble(json['longitude']),
//       totalAmount: _toDouble(json['total_amount']),
//       paymentStatus: json['payment_status'] as String?,
//       orderStatus: json['order_status'] as String?,
//       notes: json['notes'] as String?,
//       dispatchedAt: json['dispatched_at'] as String?,
//       deliveredAt: json['delivered_at'] as String?,
//       cancelledAt: json['cancelled_at'] as String?,
//       address: json['address'] as int?,
//       createdAt: json['created_at'] as String?,
//       updatedAt: json['updated_at'] as String?,
//       orderItems: (json['order_items'] as List<dynamic>?)
//           ?.map((item) => OrderItem.fromJson(item))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'order_number': orderNumber,
//       'user_id': userId,
//       'partner_id': partnerId,
//       'recipient_name': recipientName,
//       'recipient_phone': recipientPhone,
//       'delivery_address': deliveryAddress,
//       'delivery_city': deliveryCity,
//       'delivery_state': deliveryState,
//       'delivery_postcode': deliveryPostcode,
//       'latitude': latitude,
//       'longitude': longitude,
//       'total_amount': totalAmount,
//       'payment_status': paymentStatus,
//       'order_status': orderStatus,
//       'notes': notes,
//       'dispatched_at': dispatchedAt,
//       'delivered_at': deliveredAt,
//       'cancelled_at': cancelledAt,
//       'address': address,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'order_items': orderItems?.map((e) => e.toJson()).toList(),
//     };
//   }
// }

// class OrderItem {
//   final int? id;
//   final int? orderId;
//   final int? productId;
//   final int? quantity;
//   final String? cuttingType;
//   final String? weight;
//   final double? price;
//   final double? total;
//   final String? status;
//   final String? createdAt;
//   final String? updatedAt;
//   final Product? product;

//   OrderItem({
//     this.id,
//     this.orderId,
//     this.productId,
//     this.quantity,
//     this.cuttingType,
//     this.weight,
//     this.price,
//     this.total,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.product,
//   });

//   factory OrderItem.fromJson(Map<String, dynamic> json) {
//     return OrderItem(
//       id: json['id'] as int?,
//       orderId: json['order_id'] as int?,
//       productId: json['product_id'] as int?,
//       quantity: json['quantity'] as int?,
//       cuttingType: json['cutting_type'] as String?,
//       weight: json['weight'] as String?,
//       price: _toDouble(json['price']),
//       total: _toDouble(json['total']),
//       status: json['status'] as String?,
//       createdAt: json['created_at'] as String?,
//       updatedAt: json['updated_at'] as String?,
//       product: json['product'] != null
//           ? Product.fromJson(json['product'])
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'order_id': orderId,
//       'product_id': productId,
//       'quantity': quantity,
//       'cutting_type': cuttingType,
//       'weight': weight,
//       'price': price,
//       'total': total,
//       'status': status,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'product': product?.toJson(),
//     };
//   }
// }

// class Product {
//   final int? id;
//   final int? categoryId;
//   final int? subCategoryId;
//   final String? name;
//   final String? description;
//   final double? price;
//   final String? image;
//   final String? weight;
//   final int? stock;
//   final String? createdAt;
//   final String? updatedAt;

//   Product({
//     this.id,
//     this.categoryId,
//     this.subCategoryId,
//     this.name,
//     this.description,
//     this.price,
//     this.image,
//     this.weight,
//     this.stock,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'] as int?,
//       categoryId: json['category_id'] as int?,
//       subCategoryId: json['sub_category_id'] as int?,
//       name: json['name'] as String?,
//       description: json['description'] as String?,
//       price: _toDouble(json['price']),
//       image: json['image'] as String?,
//       weight: json['weight'] as String?,
//       stock: json['stock'] as int?,
//       createdAt: json['created_at'] as String?,
//       updatedAt: json['updated_at'] as String?,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'category_id': categoryId,
//       'sub_category_id': subCategoryId,
//       'name': name,
//       'description': description,
//       'price': price,
//       'image': image,
//       'weight': weight,
//       'stock': stock,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//     };
//   }
// }

// /// --- Helper Function ---
// double? _toDouble(dynamic value) {
//   if (value == null) return null;
//   if (value is double) return value;
//   if (value is int) return value.toDouble();
//   if (value is String) return double.tryParse(value);
//   return null;
// }



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
