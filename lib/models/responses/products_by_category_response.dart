class ProductsByCategoryResponse {
  bool? success;
  List<Product>? products;

  ProductsByCategoryResponse({this.success, this.products});

  factory ProductsByCategoryResponse.fromJson(Map<String, dynamic> json) {
    return ProductsByCategoryResponse(
      success: json['success'] as bool?,
      products: json['products'] != null
          ? List<Product>.from(
          (json['products'] as List).map((x) => Product.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'products': products?.map((x) => x.toJson()).toList(),
  };
}

class Product {
  int? id;
  int? categoryId;
  int? subCategoryId;
  String? name;
  String? description;
  String? price;
  String? image;
  dynamic weight;
  int? stock;
  DateTime? createdAt;
  DateTime? updatedAt;
  Category? category;
  Subcategory? subcategory;

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
    this.category,
    this.subcategory,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'] as int?,
    categoryId: json['category_id'] as int?,
    subCategoryId: json['sub_category_id'] as int?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    price: json['price'] as String?,
    image: json['image'] as String?,
    weight: json['weight'],
    stock: json['stock'] as int?,
    createdAt: json['created_at'] != null
        ? DateTime.tryParse(json['created_at'])
        : null,
    updatedAt: json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'])
        : null,
    category: json['category'] != null
        ? Category.fromJson(json['category'])
        : null,
    subcategory: json['subcategory'] != null
        ? Subcategory.fromJson(json['subcategory'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'category_id': categoryId,
    'sub_category_id': subCategoryId,
    'name': name,
    'description': description,
    'price': price,
    'image': image,
    'weight': weight,
    'stock': stock,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'category': category?.toJson(),
    'subcategory': subcategory?.toJson(),
  };
}

class Category {
  int? id;
  String? name;
  String? description;
  String? image;
  String? slug;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category({
    this.id,
    this.name,
    this.description,
    this.image,
    this.slug,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'] as int?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    image: json['image'] as String?,
    slug: json['slug'] as String?,
    createdAt: json['created_at'] != null
        ? DateTime.tryParse(json['created_at'])
        : null,
    updatedAt: json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'image': image,
    'slug': slug,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}

class Subcategory {
  int? id;
  String? name;
  int? categoryId;
  String? description;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  Subcategory({
    this.id,
    this.name,
    this.categoryId,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    id: json['id'] as int?,
    name: json['name'] as String?,
    categoryId: json['category_id'] as int?,
    description: json['description'] as String?,
    image: json['image'] as String?,
    createdAt: json['created_at'] != null
        ? DateTime.tryParse(json['created_at'])
        : null,
    updatedAt: json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'category_id': categoryId,
    'description': description,
    'image': image,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}
