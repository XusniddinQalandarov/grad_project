import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/menu_item.dart';
import '../../domain/usecases/get_menu_items_by_date_usecase.dart';
import '../../data/providers/canteen_repository_provider.dart';
import '../state/canteen_state.dart';

final getMenuItemsByDateUseCaseProvider = Provider((ref) {
  final repository = ref.watch(canteenRepositoryProvider);
  return GetMenuItemsByDateUseCase(repository);
});

class CanteenNotifier extends StateNotifier<CanteenState> {
  final GetMenuItemsByDateUseCase _getMenuItemsByDateUseCase;

  CanteenNotifier(this._getMenuItemsByDateUseCase)
      : super(CanteenState(selectedDate: DateTime.now())) {
    loadMenuItems();
  }

  Future<void> loadMenuItems() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      final items = await _getMenuItemsByDateUseCase(state.selectedDate);
      state = state.copyWith(
        menuItems: items,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load menu items: ${e.toString()}',
      );
    }
  }

  Future<void> changeDate(DateTime newDate) async {
    state = state.copyWith(selectedDate: newDate);
    await loadMenuItems();
  }

  void toggleTag(String tag) {
    final currentTags = List<String>.from(state.selectedTags);
    if (currentTags.contains(tag)) {
      currentTags.remove(tag);
    } else {
      currentTags.add(tag);
    }
    state = state.copyWith(selectedTags: currentTags);
  }

  void clearTags() {
    state = state.copyWith(selectedTags: []);
  }

  List<MenuItem> get filteredMenuItems {
    if (state.selectedTags.isEmpty) {
      return state.menuItems;
    }
    return state.menuItems
        .where((item) => item.tags.any((tag) => state.selectedTags.contains(tag)))
        .toList();
  }
}

final canteenNotifierProvider =
    StateNotifierProvider<CanteenNotifier, CanteenState>((ref) {
  final useCase = ref.watch(getMenuItemsByDateUseCaseProvider);
  return CanteenNotifier(useCase);
});

final filteredMenuItemsProvider = Provider((ref) {
  final notifier = ref.watch(canteenNotifierProvider.notifier);
  ref.watch(canteenNotifierProvider);
  return notifier.filteredMenuItems;
});
