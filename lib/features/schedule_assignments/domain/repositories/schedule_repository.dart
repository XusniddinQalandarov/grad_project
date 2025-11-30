import '../entities/class_session.dart';
import '../entities/assignment.dart';
import '../entities/course.dart';

abstract class ScheduleRepository {
  Stream<List<ClassSession>> getClassSessionsStream();
  Future<List<ClassSession>> getClassSessionsByDay(String dayOfWeek);
  Future<void> addClassSession(ClassSession session);
  Future<void> updateClassSession(ClassSession session);
  Future<void> deleteClassSession(String id);

  Stream<List<Assignment>> getAssignmentsStream();
  Future<List<Assignment>> getPendingAssignments();
  Future<void> addAssignment(Assignment assignment);
  Future<void> updateAssignment(Assignment assignment);
  Future<void> deleteAssignment(String id);

  Stream<List<Course>> getCoursesStream();
  Future<void> addCourse(Course course);
  Future<void> updateCourse(Course course);
  Future<void> deleteCourse(String id);
}
