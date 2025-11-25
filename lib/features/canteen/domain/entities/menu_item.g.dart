// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MenuItemImpl _$$MenuItemImplFromJson(Map<String, dynamic> json) =>
    _$MenuItemImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      calories: (json['calories'] as num).toInt(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      availableDate: DateTime.parse(json['availableDate'] as String),
      ingredients:
          (json['ingredients'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      quantityAvailable: (json['quantityAvailable'] as num?)?.toInt() ?? 0,
      isAvailable: json['isAvailable'] as bool? ?? true,
    );

Map<String, dynamic> _$$MenuItemImplToJson(_$MenuItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'calories': instance.calories,
      'tags': instance.tags,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'availableDate': instance.availableDate.toIso8601String(),
      'ingredients': instance.ingredients,
      'quantityAvailable': instance.quantityAvailable,
      'isAvailable': instance.isAvailable,
    };
