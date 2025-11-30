import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../../domain/repositories/schedule_repository.dart';
import '../../domain/entities/class_session.dart';
import '../../domain/entities/assignment.dart';
import '../../domain/entities/course.dart';
import '../../data/providers/schedule_repository_provider.dart';
import '../state/schedule_state.dart';

class ScheduleNotifier extends StateNotifier<ScheduleState> {
  ScheduleNotifier(this._repository) : super(const ScheduleState()) {
    print('🚀 ScheduleNotifier initialized');
    _init();
  }

  final ScheduleRepository _repository;
  StreamSubscription<List<ClassSession>>? _classSessionsSubscription;
  StreamSubscription<List<Assignment>>? _assignmentsSubscription;
  StreamSubscription<List<Course>>? _coursesSubscription;

  void _init() {
    print('🔧 Initializing Firestore streams...');
    _classSessionsSubscription = _repository.getClassSessionsStream().listen(
      (sessions) {
        print('📚 Received ${sessions.length} class sessions from Firestore');
        for (var session in sessions) {
          print('  - ${session.name} on ${session.dayOfWeek} at ${session.time}');
        }
        state = state.copyWith(classSessions: sessions);
      },
      onError: (error) {
        print('❌ Error in class sessions stream: $error');
        state = state.copyWith(errorMessage: error.toString());
      },
    );

    _assignmentsSubscription = _repository.getAssignmentsStream().listen(
      (assignments) {
        print('📝 Received ${assignments.length} assignments from Firestore');
        state = state.copyWith(assignments: assignments);
      },
      onError: (error) {
        print('❌ Error in assignments stream: $error');
      },
    );

    _coursesSubscription = _repository.getCoursesStream().listen(
      (courses) {
        print('📖 Received ${courses.length} courses from Firestore');
        state = state.copyWith(courses: courses);
      },
      onError: (error) {
        print('❌ Error in courses stream: $error');
      },
    );
  }

  @override
  void dispose() {
    _classSessionsSubscription?.cancel();
    _assignmentsSubscription?.cancel();
    _coursesSubscription?.cancel();
    super.dispose();
  }

  Future<void> addClassSession(ClassSession session) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      print('➕ Adding class session: ${session.name} on ${session.dayOfWeek}');
      await _repository.addClassSession(session);
      print('✅ Class session added successfully');
      state = state.copyWith(isLoading: false);
    } catch (e) {
      print('❌ Error adding class session: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> updateClassSession(ClassSession session) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.updateClassSession(session);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> deleteClassSession(String id) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.deleteClassSession(id);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> addAssignment(Assignment assignment) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.addAssignment(assignment);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> updateAssignment(Assignment assignment) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.updateAssignment(assignment);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> deleteAssignment(String id) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.deleteAssignment(id);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> addCourse(Course course) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.addCourse(course);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> updateCourse(Course course) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.updateCourse(course);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> deleteCourse(String id) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.deleteCourse(id);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  double calculateGPA() {
    if (state.courses.isEmpty) return 0.0;

    double totalPoints = 0.0;
    int totalCredits = 0;

    for (final course in state.courses) {
      if (course.gradePoint != null) {
        totalPoints += course.gradePoint! * course.credits;
        totalCredits += course.credits;
      }
    }

    return totalCredits > 0 ? totalPoints / totalCredits : 0.0;
  }
}

final scheduleNotifierProvider =
    StateNotifierProvider<ScheduleNotifier, ScheduleState>((ref) {
  final repository = ref.watch(scheduleRepositoryProvider);
  return ScheduleNotifier(repository);
});

final todayClassSessionsProvider = Provider<List<ClassSession>>((ref) {
  final state = ref.watch(scheduleNotifierProvider);
  final now = DateTime.now();
  final dayOfWeek = _getDayOfWeek(now.weekday);
  
  return state.classSessions
      .where((session) => session.dayOfWeek == dayOfWeek)
      .toList();
});

final pendingAssignmentsProvider = Provider<List<Assignment>>((ref) {
  final state = ref.watch(scheduleNotifierProvider);
  return state.assignments
      .where((assignment) => !assignment.completed)
      .toList();
});

final gpaProvider = Provider<double>((ref) {
  final notifier = ref.watch(scheduleNotifierProvider.notifier);
  return notifier.calculateGPA();
});

String _getDayOfWeek(int weekday) {
  switch (weekday) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wednesday';
    case 4:
      return 'Thursday';
    case 5:
      return 'Friday';
    case 6:
      return 'Saturday';
    case 7:
      return 'Sunday';
    default:
      return 'Monday';
  }
}
