import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/menu_item.dart';

/// Firebase Firestore data source for menu items
class CanteenFirestoreDataSource {
  final FirebaseFirestore _firestore;
  static const String _collection = 'menu_items';

  CanteenFirestoreDataSource(this._firestore);

  /// Get all menu items
  Stream<List<MenuItem>> getMenuItemsStream() {
    return _firestore
        .collection(_collection)
        .orderBy('availableDate', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return MenuItem.fromJson(data);
      }).toList();
    });
  }

  /// Get menu items for a specific date
  Future<List<MenuItem>> getMenuItemsByDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final snapshot = await _firestore
        .collection(_collection)
        .where('availableDate', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('availableDate', isLessThan: Timestamp.fromDate(endOfDay))
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return MenuItem.fromJson(data);
    }).toList();
  }

  /// Add new menu item
  Future<String> addMenuItem(MenuItem item) async {
    final docRef = await _firestore.collection(_collection).add({
      'name': item.name,
      'price': item.price,
      'calories': item.calories,
      'tags': item.tags,
      'description': item.description,
      'imageUrl': item.imageUrl,
      'availableDate': Timestamp.fromDate(item.availableDate),
      'ingredients': item.ingredients,
      'quantityAvailable': item.quantityAvailable,
      'isAvailable': item.isAvailable,
    });
    return docRef.id;
  }

  /// Update menu item
  Future<void> updateMenuItem(MenuItem item) async {
    await _firestore.collection(_collection).doc(item.id).update({
      'name': item.name,
      'price': item.price,
      'calories': item.calories,
      'tags': item.tags,
      'description': item.description,
      'imageUrl': item.imageUrl,
      'availableDate': Timestamp.fromDate(item.availableDate),
      'ingredients': item.ingredients,
      'quantityAvailable': item.quantityAvailable,
      'isAvailable': item.isAvailable,
    });
  }

  /// Delete menu item
  Future<void> deleteMenuItem(String id) async {
    await _firestore.collection(_collection).doc(id).delete();
  }

  /// Update quantity
  Future<void> updateQuantity(String id, int quantity) async {
    await _firestore.collection(_collection).doc(id).update({
      'quantityAvailable': quantity,
      'isAvailable': quantity > 0,
    });
  }
}
