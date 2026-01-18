import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../models/subcategory.dart';
import '../services/database_service.dart';
import '../services/image_service.dart';
import '../theme/app_theme.dart';
import '../widgets/category_chips.dart';
import '../widgets/subcategory_selector.dart';
import '../widgets/stock_counter.dart';

class ProductFormScreen extends ConsumerStatefulWidget {
  final Product? product;

  const ProductFormScreen({super.key, this.product});

  @override
  ConsumerState<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends ConsumerState<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _retailPriceController = TextEditingController();
  final _wholesalePriceController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  ProductCategory _selectedCategory = ProductCategory.agriculture;
  int? _selectedSubcategoryId;
  int _stock = 0;
  File? _selectedImage;
  String? _existingImagePath;
  bool _isLoading = false;

  bool get isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _nameController.text = widget.product!.name;
      _retailPriceController.text = widget.product!.priceRetail.toStringAsFixed(0);
      _wholesalePriceController.text = widget.product!.priceWholesale.toStringAsFixed(0);
      _purchasePriceController.text = widget.product!.pricePurchase.toStringAsFixed(0);
      _descriptionController.text = widget.product!.description ?? '';
      _selectedCategory = widget.product!.category;
      _selectedSubcategoryId = widget.product!.subcategoryId;
      _stock = widget.product!.stock;
      _existingImagePath = widget.product!.imagePath;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _retailPriceController.dispose();
    _wholesalePriceController.dispose();
    _purchasePriceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // Form Content
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Picker
                  _buildImagePicker(),
                  
                  const SizedBox(height: 28),
                  
                  // Name Field
                  _buildSectionLabel('Nama Produk'),
                  const SizedBox(height: 8),
                  _buildNameField(),
                  
                  const SizedBox(height: 24),
                  
                  // Category Toggle
                  _buildSectionLabel('Kategori'),
                  const SizedBox(height: 12),
                  CategoryToggle(
                    selectedCategory: _selectedCategory,
                    onCategoryChanged: (category) {
                      setState(() {
                        _selectedCategory = category;
                        // Reset subcategory saat kategori berubah
                        _selectedSubcategoryId = null;
                      });
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Subcategory Selector
                  _buildSectionLabel('Jenis Produk'),
                  const SizedBox(height: 8),
                  SubcategorySelector(
                    parentCategory: _selectedCategory,
                    selectedSubcategoryId: _selectedSubcategoryId,
                    onSubcategorySelected: (subcategory) {
                      setState(() {
                        _selectedSubcategoryId = subcategory?.id;
                      });
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Price Fields
                  _buildSectionLabel('Harga (Rp)'),
                  const SizedBox(height: 12),
                  _buildPriceField(
                    controller: _purchasePriceController,
                    label: 'Harga Beli (Suplayer)',
                    icon: Icons.monetization_on_outlined,
                  ),
                  const SizedBox(height: 12),
                  _buildPriceField(
                    controller: _wholesalePriceController,
                    label: 'Harga Tengkulak',
                    icon: Icons.storefront_outlined,
                  ),
                  const SizedBox(height: 12),
                  _buildPriceField(
                    controller: _retailPriceController,
                    label: 'Harga Eceran',
                    icon: Icons.shopping_bag_outlined,
                  ),
                  
                  const SizedBox(height: 28),
                  
                  // Stock Counter
                  _buildSectionLabel('Jumlah Stok'),
                  const SizedBox(height: 12),
                  Center(
                    child: StockCounter(
                      value: _stock,
                      onChanged: (value) => setState(() => _stock = value),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Description Field
                  _buildSectionLabel('Deskripsi (Opsional)'),
                  const SizedBox(height: 8),
                  _buildDescriptionField(),
                  
                  const SizedBox(height: 32),
                  
                  // Save Button
                  _buildSaveButton(),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          
          // Loading Overlay
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppTheme.primaryGreen,
                ),
              ),
            ),
        ],
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
      title: Text(isEditing ? 'Edit Produk' : 'Tambah Produk'),
      actions: [
        if (isEditing)
          TextButton(
            onPressed: _showDeleteConfirmation,
            child: const Text(
              'Hapus',
              style: TextStyle(color: AppTheme.error),
            ),
          ),
      ],
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppTheme.textPrimary,
      ),
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _showImagePickerOptions,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.surfaceLight,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppTheme.primaryGreen.withOpacity(0.2),
            width: 2,
            style: BorderStyle.solid,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryGreen.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: _buildImageContent(),
      ),
    );
  }

  Widget _buildImageContent() {
    // Show selected image
    if (_selectedImage != null) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.file(_selectedImage!, fit: BoxFit.cover),
          _buildImageOverlay(),
        ],
      );
    }
    
    // Show existing image (when editing)
    if (_existingImagePath != null && _existingImagePath!.isNotEmpty) {
      final file = File(_existingImagePath!);
      if (file.existsSync()) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Image.file(file, fit: BoxFit.cover),
            _buildImageOverlay(),
          ],
        );
      }
    }
    
    // Show placeholder
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.add_photo_alternate_outlined,
            size: 40,
            color: AppTheme.primaryGreen,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Ketuk untuk tambah foto produk',
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Kamera atau Galeri',
          style: TextStyle(
            color: AppTheme.textSecondary.withOpacity(0.6),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildImageOverlay() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.transparent,
            ],
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text(
              'Ketuk untuk ganti foto',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        hintText: 'Masukkan nama produk',
        prefixIcon: Container(
          margin: const EdgeInsets.only(left: 12, right: 8),
          child: const Icon(Icons.inventory_2_outlined, color: AppTheme.primaryGreen),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Nama produk harus diisi';
        }
        return null;
      },
    );
  }

  Widget _buildPriceField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        hintText: '0',
        prefixIcon: Container(
          margin: const EdgeInsets.only(left: 12, right: 8),
          child: Icon(icon, color: AppTheme.primaryGreen),
        ),
        prefixText: 'Rp ',
        prefixStyle: const TextStyle(
          color: AppTheme.primaryGreen,
          fontWeight: FontWeight.w600,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Harga harus diisi';
        }
        final price = double.tryParse(value.replaceAll(RegExp(r'[^0-9.]'), ''));
        if (price == null || price < 0) {
          return 'Masukkan harga yang valid';
        }
        return null;
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      maxLines: 4,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: 'Masukkan deskripsi produk...',
        alignLabelWithHint: true,
        contentPadding: const EdgeInsets.all(20),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _saveProduct,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isEditing ? Icons.save_rounded : Icons.add_rounded),
            const SizedBox(width: 8),
            Text(
              isEditing ? 'Simpan Perubahan' : 'Tambah Produk',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImagePickerOptions() {
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
              'Tambah Foto',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildImageOption(
                    icon: Icons.camera_alt_rounded,
                    label: 'Kamera',
                    onTap: () {
                      Navigator.pop(context);
                      _pickImage(fromCamera: true);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildImageOption(
                    icon: Icons.photo_library_rounded,
                    label: 'Galeri',
                    onTap: () {
                      Navigator.pop(context);
                      _pickImage(fromCamera: false);
                    },
                  ),
                ),
              ],
            ),
            if (_selectedImage != null || _existingImagePath != null) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedImage = null;
                      _existingImagePath = null;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.error,
                    side: const BorderSide(color: AppTheme.error),
                  ),
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Hapus Foto'),
                ),
              ),
            ],
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildImageOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: AppTheme.primaryGreen.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.primaryGreen.withOpacity(0.2),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: AppTheme.primaryGreen),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage({required bool fromCamera}) async {
    final imageService = ref.read(imageServiceProvider);
    final file = fromCamera
        ? await imageService.pickImageFromCamera()
        : await imageService.pickImageFromGallery();
    
    if (file != null) {
      setState(() => _selectedImage = file);
    }
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;
    
    // Validasi subcategory
    if (_selectedSubcategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Pilih jenis produk terlebih dahulu'),
          backgroundColor: AppTheme.warning,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }
    
    setState(() => _isLoading = true);
    
    try {
      final db = ref.read(databaseServiceProvider);
      final imageService = ref.read(imageServiceProvider);
      
      String? imagePath = _existingImagePath;
      
      // Save new image if selected
      if (_selectedImage != null) {
        // Delete old image if exists
        if (_existingImagePath != null) {
          await imageService.deleteImage(_existingImagePath);
        }
        imagePath = await imageService.saveImageLocally(_selectedImage!);
      }
      
      final priceRetail = double.parse(
        _retailPriceController.text.replaceAll(RegExp(r'[^0-9.]'), '')
      );
      final priceWholesale = double.parse(
        _wholesalePriceController.text.replaceAll(RegExp(r'[^0-9.]'), '')
      );
      final pricePurchase = double.parse(
        _purchasePriceController.text.replaceAll(RegExp(r'[^0-9.]'), '')
      );
      
      if (isEditing) {
        // Update existing product
        final updatedProduct = widget.product!.copyWith(
          name: _nameController.text.trim(),
          category: _selectedCategory,
          subcategoryId: _selectedSubcategoryId,
          priceRetail: priceRetail,
          priceWholesale: priceWholesale,
          pricePurchase: pricePurchase,
          stock: _stock,
          imagePath: imagePath,
          description: _descriptionController.text.trim(),
        );
        await db.updateProduct(updatedProduct);
      } else {
        // Create new product
        final newProduct = Product(
          name: _nameController.text.trim(),
          category: _selectedCategory,
          subcategoryId: _selectedSubcategoryId,
          priceRetail: priceRetail,
          priceWholesale: priceWholesale,
          pricePurchase: pricePurchase,
          stock: _stock,
          imagePath: imagePath,
          description: _descriptionController.text.trim(),
        );
        await db.addProduct(newProduct);
      }
      
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEditing ? 'Produk berhasil diperbarui' : 'Produk berhasil ditambahkan',
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
            content: Text('Error: ${e.toString()}'),
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

  Future<void> _showDeleteConfirmation() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(Icons.warning_rounded, color: AppTheme.error),
            SizedBox(width: 12),
            Text('Hapus Produk'),
          ],
        ),
        content: Text(
          'Yakin ingin menghapus "${widget.product!.name}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.error,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    
    if (confirmed == true && mounted) {
      setState(() => _isLoading = true);
      
      final db = ref.read(databaseServiceProvider);
      final imageService = ref.read(imageServiceProvider);
      
      if (widget.product!.imagePath != null) {
        await imageService.deleteImage(widget.product!.imagePath);
      }
      
      await db.deleteProduct(widget.product!.id);
      
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Produk berhasil dihapus'),
            backgroundColor: AppTheme.primaryGreen,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }
}
