import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../models/subcategory.dart';
import '../services/database_service.dart';
import '../theme/app_theme.dart';

class SubcategoryManagementScreen extends ConsumerStatefulWidget {
  const SubcategoryManagementScreen({super.key});

  @override
  ConsumerState<SubcategoryManagementScreen> createState() => _SubcategoryManagementScreenState();
}

class _SubcategoryManagementScreenState extends ConsumerState<SubcategoryManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: _buildAppBar(),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _SubcategoryList(category: ProductCategory.agriculture),
          _SubcategoryList(category: ProductCategory.livestock),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddSubcategoryDialog(context),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Tambah Jenis'),
        backgroundColor: AppTheme.primaryGreen,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text('Kelola Jenis Produk'),
      bottom: TabBar(
        controller: _tabController,
        labelColor: AppTheme.primaryGreen,
        unselectedLabelColor: AppTheme.textSecondary,
        indicatorColor: AppTheme.primaryGreen,
        tabs: ProductCategory.values.map((category) {
          return Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(category.icon, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Text(category.displayName),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showAddSubcategoryDialog(BuildContext context) {
    final currentCategory = _tabController.index == 0
        ? ProductCategory.agriculture
        : ProductCategory.livestock;
    
    showDialog(
      context: context,
      builder: (context) => _SubcategoryDialog(
        parentCategory: currentCategory,
      ),
    );
  }
}

class _SubcategoryList extends ConsumerWidget {
  final ProductCategory category;

  const _SubcategoryList({required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subcategoriesAsync = ref.watch(subCategoriesByParentProvider(category));

    return subcategoriesAsync.when(
      data: (subcategories) {
        if (subcategories.isEmpty) {
          return _buildEmptyState(context);
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: subcategories.length,
          itemBuilder: (context, index) {
            final subcategory = subcategories[index];
            return _SubcategoryCard(subcategory: subcategory);
          },
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppTheme.primaryGreen),
      ),
      error: (error, stack) => Center(
        child: Text('Error: $error'),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Text(
              category.icon,
              style: const TextStyle(fontSize: 48),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Belum ada jenis ${category.displayName}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SubcategoryCard extends ConsumerWidget {
  final SubCategory subcategory;

  const _SubcategoryCard({required this.subcategory});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGreen.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              subcategory.icon,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
        title: Text(
          subcategory.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: subcategory.isDefault
            ? Row(
                children: [
                  Icon(
                    Icons.verified_rounded,
                    size: 14,
                    color: AppTheme.primaryGreen.withOpacity(0.7),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Bawaan',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.primaryGreen.withOpacity(0.7),
                    ),
                  ),
                ],
              )
            : null,
        trailing: subcategory.isDefault
            ? null
            : PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit_outlined, size: 20),
                        SizedBox(width: 12),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, size: 20, color: AppTheme.error),
                        SizedBox(width: 12),
                        Text('Hapus', style: TextStyle(color: AppTheme.error)),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'edit') {
                    _showEditDialog(context);
                  } else if (value == 'delete') {
                    _showDeleteConfirmation(context, ref);
                  }
                },
              ),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _SubcategoryDialog(
        parentCategory: subcategory.parentCategory,
        subcategory: subcategory,
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(Icons.warning_rounded, color: AppTheme.error),
            SizedBox(width: 12),
            Text('Hapus Jenis'),
          ],
        ),
        content: Text('Yakin ingin menghapus "${subcategory.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              final db = ref.read(databaseServiceProvider);
              await db.deleteSubCategory(subcategory.id);
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('"${subcategory.name}" telah dihapus'),
                    backgroundColor: AppTheme.primaryGreen,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.error,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}

class _SubcategoryDialog extends ConsumerStatefulWidget {
  final ProductCategory parentCategory;
  final SubCategory? subcategory;

  const _SubcategoryDialog({
    required this.parentCategory,
    this.subcategory,
  });

  @override
  ConsumerState<_SubcategoryDialog> createState() => _SubcategoryDialogState();
}

class _SubcategoryDialogState extends ConsumerState<_SubcategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _selectedIcon = '📦';
  bool _isLoading = false;

  bool get isEditing => widget.subcategory != null;

  // Daftar icon yang tersedia
  static const List<String> availableIcons = [
    '📦', '🌾', '🌿', '🍄', '🦗', '🐛', '🌱', '🫘', '🚜', '🔧', '🧪', '🐀', '🐌', '💧',
    '🐔', '🐄', '🐐', '🐟', '🐦', '💊', '💉', '🩺', '🏠', '🥣', '⚙️', '🐣', '🏥', '🧴', '🥚',
    '🌻', '🌽', '🍃', '🥬', '🍅', '🥕', '🧅', '🥔', '🐷', '🐑', '🐴', '🦆', '🐰', '🦃',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.subcategory != null) {
      _nameController.text = widget.subcategory!.name;
      _selectedIcon = widget.subcategory!.icon;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isEditing ? Icons.edit_rounded : Icons.add_rounded,
              color: AppTheme.primaryGreen,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Text(isEditing ? 'Edit Jenis' : 'Tambah Jenis Baru'),
        ],
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kategori induk
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.parentCategory.icon),
                  const SizedBox(width: 8),
                  Text(
                    widget.parentCategory.displayName,
                    style: TextStyle(
                      color: AppTheme.primaryGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Pilih Icon
            const Text(
              'Pilih Icon',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: AppTheme.backgroundLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.primaryGreen.withOpacity(0.2),
                ),
              ),
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemCount: availableIcons.length,
                itemBuilder: (context, index) {
                  final icon = availableIcons[index];
                  final isSelected = icon == _selectedIcon;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedIcon = icon),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.primaryGreen.withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: isSelected
                            ? Border.all(color: AppTheme.primaryGreen, width: 2)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          icon,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Nama Jenis
            const Text(
              'Nama Jenis',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: 'Contoh: Pupuk NPK',
                prefixIcon: Container(
                  margin: const EdgeInsets.only(left: 12, right: 8),
                  child: Text(_selectedIcon, style: const TextStyle(fontSize: 20)),
                ),
                prefixIconConstraints: const BoxConstraints(minWidth: 48),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama jenis harus diisi';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _save,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(isEditing ? 'Simpan' : 'Tambah'),
        ),
      ],
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final db = ref.read(databaseServiceProvider);
      
      if (isEditing) {
        final updated = widget.subcategory!.copyWith(
          name: _nameController.text.trim(),
          icon: _selectedIcon,
        );
        await db.updateSubCategory(updated);
      } else {
        final newSubcategory = SubCategory(
          name: _nameController.text.trim(),
          icon: _selectedIcon,
          parentCategory: widget.parentCategory,
          isDefault: false,
        );
        await db.addSubCategory(newSubcategory);
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEditing
                  ? 'Jenis berhasil diperbarui'
                  : 'Jenis baru berhasil ditambahkan',
            ),
            backgroundColor: AppTheme.success,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppTheme.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
