import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/menu_item.dart';

part 'canteen_state.freezed.dart';

/// State for canteen feature
@freezed
class CanteenState with _$CanteenState {
  const factory CanteenState({
    @Default([]) List<MenuItem> menuItems,
    @Default([]) List<String> selectedTags,
    @Default(true) bool isLoading,
    String? errorMessage,
    required DateTime selectedDate,
  }) = _CanteenState;
}
