// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassSessionImpl _$$ClassSessionImplFromJson(Map<String, dynamic> json) =>
    _$ClassSessionImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      room: json['room'] as String,
      time: json['time'] as String,
      dayOfWeek: json['dayOfWeek'] as String,
      instructor: json['instructor'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$ClassSessionImplToJson(_$ClassSessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'room': instance.room,
      'time': instance.time,
      'dayOfWeek': instance.dayOfWeek,
      'instructor': instance.instructor,
      'description': instance.description,
    };
