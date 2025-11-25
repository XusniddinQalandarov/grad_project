import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

/// Firebase Storage service for uploading meal images
class StorageService {
  final FirebaseStorage _storage;

  StorageService(this._storage);

  /// Upload meal image and return download URL
  Future<String> uploadMealImage(File imageFile, String mealId) async {
    try {
      final ref = _storage.ref().child('meal_images/$mealId.jpg');
      final uploadTask = await ref.putFile(imageFile);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  /// Delete meal image
  Future<void> deleteMealImage(String mealId) async {
    try {
      final ref = _storage.ref().child('meal_images/$mealId.jpg');
      await ref.delete();
    } catch (e) {
      // Image might not exist, ignore error
    }
  }
}
