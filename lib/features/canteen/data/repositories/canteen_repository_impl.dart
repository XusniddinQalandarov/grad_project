import '../../domain/entities/menu_item.dart';
import '../../domain/repositories/canteen_repository.dart';
import '../datasources/canteen_firestore_datasource.dart';

class CanteenRepositoryImpl implements CanteenRepository {
  final CanteenFirestoreDataSource _firestoreDataSource;

  CanteenRepositoryImpl(this._firestoreDataSource);

  @override
  Future<List<MenuItem>> getMenuItemsByDate(DateTime date) async {
    return await _firestoreDataSource.getMenuItemsByDate(date);
  }

  @override
  Future<List<MenuItem>> getMenuItemsForWeek(DateTime startDate) async {
    final List<MenuItem> allItems = [];
    for (int i = 0; i < 7; i++) {
      final date = startDate.add(Duration(days: i));
      final items = await _firestoreDataSource.getMenuItemsByDate(date);
      allItems.addAll(items);
    }
    return allItems;
  }

  @override
  Future<List<MenuItem>> getMenuItemsByTags(List<String> tags) async {
    final snapshot = await _firestoreDataSource.getMenuItemsStream().first;
    return snapshot
        .where((item) => item.tags.any((tag) => tags.contains(tag)))
        .toList();
  }
}
