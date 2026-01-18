import 'package:isar/isar.dart';
import 'product.dart';

part 'subcategory.g.dart';

@collection
class SubCategory {
  Id id = Isar.autoIncrement;

  @Index()
  late String name;

  late String icon;

  @Index()
  @Enumerated(EnumType.name)
  late ProductCategory parentCategory;

  /// True jika ini adalah subcategory default/bawaan
  /// Default subcategory tidak bisa dihapus oleh user
  bool isDefault = false;

  DateTime createdAt = DateTime.now();

  SubCategory({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.icon,
    required this.parentCategory,
    this.isDefault = false,
  });

  SubCategory copyWith({
    Id? id,
    String? name,
    String? icon,
    ProductCategory? parentCategory,
    bool? isDefault,
  }) {
    return SubCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      parentCategory: parentCategory ?? this.parentCategory,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

/// Daftar subcategory default untuk Pertanian
List<SubCategory> getDefaultAgricultureSubcategories() {
  return [
    SubCategory(name: 'Fungisida', icon: '🍄', parentCategory: ProductCategory.agriculture, isDefault: true),
    SubCategory(name: 'Insektisida', icon: '🦗', parentCategory: ProductCategory.agriculture, isDefault: true),
    SubCategory(name: 'Herbisida', icon: '🌿', parentCategory: ProductCategory.agriculture, isDefault: true),
    SubCategory(name: 'Pupuk Organik', icon: '🌱', parentCategory: ProductCategory.agriculture, isDefault: true),
    SubCategory(name: 'Pupuk Kimia', icon: '⚗️', parentCategory: ProductCategory.agriculture, isDefault: true),
    SubCategory(name: 'Bibit Tanaman', icon: '🌾', parentCategory: ProductCategory.agriculture, isDefault: true),
    SubCategory(name: 'Benih', icon: '🫘', parentCategory: ProductCategory.agriculture, isDefault: true),
    SubCategory(name: 'Mesin Pertanian', icon: '🚜', parentCategory: ProductCategory.agriculture, isDefault: true),
    SubCategory(name: 'Alat Pertanian', icon: '🔧', parentCategory: ProductCategory.agriculture, isDefault: true),
    SubCategory(name: 'ZPT (Zat Pengatur Tumbuh)', icon: '🧪', parentCategory: ProductCategory.agriculture, isDefault: true),
    SubCategory(name: 'Rodentisida', icon: '🐀', parentCategory: ProductCategory.agriculture, isDefault: true),
    SubCategory(name: 'Molluskisida', icon: '🐌', parentCategory: ProductCategory.agriculture, isDefault: true),
    SubCategory(name: 'Mulsa & Plastik', icon: '📦', parentCategory: ProductCategory.agriculture, isDefault: true),
    SubCategory(name: 'Perlengkapan Irigasi', icon: '💧', parentCategory: ProductCategory.agriculture, isDefault: true),
  ];
}

/// Daftar subcategory default untuk Peternakan
List<SubCategory> getDefaultLivestockSubcategories() {
  return [
    SubCategory(name: 'Pakan Ayam', icon: '🐔', parentCategory: ProductCategory.livestock, isDefault: true),
    SubCategory(name: 'Pakan Sapi', icon: '🐄', parentCategory: ProductCategory.livestock, isDefault: true),
    SubCategory(name: 'Pakan Kambing', icon: '🐐', parentCategory: ProductCategory.livestock, isDefault: true),
    SubCategory(name: 'Pakan Ikan', icon: '🐟', parentCategory: ProductCategory.livestock, isDefault: true),
    SubCategory(name: 'Pakan Burung', icon: '🐦', parentCategory: ProductCategory.livestock, isDefault: true),
    SubCategory(name: 'Obat Ternak', icon: '💊', parentCategory: ProductCategory.livestock, isDefault: true),
    SubCategory(name: 'Vitamin & Suplemen', icon: '💉', parentCategory: ProductCategory.livestock, isDefault: true),
    SubCategory(name: 'Vaksin', icon: '🩺', parentCategory: ProductCategory.livestock, isDefault: true),
    SubCategory(name: 'Peralatan Kandang', icon: '🏠', parentCategory: ProductCategory.livestock, isDefault: true),
    SubCategory(name: 'Tempat Pakan/Minum', icon: '🥣', parentCategory: ProductCategory.livestock, isDefault: true),
    SubCategory(name: 'Mesin Peternakan', icon: '⚙️', parentCategory: ProductCategory.livestock, isDefault: true),
    SubCategory(name: 'Bibit Ternak', icon: '🐣', parentCategory: ProductCategory.livestock, isDefault: true),
    SubCategory(name: 'Peralatan Kesehatan', icon: '🏥', parentCategory: ProductCategory.livestock, isDefault: true),
    SubCategory(name: 'Desinfektan', icon: '🧴', parentCategory: ProductCategory.livestock, isDefault: true),
    SubCategory(name: 'Incubator & Penetasan', icon: '🥚', parentCategory: ProductCategory.livestock, isDefault: true),
  ];
}

/// Gabung semua subcategory default
List<SubCategory> getAllDefaultSubcategories() {
  return [
    ...getDefaultAgricultureSubcategories(),
    ...getDefaultLivestockSubcategories(),
  ];
}
