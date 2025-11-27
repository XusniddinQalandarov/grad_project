import '../entities/menu_item.dart';
import '../repositories/canteen_repository.dart';

class GetMenuItemsForWeekUseCase {
  final CanteenRepository _repository;

  GetMenuItemsForWeekUseCase(this._repository);

  Future<List<MenuItem>> call(DateTime startDate) async {
    return await _repository.getMenuItemsForWeek(startDate);
  }
}
