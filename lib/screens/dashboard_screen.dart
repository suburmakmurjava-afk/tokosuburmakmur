import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../models/subcategory.dart';
import '../services/database_service.dart';
import '../theme/app_theme.dart';
import '../widgets/product_card.dart';
import '../widgets/category_chips.dart';
import '../widgets/subcategory_selector.dart';
import '../widgets/product_details_sheet.dart';
import 'product_form_screen.dart';
import 'subcategory_management_screen.dart';

// Provider for selected category filter
final selectedCategoryProvider = StateProvider<ProductCategory?>((ref) => null);

// Provider for selected subcategory filter
final selectedSubcategoryProvider = StateProvider<int?>((ref) => null);

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final selectedSubcategory = ref.watch(selectedSubcategoryProvider);
    
    // Use subcategory filter if selected, otherwise use category filter
    final productsAsync = selectedSubcategory != null
        ? ref.watch(productsBySubcategoryProvider(selectedSubcategory))
        : ref.watch(productsByCategoryProvider(selectedCategory));

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(context, ref),
            
            // Category Filter
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: CategoryChips(
                selectedCategory: selectedCategory,
                onCategorySelected: (category) {
                  ref.read(selectedCategoryProvider.notifier).state = category;
                  // Reset subcategory filter when category changes
                  ref.read(selectedSubcategoryProvider.notifier).state = null;
                },
              ),
            ),
            
            // Subcategory Filter (show only when a category is selected)
            if (selectedCategory != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SubcategoryChips(
                  parentCategory: selectedCategory,
                  selectedSubcategoryId: selectedSubcategory,
                  onSubcategorySelected: (subcategoryId) {
                    ref.read(selectedSubcategoryProvider.notifier).state = subcategoryId;
                  },
                ),
              ),
            
            // Product Grid
            Expanded(
              child: productsAsync.when(
                data: (products) => _buildProductGrid(context, ref, products),
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.primaryGreen,
                  ),
                ),
                error: (error, stack) => _buildErrorState(error),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFAB(context),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Logo / Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.primaryGreen, AppTheme.primaryGreenLight],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryGreen.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Text(
                  '🌾🐄',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              
              const SizedBox(width: 16),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Toko Subur Makmur',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryGreen,
                      ),
                    ),
                    Text(
                      'Katalog Pertanian & Peternakan',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Search Button
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.search_rounded),
                  color: AppTheme.primaryGreen,
                  onPressed: () => _showSearch(context),
                ),
              ),
              
              const SizedBox(width: 8),

              // Settings/Management Button
              PopupMenuButton<String>(
                icon: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.more_vert_rounded,
                    color: AppTheme.primaryGreen,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'manage_subcategories',
                    child: Row(
                      children: [
                        Icon(Icons.category_outlined, size: 20),
                        SizedBox(width: 12),
                        Text('Kelola Jenis Produk'),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'manage_subcategories') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SubcategoryManagementScreen(),
                      ),
                    );
                  } else if (value == 'search') {
                    _showSearch(context);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context, WidgetRef ref, List<Product> products) {
    if (products.isEmpty) {
      return _buildEmptyState(context);
    }

    return RefreshIndicator(
      color: AppTheme.primaryGreen,
      onRefresh: () async {
        // Refresh is handled automatically by Riverpod streams
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.72,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            product: product,
            onTap: () => ProductDetailsSheet.show(context, product),
            onLongPress: () => _showQuickActions(context, product),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: const Text(
              '📦',
              style: TextStyle(fontSize: 64),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Belum Ada Produk',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Mulai dengan menambahkan produk pertama',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => _navigateToAddProduct(context),
            icon: const Icon(Icons.add_rounded),
            label: const Text('Tambah Produk'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 64,
            color: AppTheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Terjadi Kesalahan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _navigateToAddProduct(context),
      icon: const Icon(Icons.add_rounded, size: 24),
      label: const Text('Tambah Produk'),
      elevation: 4,
      backgroundColor: AppTheme.primaryGreen,
    );
  }

  void _navigateToAddProduct(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProductFormScreen(),
      ),
    );
  }

  void _showSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: ProductSearchDelegate(),
    );
  }

  void _showQuickActions(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppTheme.surfaceLight,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.textSecondary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              product.name,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.visibility_outlined, color: AppTheme.primaryGreen),
              ),
              title: const Text('Lihat Detail'),
              onTap: () {
                Navigator.pop(context);
                ProductDetailsSheet.show(context, product);
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.edit_outlined, color: AppTheme.info),
              ),
              title: const Text('Edit Produk'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductFormScreen(product: product),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// Search Delegate
class ProductSearchDelegate extends SearchDelegate<Product?> {
  @override
  String get searchFieldLabel => 'Cari produk...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppTheme.backgroundLight,
        elevation: 0,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(color: AppTheme.textSecondary),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final productsAsync = ref.watch(productsStreamProvider);
        
        return productsAsync.when(
          data: (products) {
            final filtered = products
                .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
                .toList();
            
            if (filtered.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.search_off_rounded,
                      size: 64,
                      color: AppTheme.textSecondary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Tidak ditemukan "$query"',
                      style: const TextStyle(color: AppTheme.textSecondary),
                    ),
                  ],
                ),
              );
            }
            
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final product = filtered[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          product.category.icon,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    title: Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      '${product.category.displayName} · Stok: ${product.stock}',
                    ),
                    onTap: () {
                      close(context, product);
                      ProductDetailsSheet.show(context, product);
                    },
                  ),
                );
              },
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppTheme.primaryGreen),
          ),
          error: (e, s) => Center(child: Text('Error: $e')),
        );
      },
    );
  }
}
