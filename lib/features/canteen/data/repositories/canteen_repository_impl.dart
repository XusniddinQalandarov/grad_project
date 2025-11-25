import '../../domain/entities/menu_item.dart';
import '../../domain/repositories/canteen_repository.dart';
import '../datasources/canteen_local_datasource.dart';

/// Implementation of CanteenRepository
class CanteenRepositoryImpl implements CanteenRepository {
  final CanteenLocalDataSource _localDataSource;

  CanteenRepositoryImpl(this._localDataSource);

  @override
  Future<List<MenuItem>> getMenuItemsByDate(DateTime date) async {
    return await _localDataSource.getMenuItemsByDate(date);
  }

  @override
  Future<List<MenuItem>> getMenuItemsForWeek(DateTime startDate) async {
    return await _localDataSource.getMenuItemsForWeek(startDate);
  }

  @override
  Future<List<MenuItem>> getMenuItemsByTags(List<String> tags) async {
    return await _localDataSource.getMenuItemsByTags(tags);
  }
}
