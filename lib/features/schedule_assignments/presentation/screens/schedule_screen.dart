import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/loaders.dart';
import '../../domain/entities/class_session.dart';
import '../../domain/entities/assignment.dart';
import '../../domain/entities/course.dart';
import '../providers/schedule_provider.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({super.key});

  @override
  ConsumerState<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule & Academics'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Schedule', icon: Icon(Icons.calendar_today)),
            Tab(text: 'Assignments', icon: Icon(Icons.assignment)),
            Tab(text: 'GPA', icon: Icon(Icons.bar_chart)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _ScheduleTab(),
          _AssignmentsTab(),
          _GpaTab(),
        ],
      ),
    );
  }
}

class _ScheduleTab extends ConsumerStatefulWidget {
  const _ScheduleTab();

  @override
  ConsumerState<_ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends ConsumerState<_ScheduleTab> {
  String selectedDay = _getTodayDayOfWeek();

  static String _getTodayDayOfWeek() {
    final now = DateTime.now();
    switch (now.weekday) {
      case 1: return 'Monday';
      case 2: return 'Tuesday';
      case 3: return 'Wednesday';
      case 4: return 'Thursday';
      case 5: return 'Friday';
      case 6: return 'Saturday';
      case 7: return 'Sunday';
      default: return 'Monday';
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scheduleNotifierProvider);
    final classSessions = state.classSessions
        .where((session) => session.dayOfWeek == selectedDay)
        .toList();

    if (state.isLoading && state.classSessions.isEmpty) {
      return const AppLoader();
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
                  .map((day) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(day.substring(0, 3)),
                          selected: selectedDay == day,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() => selectedDay = day);
                            }
                          },
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        Expanded(
          child: classSessions.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.event_busy, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text('No classes scheduled for $selectedDay.'),
                      const SizedBox(height: 16),
                      AppButton.primary(
                        text: 'Add Class',
                        icon: Icons.add,
                        onPressed: () => _showAddClassDialog(context, ref, selectedDay),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: classSessions.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '$selectedDay Classes',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            AppButton.text(
                              text: 'Add',
                              icon: Icons.add,
                              onPressed: () => _showAddClassDialog(context, ref, selectedDay),
                            ),
                          ],
                        ),
                      );
                    }

                    final session = classSessions[index - 1];
                    return _ClassListItem(session: session);
                  },
                ),
        ),
      ],
    );
  }

  void _showAddClassDialog(BuildContext context, WidgetRef ref, String defaultDay) {
    final nameController = TextEditingController();
    final roomController = TextEditingController();
    final timeController = TextEditingController();
    final instructorController = TextEditingController();
    String selectedDay = defaultDay;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add Class Session'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Class Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: roomController,
                    decoration: const InputDecoration(
                      labelText: 'Room',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: timeController,
                    decoration: const InputDecoration(
                      labelText: 'Time (e.g., 9:00 AM)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: instructorController,
                    decoration: const InputDecoration(
                      labelText: 'Instructor (Optional)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: selectedDay,
                    decoration: const InputDecoration(
                      labelText: 'Day of Week',
                      border: OutlineInputBorder(),
                    ),
                    items: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
                        .map((day) => DropdownMenuItem(value: day, child: Text(day)))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => selectedDay = value);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final room = roomController.text.trim();
                final time = timeController.text.trim();

                if (name.isEmpty || room.isEmpty || time.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in all required fields'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                  return;
                }

                Navigator.pop(ctx);

                final session = ClassSession(
                  id: const Uuid().v4(),
                  name: name,
                  room: room,
                  time: time,
                  dayOfWeek: selectedDay,
                  instructor: instructorController.text.trim().isEmpty
                      ? null
                      : instructorController.text.trim(),
                );

                try {
                  await ref.read(scheduleNotifierProvider.notifier).addClassSession(session);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Class added successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: $e'),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 5),
                      ),
                    );
                  }
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AssignmentsTab extends ConsumerWidget {
  const _AssignmentsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignments = ref.watch(pendingAssignmentsProvider);
    final state = ref.watch(scheduleNotifierProvider);

    if (state.isLoading && assignments.isEmpty) {
      return const AppLoader();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: assignments.isEmpty ? 2 : assignments.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pending Assignments',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                AppButton.text(
                  text: 'Add New',
                  icon: Icons.add,
                  onPressed: () => _showAddEditAssignment(context, ref),
                ),
              ],
            ),
          );
        }

        if (assignments.isEmpty) {
          return const Padding(
            padding: EdgeInsets.only(top: 24.0),
            child: Center(child: Text('No pending assignments.')),
          );
        }

        final assignment = assignments[index - 1];

        return Dismissible(
          key: ValueKey(assignment.id),
          background: Container(
            color: Colors.green,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            child: const Icon(Icons.check, color: Colors.white),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          confirmDismiss: (dir) async {
            if (dir == DismissDirection.endToStart) {
              final confirmed = await _confirmDelete(context, assignment);
              if (confirmed == true) {
                ref.read(scheduleNotifierProvider.notifier).deleteAssignment(assignment.id);
              }
              return confirmed;
            } else {
              final updated = assignment.copyWith(completed: true);
              ref.read(scheduleNotifierProvider.notifier).updateAssignment(updated);
              return false;
            }
          },
          child: _AssignmentCard(
            assignment: assignment,
            onEdit: () => _showAddEditAssignment(context, ref, editing: assignment),
            priorityColor: _getPriorityColor(assignment.priority),
          ),
        );
      },
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Future<bool?> _confirmDelete(BuildContext context, Assignment assignment) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete assignment'),
        content: Text('Delete "${assignment.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showAddEditAssignment(BuildContext context, WidgetRef ref, {Assignment? editing}) {
    final state = ref.read(scheduleNotifierProvider);
    final courses = state.classSessions.map((s) => s.name).toSet().toList();
    
    if (courses.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add classes first before creating assignments')),
      );
      return;
    }

    final isEditing = editing != null;
    final titleController = TextEditingController(text: editing?.title ?? '');
    String selectedCourse = editing?.course ?? courses.first;
    DateTime dueDate = editing?.dueDate ?? DateTime.now().add(const Duration(days: 1));
    String priority = editing?.priority ?? 'medium';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(isEditing ? 'Edit Assignment' : 'Add Assignment'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Assignment Title'),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedCourse,
                  decoration: const InputDecoration(labelText: 'Select Class'),
                  items: courses.map((course) => DropdownMenuItem(
                    value: course,
                    child: Text(course),
                  )).toList(),
                  onChanged: (v) {
                    if (v != null) {
                      setState(() => selectedCourse = v);
                    }
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text('Due: ${dueDate.year}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}'),
                    const Spacer(),
                    TextButton(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: ctx,
                          initialDate: dueDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        if (picked != null) {
                          setState(() => dueDate = picked);
                        }
                      },
                      child: const Text('Pick'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: priority,
                  decoration: const InputDecoration(labelText: 'Priority'),
                  items: const [
                    DropdownMenuItem(value: 'high', child: Text('High')),
                    DropdownMenuItem(value: 'medium', child: Text('Medium')),
                    DropdownMenuItem(value: 'low', child: Text('Low')),
                  ],
                  onChanged: (v) {
                    if (v != null) {
                      setState(() => priority = v);
                    }
                  },
                ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final title = titleController.text.trim();
                if (title.isEmpty) return;

                if (isEditing) {
                  final updated = editing.copyWith(
                    title: title,
                    course: selectedCourse,
                    dueDate: dueDate,
                    priority: priority,
                  );
                  ref.read(scheduleNotifierProvider.notifier).updateAssignment(updated);
                } else {
                  final assignment = Assignment(
                    id: const Uuid().v4(),
                    title: title,
                    course: selectedCourse,
                    dueDate: dueDate,
                    priority: priority,
                  );
                  ref.read(scheduleNotifierProvider.notifier).addAssignment(assignment);
                }

                Navigator.pop(ctx);
              },
              child: Text(isEditing ? 'Save' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClassListItem extends StatelessWidget {
  final ClassSession session;

  const _ClassListItem({required this.session});

  @override
  Widget build(BuildContext context) {
    return AppCardOutlined(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(session.time, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(session.name, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          Text(session.room, style: const TextStyle(color: Colors.grey)),
          if (session.instructor != null) ...[
            const SizedBox(height: 4),
            Text(session.instructor!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ],
      ),
    );
  }
}

class _AssignmentCard extends StatelessWidget {
  final Assignment assignment;
  final VoidCallback onEdit;
  final Color priorityColor;

  const _AssignmentCard({
    required this.assignment,
    required this.onEdit,
    required this.priorityColor,
  });

  String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return AppCardElevated(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        assignment.title,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    GestureDetector(
                      onTap: onEdit,
                      child: const Icon(Icons.edit, size: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(assignment.course),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      _formatDate(assignment.dueDate),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: priorityColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              assignment.priority.toUpperCase(),
              style: TextStyle(color: priorityColor, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _GpaTab extends ConsumerWidget {
  const _GpaTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gpa = ref.watch(gpaProvider);
    final courses = ref.watch(scheduleNotifierProvider).courses;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AppCardElevated(
          child: Column(
            children: [
              const Text(
                'Current GPA',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                gpa.toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),
              AppButton(
                text: 'Add Course',
                icon: Icons.add,
                onPressed: () => _showAddCourseDialog(context, ref),
                isFullWidth: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Semester Courses',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (courses.isNotEmpty)
              AppButton.text(
                text: 'Add',
                icon: Icons.add,
                onPressed: () => _showAddCourseDialog(context, ref),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (courses.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text('No courses added yet.'),
            ),
          )
        else
          ...courses.map((course) => _buildCourseCard(context, ref, course)),
      ],
    );
  }

  Widget _buildCourseCard(BuildContext context, WidgetRef ref, Course course) {
    return AppCardOutlined(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text('Credits: ${course.credits}'),
              ],
            ),
          ),
          if (course.grade != null)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                course.grade!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.edit, size: 20),
            onPressed: () => _showAddCourseDialog(context, ref, editing: course),
          ),
        ],
      ),
    );
  }

  void _showAddCourseDialog(BuildContext context, WidgetRef ref, {Course? editing}) {
    final isEditing = editing != null;
    final nameController = TextEditingController(text: editing?.name ?? '');
    final creditsController = TextEditingController(text: editing?.credits.toString() ?? '');
    final gradeController = TextEditingController(text: editing?.grade ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEditing ? 'Edit Course' : 'Add Course'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Course Name'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: creditsController,
                decoration: const InputDecoration(labelText: 'Credits'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: gradeController,
                decoration: const InputDecoration(labelText: 'Grade (e.g., A, B+)'),
              ),
              ],
            ),
          ),
        ),
        actions: [
          if (isEditing)
            TextButton(
              onPressed: () {
                ref.read(scheduleNotifierProvider.notifier).deleteCourse(editing.id);
                Navigator.pop(ctx);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final name = nameController.text.trim();
              final credits = int.tryParse(creditsController.text.trim());
              final grade = gradeController.text.trim();

              if (name.isEmpty || credits == null) return;

              final gradePoint = _gradeToPoint(grade);

              if (isEditing) {
                final updated = editing.copyWith(
                  name: name,
                  credits: credits,
                  grade: grade.isEmpty ? null : grade,
                  gradePoint: gradePoint,
                );
                ref.read(scheduleNotifierProvider.notifier).updateCourse(updated);
              } else {
                final course = Course(
                  id: const Uuid().v4(),
                  name: name,
                  credits: credits,
                  grade: grade.isEmpty ? null : grade,
                  gradePoint: gradePoint,
                );
                ref.read(scheduleNotifierProvider.notifier).addCourse(course);
              }

              Navigator.pop(ctx);
            },
            child: Text(isEditing ? 'Save' : 'Add'),
          ),
        ],
      ),
    );
  }

  double? _gradeToPoint(String grade) {
    switch (grade.toUpperCase()) {
      case 'A':
        return 4.0;
      case 'A-':
        return 3.7;
      case 'B+':
        return 3.3;
      case 'B':
        return 3.0;
      case 'B-':
        return 2.7;
      case 'C+':
        return 2.3;
      case 'C':
        return 2.0;
      case 'C-':
        return 1.7;
      case 'D':
        return 1.0;
      case 'F':
        return 0.0;
      default:
        return null;
    }
  }
}
