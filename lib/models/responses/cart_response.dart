class CartResponse {
  final List<CartItem>? cart;
  final bool? success;

  CartResponse({this.cart, this.success});

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      cart: (json['cart'] as List?)
          ?.map((item) => CartItem.fromJson(item))
          .toList(),
      success: json['success'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cart': cart?.map((item) => item.toJson()).toList(),
      'success': success,
    };
  }
}

class CartItem {
  final int? id;
  final int? userId;
  final int? productId;
  final int? quantity;
  final double? price;
  final String? cuttingType;
  final double? weight;
  final double? total;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final Product? product;

  CartItem({
    this.id,
    this.userId,
    this.productId,
    this.quantity,
    this.price,
    this.cuttingType,
    this.weight,
    this.total,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      price: _toDouble(json['price']),
      cuttingType: json['cutting_type'],
      weight: _toDouble(json['weight']),
      total: _toDouble(json['total']),
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      product: json['product'] != null
          ? Product.fromJson(json['product'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'quantity': quantity,
      'price': price,
      'cutting_type': cuttingType,
      'weight': weight,
      'total': total,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'product': product?.toJson(),
    };
  }
}

class Product {
  final int? id;
  final int? categoryId;
  final int? subCategoryId;
  final String? name;
  final String? description;
  final double? price;
  final String? image;
  final String? weight;
  final int? stock;
  final String? createdAt;
  final String? updatedAt;

  Product({
    this.id,
    this.categoryId,
    this.subCategoryId,
    this.name,
    this.description,
    this.price,
    this.image,
    this.weight,
    this.stock,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      categoryId: json['category_id'],
      subCategoryId: json['sub_category_id'],
      name: json['name'],
      description: json['description'],
      price: _toDouble(json['price']),
      image: json['image'],
      weight: json['weight']?.toString(),
      stock: json['stock'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'sub_category_id': subCategoryId,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'weight': weight,
      'stock': stock,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

/// ✅ Helper to safely convert dynamic to double
double? _toDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}
