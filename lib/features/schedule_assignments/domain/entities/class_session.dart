import 'package:freezed_annotation/freezed_annotation.dart';

part 'class_session.freezed.dart';
part 'class_session.g.dart';

@freezed
class ClassSession with _$ClassSession {
  const factory ClassSession({
    required String id,
    required String name,
    required String room,
    required String time,
    required String dayOfWeek,
    String? instructor,
    String? description,
  }) = _ClassSession;

  factory ClassSession.fromJson(Map<String, dynamic> json) =>
      _$ClassSessionFromJson(json);
}
