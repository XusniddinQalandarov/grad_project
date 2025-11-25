import '../entities/menu_item.dart';
import '../repositories/canteen_repository.dart';

/// Use case for fetching menu items for a week
class GetMenuItemsForWeekUseCase {
  final CanteenRepository _repository;

  GetMenuItemsForWeekUseCase(this._repository);

  Future<List<MenuItem>> call(DateTime startDate) async {
    return await _repository.getMenuItemsForWeek(startDate);
  }
}
