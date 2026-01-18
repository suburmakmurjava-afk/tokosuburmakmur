import 'package:isar/isar.dart';

part 'product.g.dart';

@collection
class Product {
  Id id = Isar.autoIncrement;

  @Index()
  late String name;

  @Index()
  @Enumerated(EnumType.name)
  late ProductCategory category;

  /// ID dari subcategory yang terkait
  @Index()
  int? subcategoryId;

  late double priceRetail;
  late double priceWholesale;
  late double pricePurchase;

  late int stock;

  String? imagePath;

  String? description;

  DateTime createdAt = DateTime.now();

  DateTime updatedAt = DateTime.now();

  Product({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.category,
    this.subcategoryId,
    required this.priceRetail,
    required this.priceWholesale,
    required this.pricePurchase,
    required this.stock,
    this.imagePath,
    this.description,
  });

  Product copyWith({
    Id? id,
    String? name,
    ProductCategory? category,
    int? subcategoryId,
    double? priceRetail,
    double? priceWholesale,
    double? pricePurchase,
    int? stock,
    String? imagePath,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      subcategoryId: subcategoryId ?? this.subcategoryId,
      priceRetail: priceRetail ?? this.priceRetail,
      priceWholesale: priceWholesale ?? this.priceWholesale,
      pricePurchase: pricePurchase ?? this.pricePurchase,
      stock: stock ?? this.stock,
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
    );
  }
}

enum ProductCategory {
  agriculture('Pertanian', '🌾'),
  livestock('Peternakan', '🐄');

  final String displayName;
  final String icon;

  const ProductCategory(this.displayName, this.icon);
}

