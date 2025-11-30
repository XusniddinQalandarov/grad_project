import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/class_session.dart';
import '../../domain/entities/assignment.dart';
import '../../domain/entities/course.dart';

part 'schedule_state.freezed.dart';

@freezed
class ScheduleState with _$ScheduleState {
  const factory ScheduleState({
    @Default([]) List<ClassSession> classSessions,
    @Default([]) List<Assignment> assignments,
    @Default([]) List<Course> courses,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _ScheduleState;
}
