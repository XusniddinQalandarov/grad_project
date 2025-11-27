import '../entities/menu_item.dart';

abstract class CanteenRepository {
  Future<List<MenuItem>> getMenuItemsByDate(DateTime date);

  Future<List<MenuItem>> getMenuItemsForWeek(DateTime startDate);

  Future<List<MenuItem>> getMenuItemsByTags(List<String> tags);
}
