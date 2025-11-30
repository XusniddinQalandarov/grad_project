import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/class_session.dart';
import '../../domain/entities/assignment.dart';
import '../../domain/entities/course.dart';

class ScheduleFirestoreDataSource {
  final FirebaseFirestore _firestore;

  ScheduleFirestoreDataSource(this._firestore);

  Stream<List<ClassSession>> getClassSessionsStream() {
    print('🔌 Initializing Firestore stream for class_sessions collection');
    return _firestore
        .collection('class_sessions')
        .snapshots()
        .handleError((error) {
          print('❌ Firestore stream error: $error');
        })
        .map((snapshot) {
      print('🔥 Firestore snapshot received: ${snapshot.docs.length} documents');
      return snapshot.docs.map((doc) {
        try {
          final data = doc.data();
          data['id'] = doc.id;
          print('  Document ${doc.id}: ${data['name']} on ${data['dayOfWeek']}');
          return ClassSession.fromJson(data);
        } catch (e) {
          print('❌ Error parsing document ${doc.id}: $e');
          rethrow;
        }
      }).toList();
    });
  }

  Future<List<ClassSession>> getClassSessionsByDay(String dayOfWeek) async {
    final snapshot = await _firestore
        .collection('class_sessions')
        .where('dayOfWeek', isEqualTo: dayOfWeek)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return ClassSession.fromJson(data);
    }).toList();
  }

  Future<String> addClassSession(ClassSession session) async {
    final docRef = await _firestore.collection('class_sessions').add({
      'name': session.name,
      'room': session.room,
      'time': session.time,
      'dayOfWeek': session.dayOfWeek,
      'instructor': session.instructor,
      'description': session.description,
    });
    return docRef.id;
  }

  Future<void> updateClassSession(ClassSession session) async {
    await _firestore.collection('class_sessions').doc(session.id).update({
      'name': session.name,
      'room': session.room,
      'time': session.time,
      'dayOfWeek': session.dayOfWeek,
      'instructor': session.instructor,
      'description': session.description,
    });
  }

  Future<void> deleteClassSession(String id) async {
    await _firestore.collection('class_sessions').doc(id).delete();
  }

  Stream<List<Assignment>> getAssignmentsStream() {
    return _firestore
        .collection('assignments')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Assignment.fromJson(data);
      }).toList();
    });
  }

  Future<List<Assignment>> getPendingAssignments() async {
    final snapshot = await _firestore
        .collection('assignments')
        .where('completed', isEqualTo: false)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return Assignment.fromJson(data);
    }).toList();
  }

  Future<String> addAssignment(Assignment assignment) async {
    final docRef = await _firestore.collection('assignments').add({
      'title': assignment.title,
      'course': assignment.course,
      'dueDate': Timestamp.fromDate(assignment.dueDate),
      'priority': assignment.priority,
      'completed': assignment.completed,
      'description': assignment.description,
      'userId': assignment.userId,
    });
    return docRef.id;
  }

  Future<void> updateAssignment(Assignment assignment) async {
    await _firestore.collection('assignments').doc(assignment.id).update({
      'title': assignment.title,
      'course': assignment.course,
      'dueDate': Timestamp.fromDate(assignment.dueDate),
      'priority': assignment.priority,
      'completed': assignment.completed,
      'description': assignment.description,
    });
  }

  Future<void> deleteAssignment(String id) async {
    await _firestore.collection('assignments').doc(id).delete();
  }

  Stream<List<Course>> getCoursesStream() {
    return _firestore
        .collection('courses')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Course.fromJson(data);
      }).toList();
    });
  }

  Future<String> addCourse(Course course) async {
    final docRef = await _firestore.collection('courses').add({
      'name': course.name,
      'credits': course.credits,
      'grade': course.grade,
      'gradePoint': course.gradePoint,
    });
    return docRef.id;
  }

  Future<void> updateCourse(Course course) async {
    await _firestore.collection('courses').doc(course.id).update({
      'name': course.name,
      'credits': course.credits,
      'grade': course.grade,
      'gradePoint': course.gradePoint,
    });
  }

  Future<void> deleteCourse(String id) async {
    await _firestore.collection('courses').doc(id).delete();
  }
}
