import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();
  final Uuid _uuid = const Uuid();

  // Get the images directory path
  Future<String> get _imagesDirectory async {
    final appDir = await getApplicationDocumentsDirectory();
    final imagesDir = Directory('${appDir.path}/product_images');
    
    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }
    
    return imagesDir.path;
  }

  // Pick image from gallery
  Future<File?> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );
    
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  // Pick image from camera
  Future<File?> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );
    
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  // Save image to local storage
  Future<String> saveImageLocally(File imageFile) async {
    final imagesDir = await _imagesDirectory;
    final extension = imageFile.path.split('.').last;
    final fileName = '${_uuid.v4()}.$extension';
    final savedPath = '$imagesDir/$fileName';
    
    await imageFile.copy(savedPath);
    
    return savedPath;
  }

  // Delete image from local storage
  Future<bool> deleteImage(String? imagePath) async {
    if (imagePath == null || imagePath.isEmpty) return true;
    
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  // Check if image exists
  Future<bool> imageExists(String? imagePath) async {
    if (imagePath == null || imagePath.isEmpty) return false;
    return await File(imagePath).exists();
  }

  // Get image file
  File? getImageFile(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) return null;
    final file = File(imagePath);
    return file.existsSync() ? file : null;
  }

  // Clean up unused images
  Future<void> cleanupUnusedImages(List<String> usedPaths) async {
    final imagesDir = await _imagesDirectory;
    final directory = Directory(imagesDir);
    
    if (!await directory.exists()) return;
    
    await for (final entity in directory.list()) {
      if (entity is File) {
        if (!usedPaths.contains(entity.path)) {
          await entity.delete();
        }
      }
    }
  }
}

// Riverpod Provider
final imageServiceProvider = Provider<ImageService>((ref) {
  return ImageService();
});
