import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_item.freezed.dart';
part 'menu_item.g.dart';

/// Domain entity for a canteen menu item
@freezed
class MenuItem with _$MenuItem {
  const factory MenuItem({
    required String id,
    required String name,
    required double price,
    required int calories,
    required List<String> tags,
    String? description,
    String? imageUrl,
    required DateTime availableDate,
    @Default([]) List<String> ingredients,
    @Default(0) int quantityAvailable,
    @Default(true) bool isAvailable,
  }) = _MenuItem;

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);
}
