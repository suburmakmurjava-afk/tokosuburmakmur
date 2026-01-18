import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../models/subcategory.dart';
import '../services/database_service.dart';
import '../theme/app_theme.dart';

/// Widget untuk memilih subcategory dalam form produk
class SubcategorySelector extends ConsumerWidget {
  final ProductCategory parentCategory;
  final int? selectedSubcategoryId;
  final ValueChanged<SubCategory?> onSubcategorySelected;

  const SubcategorySelector({
    super.key,
    required this.parentCategory,
    required this.selectedSubcategoryId,
    required this.onSubcategorySelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subcategoriesAsync = ref.watch(subCategoriesByParentProvider(parentCategory));

    return subcategoriesAsync.when(
      data: (subcategories) {
        if (subcategories.isEmpty) {
          return _buildEmptyState();
        }
        return _buildDropdown(context, subcategories);
      },
      loading: () => const _LoadingDropdown(),
      error: (error, stack) => _buildErrorState(error),
    );
  }

  Widget _buildDropdown(BuildContext context, List<SubCategory> subcategories) {
    final selectedSubcategory = subcategories
        .where((s) => s.id == selectedSubcategoryId)
        .firstOrNull;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryGreen.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<SubCategory>(
          value: selectedSubcategory,
          decoration: InputDecoration(
            prefixIcon: Container(
              margin: const EdgeInsets.only(left: 12, right: 8),
              child: Icon(
                Icons.category_outlined,
                color: AppTheme.primaryGreen,
              ),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          hint: const Text('Pilih jenis produk'),
          isExpanded: true,
          borderRadius: BorderRadius.circular(16),
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: subcategories.map((subcategory) {
            return DropdownMenuItem<SubCategory>(
              value: subcategory,
              child: Row(
                children: [
                  Text(subcategory.icon, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      subcategory.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: onSubcategorySelected,
          validator: (value) {
            if (value == null) {
              return 'Pilih jenis produk';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.warning.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: AppTheme.warning),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Belum ada jenis untuk ${parentCategory.displayName}',
              style: TextStyle(color: AppTheme.warning),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text('Error: $error', style: const TextStyle(color: AppTheme.error)),
    );
  }
}

class _LoadingDropdown extends StatelessWidget {
  const _LoadingDropdown();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryGreen.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppTheme.primaryGreen.withOpacity(0.5),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Memuat jenis produk...',
            style: TextStyle(color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }
}

/// Widget chips untuk filter subcategory di dashboard
class SubcategoryChips extends ConsumerWidget {
  final ProductCategory? parentCategory;
  final int? selectedSubcategoryId;
  final ValueChanged<int?> onSubcategorySelected;

  const SubcategoryChips({
    super.key,
    required this.parentCategory,
    required this.selectedSubcategoryId,
    required this.onSubcategorySelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (parentCategory == null) {
      return const SizedBox.shrink();
    }

    final subcategoriesAsync = ref.watch(subCategoriesByParentProvider(parentCategory!));

    return subcategoriesAsync.when(
      data: (subcategories) {
        if (subcategories.isEmpty) {
          return const SizedBox.shrink();
        }
        return _buildChips(subcategories);
      },
      loading: () => const SizedBox(height: 40),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildChips(List<SubCategory> subcategories) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildChip(
            label: 'Semua',
            icon: '📋',
            isSelected: selectedSubcategoryId == null,
            onTap: () => onSubcategorySelected(null),
          ),
          const SizedBox(width: 8),
          ...subcategories.map((subcategory) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _buildChip(
                label: subcategory.name,
                icon: subcategory.icon,
                isSelected: selectedSubcategoryId == subcategory.id,
                onTap: () => onSubcategorySelected(subcategory.id),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildChip({
    required String label,
    required String icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    AppTheme.primaryGreen.withOpacity(0.8),
                    AppTheme.primaryGreenLight,
                  ],
                )
              : null,
          color: isSelected ? null : AppTheme.surfaceLight,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : AppTheme.primaryGreen.withOpacity(0.2),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primaryGreen.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(icon, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
