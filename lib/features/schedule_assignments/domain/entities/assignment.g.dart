// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AssignmentImpl _$$AssignmentImplFromJson(Map<String, dynamic> json) =>
    _$AssignmentImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      course: json['course'] as String,
      dueDate: const TimestampConverter().fromJson(json['dueDate']),
      priority: json['priority'] as String? ?? 'medium',
      completed: json['completed'] as bool? ?? false,
      description: json['description'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$$AssignmentImplToJson(_$AssignmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'course': instance.course,
      'dueDate': const TimestampConverter().toJson(instance.dueDate),
      'priority': instance.priority,
      'completed': instance.completed,
      'description': instance.description,
      'userId': instance.userId,
    };
