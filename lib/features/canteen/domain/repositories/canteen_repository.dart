import '../entities/menu_item.dart';

/// Abstract repository for canteen menu operations
abstract class CanteenRepository {
  /// Fetches menu items for a specific date
  Future<List<MenuItem>> getMenuItemsByDate(DateTime date);

  /// Fetches menu items for a date range
  Future<List<MenuItem>> getMenuItemsForWeek(DateTime startDate);

  /// Fetches menu items filtered by tags
  Future<List<MenuItem>> getMenuItemsByTags(List<String> tags);
}
