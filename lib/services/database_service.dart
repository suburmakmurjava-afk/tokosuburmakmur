import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/product.dart';
import '../models/subcategory.dart';

class DatabaseService {
  late Isar _isar;
  bool _isInitialized = false;

  Isar get isar => _isar;
  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    if (_isInitialized) return;

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [ProductSchema, SubCategorySchema],
      directory: dir.path,
      name: 'toko_tani_ternak',
    );
    _isInitialized = true;
    
    // Seed default subcategories jika belum ada
    await _seedDefaultSubcategories();
  }

  /// Seed default subcategories saat pertama kali
  Future<void> _seedDefaultSubcategories() async {
    final count = await _isar.subCategorys.count();
    if (count == 0) {
      final defaults = getAllDefaultSubcategories();
      await _isar.writeTxn(() async {
        await _isar.subCategorys.putAll(defaults);
      });
    }
  }

  // ==================== PRODUCT CRUD ====================

  // Create
  Future<int> addProduct(Product product) async {
    return await _isar.writeTxn(() async {
      return await _isar.products.put(product);
    });
  }

  // Read All
  Future<List<Product>> getAllProducts() async {
    return await _isar.products.where().findAll();
  }

  // Read by Category
  Future<List<Product>> getProductsByCategory(ProductCategory category) async {
    return await _isar.products
        .filter()
        .categoryEqualTo(category)
        .findAll();
  }

  // Read by SubCategory
  Future<List<Product>> getProductsBySubcategory(int subcategoryId) async {
    return await _isar.products
        .filter()
        .subcategoryIdEqualTo(subcategoryId)
        .findAll();
  }

  // Read Single
  Future<Product?> getProductById(int id) async {
    return await _isar.products.get(id);
  }

  // Update
  Future<int> updateProduct(Product product) async {
    product.updatedAt = DateTime.now();
    return await _isar.writeTxn(() async {
      return await _isar.products.put(product);
    });
  }

  // Delete
  Future<bool> deleteProduct(int id) async {
    return await _isar.writeTxn(() async {
      return await _isar.products.delete(id);
    });
  }

  // Search
  Future<List<Product>> searchProducts(String query) async {
    return await _isar.products
        .filter()
        .nameContains(query, caseSensitive: false)
        .findAll();
  }

  // Watch all products (stream)
  Stream<List<Product>> watchAllProducts() {
    return _isar.products.where().watch(fireImmediately: true);
  }

  // Watch products by category
  Stream<List<Product>> watchProductsByCategory(ProductCategory category) {
    return _isar.products
        .filter()
        .categoryEqualTo(category)
        .watch(fireImmediately: true);
  }

  // Watch products by subcategory
  Stream<List<Product>> watchProductsBySubcategory(int subcategoryId) {
    return _isar.products
        .filter()
        .subcategoryIdEqualTo(subcategoryId)
        .watch(fireImmediately: true);
  }

  // Get product count
  Future<int> getProductCount() async {
    return await _isar.products.count();
  }

  // ==================== SUBCATEGORY CRUD ====================

  // Create
  Future<int> addSubCategory(SubCategory subcategory) async {
    return await _isar.writeTxn(() async {
      return await _isar.subCategorys.put(subcategory);
    });
  }

  // Read All
  Future<List<SubCategory>> getAllSubCategories() async {
    return await _isar.subCategorys.where().findAll();
  }

  // Read by Parent Category
  Future<List<SubCategory>> getSubCategoriesByParent(ProductCategory parentCategory) async {
    return await _isar.subCategorys
        .filter()
        .parentCategoryEqualTo(parentCategory)
        .findAll();
  }

  // Read Single
  Future<SubCategory?> getSubCategoryById(int id) async {
    return await _isar.subCategorys.get(id);
  }

  // Update
  Future<int> updateSubCategory(SubCategory subcategory) async {
    return await _isar.writeTxn(() async {
      return await _isar.subCategorys.put(subcategory);
    });
  }

  // Delete (hanya untuk non-default)
  Future<bool> deleteSubCategory(int id) async {
    final subcategory = await getSubCategoryById(id);
    if (subcategory == null || subcategory.isDefault) {
      return false; // Tidak bisa hapus subcategory default
    }
    return await _isar.writeTxn(() async {
      return await _isar.subCategorys.delete(id);
    });
  }

  // Watch all subcategories
  Stream<List<SubCategory>> watchAllSubCategories() {
    return _isar.subCategorys.where().watch(fireImmediately: true);
  }

  // Watch subcategories by parent category
  Stream<List<SubCategory>> watchSubCategoriesByParent(ProductCategory parentCategory) {
    return _isar.subCategorys
        .filter()
        .parentCategoryEqualTo(parentCategory)
        .watch(fireImmediately: true);
  }

  // Get subcategory count
  Future<int> getSubCategoryCount() async {
    return await _isar.subCategorys.count();
  }

  // Close database
  Future<void> close() async {
    await _isar.close();
    _isInitialized = false;
  }
}

// ==================== RIVERPOD PROVIDERS ====================

final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService();
});

// Product Providers
final productsStreamProvider = StreamProvider<List<Product>>((ref) {
  final db = ref.watch(databaseServiceProvider);
  return db.watchAllProducts();
});

final productsByCategoryProvider = StreamProvider.family<List<Product>, ProductCategory?>((ref, category) {
  final db = ref.watch(databaseServiceProvider);
  if (category == null) {
    return db.watchAllProducts();
  }
  return db.watchProductsByCategory(category);
});

final productsBySubcategoryProvider = StreamProvider.family<List<Product>, int?>((ref, subcategoryId) {
  final db = ref.watch(databaseServiceProvider);
  if (subcategoryId == null) {
    return db.watchAllProducts();
  }
  return db.watchProductsBySubcategory(subcategoryId);
});

// SubCategory Providers
final subCategoriesStreamProvider = StreamProvider<List<SubCategory>>((ref) {
  final db = ref.watch(databaseServiceProvider);
  return db.watchAllSubCategories();
});

final subCategoriesByParentProvider = StreamProvider.family<List<SubCategory>, ProductCategory>((ref, parentCategory) {
  final db = ref.watch(databaseServiceProvider);
  return db.watchSubCategoriesByParent(parentCategory);
});
