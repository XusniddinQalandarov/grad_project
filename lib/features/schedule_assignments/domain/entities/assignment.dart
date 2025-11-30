import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'assignment.freezed.dart';
part 'assignment.g.dart';

class TimestampConverter implements JsonConverter<DateTime, dynamic> {
  const TimestampConverter();

  @override
  DateTime fromJson(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    } else if (value is String) {
      return DateTime.parse(value);
    } else if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    }
    throw ArgumentError('Invalid timestamp value: $value');
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

@freezed
class Assignment with _$Assignment {
  const factory Assignment({
    required String id,
    required String title,
    required String course,
    @TimestampConverter() required DateTime dueDate,
    @Default('medium') String priority,
    @Default(false) bool completed,
    String? description,
    String? userId,
  }) = _Assignment;

  factory Assignment.fromJson(Map<String, dynamic> json) =>
      _$AssignmentFromJson(json);
}
