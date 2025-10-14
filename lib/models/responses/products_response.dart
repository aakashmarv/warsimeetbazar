class ProductsResponse {
  final List<Product>? products;
  final bool? success;

  ProductsResponse({
    this.products,
    this.success,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsResponse(
      products: (json['products'] as List?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
    'products': products?.map((e) => e.toJson()).toList(),
    'success': success,
  };
}

class Product {
  final int? id;
  final int? categoryId;
  final int? subCategoryId;
  final String? name;
  final String? description;
  final String? price;
  final String? image;
  final String? weight;
  final int? stock;
  final String? createdAt;
  final String? updatedAt;
  final Category? category;
  final SubCategory? subcategory;

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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      categoryId: json['category_id'] as int?,
      subCategoryId: json['sub_category_id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: json['price']?.toString(),
      image: json['image'] as String?,
      weight: json['weight']?.toString(),
      stock: json['stock'] is int
          ? json['stock'] as int?
          : int.tryParse(json['stock']?.toString() ?? ''),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      category: json['category'] != null
          ? Category.fromJson(json['category'] as Map<String, dynamic>)
          : null,
      subcategory: json['subcategory'] != null
          ? SubCategory.fromJson(json['subcategory'] as Map<String, dynamic>)
          : null,
    );
  }

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
    'created_at': createdAt,
    'updated_at': updatedAt,
    'category': category?.toJson(),
    'subcategory': subcategory?.toJson(),
  };
}

class Category {
  final int? id;
  final String? name;
  final String? description;
  final String? image;
  final String? slug;
  final String? createdAt;
  final String? updatedAt;

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
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'image': image,
    'slug': slug,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class SubCategory {
  final int? id;
  final String? name;
  final int? categoryId;
  final String? description;
  final String? image;
  final String? createdAt;
  final String? updatedAt;

  SubCategory({
    this.id,
    this.name,
    this.categoryId,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json['id'] as int?,
    name: json['name'] as String?,
    categoryId: json['category_id'] as int?,
    description: json['description'] as String?,
    image: json['image'] as String?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'category_id': categoryId,
    'description': description,
    'image': image,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
