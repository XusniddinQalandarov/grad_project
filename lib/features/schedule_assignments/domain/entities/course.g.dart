// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseImpl _$$CourseImplFromJson(Map<String, dynamic> json) => _$CourseImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  credits: (json['credits'] as num).toInt(),
  grade: json['grade'] as String?,
  gradePoint: (json['gradePoint'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$CourseImplToJson(_$CourseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'credits': instance.credits,
      'grade': instance.grade,
      'gradePoint': instance.gradePoint,
    };
