import '../entities/menu_item.dart';
import '../repositories/canteen_repository.dart';

class GetMenuItemsByDateUseCase {
  final CanteenRepository _repository;

  GetMenuItemsByDateUseCase(this._repository);

  Future<List<MenuItem>> call(DateTime date) async {
    return await _repository.getMenuItemsByDate(date);
  }
}
