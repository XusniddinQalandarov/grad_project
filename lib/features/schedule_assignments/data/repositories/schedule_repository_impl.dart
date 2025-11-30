import '../../domain/repositories/schedule_repository.dart';
import '../../domain/entities/class_session.dart';
import '../../domain/entities/assignment.dart';
import '../../domain/entities/course.dart';
import '../datasources/schedule_firestore_datasource.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleFirestoreDataSource _dataSource;

  const ScheduleRepositoryImpl(this._dataSource);

  @override
  Stream<List<ClassSession>> getClassSessionsStream() {
    return _dataSource.getClassSessionsStream();
  }

  @override
  Future<List<ClassSession>> getClassSessionsByDay(String dayOfWeek) async {
    try {
      return await _dataSource.getClassSessionsByDay(dayOfWeek);
    } catch (e) {
      throw Exception('Failed to load class sessions: $e');
    }
  }

  @override
  Future<void> addClassSession(ClassSession session) async {
    try {
      await _dataSource.addClassSession(session);
    } catch (e) {
      throw Exception('Failed to add class session: $e');
    }
  }

  @override
  Future<void> updateClassSession(ClassSession session) async {
    try {
      await _dataSource.updateClassSession(session);
    } catch (e) {
      throw Exception('Failed to update class session: $e');
    }
  }

  @override
  Future<void> deleteClassSession(String id) async {
    try {
      await _dataSource.deleteClassSession(id);
    } catch (e) {
      throw Exception('Failed to delete class session: $e');
    }
  }

  @override
  Stream<List<Assignment>> getAssignmentsStream() {
    return _dataSource.getAssignmentsStream();
  }

  @override
  Future<List<Assignment>> getPendingAssignments() async {
    try {
      return await _dataSource.getPendingAssignments();
    } catch (e) {
      throw Exception('Failed to load assignments: $e');
    }
  }

  @override
  Future<void> addAssignment(Assignment assignment) async {
    try {
      await _dataSource.addAssignment(assignment);
    } catch (e) {
      throw Exception('Failed to add assignment: $e');
    }
  }

  @override
  Future<void> updateAssignment(Assignment assignment) async {
    try {
      await _dataSource.updateAssignment(assignment);
    } catch (e) {
      throw Exception('Failed to update assignment: $e');
    }
  }

  @override
  Future<void> deleteAssignment(String id) async {
    try {
      await _dataSource.deleteAssignment(id);
    } catch (e) {
      throw Exception('Failed to delete assignment: $e');
    }
  }

  @override
  Stream<List<Course>> getCoursesStream() {
    return _dataSource.getCoursesStream();
  }

  @override
  Future<void> addCourse(Course course) async {
    try {
      await _dataSource.addCourse(course);
    } catch (e) {
      throw Exception('Failed to add course: $e');
    }
  }

  @override
  Future<void> updateCourse(Course course) async {
    try {
      await _dataSource.updateCourse(course);
    } catch (e) {
      throw Exception('Failed to update course: $e');
    }
  }

  @override
  Future<void> deleteCourse(String id) async {
    try {
      await _dataSource.deleteCourse(id);
    } catch (e) {
      throw Exception('Failed to delete course: $e');
    }
  }
}
