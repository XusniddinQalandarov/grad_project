import 'package:flutter/material.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_button.dart';

// Lightweight local models for this screen (keeps everything in-file)
class ClassSession {
  final String time;
  final String name;
  final String room;
  const ClassSession({required this.time, required this.name, required this.room});
}

class Assignment {
  final String id;
  String title;
  String course;
  DateTime due;
  String priority; // 'high'|'medium'|'low'
  bool completed;

  Assignment({
    required this.id,
    required this.title,
    required this.course,
    required this.due,
    this.priority = 'medium',
    this.completed = false,
  });
}

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
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
          tabs: const [
            Tab(text: 'Schedule', icon: Icon(Icons.calendar_today)),
            Tab(text: 'Assignments', icon: Icon(Icons.assignment)),
            Tab(text: 'GPA', icon: Icon(Icons.bar_chart)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        // children are not const because tabs are stateful now
        children: [
          _ScheduleTab(),
          _AssignmentsTab(),
          _GpaTab(),
        ],
      ),
    );
  }
}

class _ScheduleTab extends StatefulWidget {
  const _ScheduleTab();

  @override
  State<_ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<_ScheduleTab> {
  // simple local state for demo — later this will come from providers
  bool _isLoading = false;
  List<ClassSession> _classes = const [
    ClassSession(time: '9:00 AM', name: 'Data Structures', room: 'Room 101'),
    ClassSession(time: '11:00 AM', name: 'Algorithms', room: 'Room 205'),
    ClassSession(time: '2:00 PM', name: 'Database Systems', room: 'Room 303'),
    ClassSession(time: '4:00 PM', name: 'Software Engineering', room: 'Room 201'),
  ];

  Future<void> _onRefresh() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 600));
    // simulate refresh; here you could fetch new data and setState
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_classes.isEmpty) {
      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 80),
            const Icon(Icons.event_busy, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Center(child: Text('No classes scheduled for today.')),
            const SizedBox(height: 12),
            AppButton.primary(text: 'Refresh', onPressed: _onRefresh),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _classes.length + 1,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          if (index == 0) {
            return const SectionTitle(title: 'Today\'s Classes');
          }

          final cls = _classes[index - 1];
          return _ClassListItem(session: cls);
        },
      ),
    );
  }
}

class _AssignmentsTab extends StatefulWidget {
  const _AssignmentsTab();

  @override
  State<_AssignmentsTab> createState() => _AssignmentsTabState();
}

class _AssignmentsTabState extends State<_AssignmentsTab> {
  bool _isLoading = false;
  List<Assignment> _assignments = [
    Assignment(
      id: 'a1',
      title: 'Algorithm Analysis Report',
      course: 'Algorithms',
      due: DateTime.now().add(const Duration(days: 1)),
      priority: 'high',
    ),
    Assignment(
      id: 'a2',
      title: 'Database Design Project',
      course: 'Database Systems',
      due: DateTime.now().add(const Duration(days: 3)),
      priority: 'medium',
    ),
    Assignment(
      id: 'a3',
      title: 'Software Requirements Doc',
      course: 'Software Engineering',
      due: DateTime.now().add(const Duration(days: 5)),
      priority: 'low',
    ),
  ];

  Future<void> _onRefresh() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 600));
    setState(() => _isLoading = false);
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
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Delete')),
        ],
      ),
    );
  }

  void _showAddEdit({Assignment? editing}) {
    final isEditing = editing != null;
    final titleCtrl = TextEditingController(text: editing?.title ?? '');
    final courseCtrl = TextEditingController(text: editing?.course ?? '');
    DateTime due = editing?.due ?? DateTime.now().add(const Duration(days: 1));
    String priority = editing?.priority ?? 'medium';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(isEditing ? 'Edit Assignment' : 'Add Assignment', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
                const SizedBox(height: 8),
                TextField(controller: courseCtrl, decoration: const InputDecoration(labelText: 'Course')),
                const SizedBox(height: 8),
                Row(children: [
                  Expanded(
                    child: Text('Due: ${due.year}-${due.month}-${due.day}'),
                  ),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: ctx,
                        initialDate: due,
                        firstDate: DateTime.now().subtract(const Duration(days: 365)),
                        lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                      );
                      if (picked != null) {
                        due = picked;
                        setState(() {});
                      }
                    },
                    child: const Text('Pick'),
                  ),
                ]),
                const SizedBox(height: 8),
                Row(children: [
                  const Text('Priority:'),
                  const SizedBox(width: 8),
                  DropdownButton<String>(value: priority, items: const [
                    DropdownMenuItem(value: 'high', child: Text('High')),
                    DropdownMenuItem(value: 'medium', child: Text('Medium')),
                    DropdownMenuItem(value: 'low', child: Text('Low')),
                  ], onChanged: (v) { if (v!=null) priority = v; setState(() {}); }),
                ]),
                const SizedBox(height: 12),
                Row(children: [
                  Expanded(child: AppButton.secondary(text: 'Cancel', onPressed: () => Navigator.of(ctx).pop())),
                  const SizedBox(width: 8),
                  Expanded(child: AppButton.primary(text: isEditing ? 'Save' : 'Add', onPressed: () {
                    final title = titleCtrl.text.trim();
                    final course = courseCtrl.text.trim();
                    if (title.isEmpty || course.isEmpty) return;
                    setState(() {
                      if (isEditing) {
                        editing!.title = title;
                        editing.course = course;
                        editing.due = due;
                        editing.priority = priority;
                      } else {
                        _assignments.insert(0, Assignment(id: DateTime.now().millisecondsSinceEpoch.toString(), title: title, course: course, due: due, priority: priority));
                      }
                    });
                    Navigator.of(ctx).pop();
                  })),
                ])
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _assignments.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: SectionTitle(
                    title: 'Pending Assignments',
                    padding: EdgeInsets.zero,
                  ),
                ),
                AppButton.text(text: 'Add New', icon: Icons.add, onPressed: () => _showAddEdit()),
              ],
            );
          }

          if (_assignments.isEmpty) {
            return const Padding(
              padding: EdgeInsets.only(top: 24.0),
              child: Center(child: Text('No assignments. Pull to refresh or add new.')),
            );
          }

          final assignment = _assignments[index - 1];

          return Dismissible(
            key: ValueKey(assignment.id),
            background: Container(color: Colors.green, alignment: Alignment.centerLeft, padding: const EdgeInsets.only(left: 20), child: const Icon(Icons.check, color: Colors.white)),
            secondaryBackground: Container(color: Colors.red, alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), child: const Icon(Icons.delete, color: Colors.white)),
            confirmDismiss: (dir) async {
              if (dir == DismissDirection.endToStart) {
                final res = await _confirmDelete(context, assignment);
                if (res == true) {
                  setState(() => _assignments.removeWhere((a) => a.id == assignment.id));
                }
                return res;
              } else {
                // mark complete
                setState(() => assignment.completed = true);
                return false;
              }
            },
            child: _AssignmentCard(
              assignment: assignment,
              onEdit: () => _showAddEdit(editing: assignment),
              priorityColor: _getPriorityColor(assignment.priority),
            ),
          );
        },
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
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(session.time, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Text(session.name, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 4),
              Text(session.room, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

class _AssignmentCard extends StatelessWidget {
  final Assignment assignment;
  final VoidCallback onEdit;
  final Color priorityColor;

  const _AssignmentCard({required this.assignment, required this.onEdit, required this.priorityColor});

  String _formatDate(DateTime d) => '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

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
                      child: Text(assignment.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                    GestureDetector(onTap: onEdit, child: const Icon(Icons.edit, size: 18)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(assignment.course),
                const SizedBox(height: 6),
                Row(children: [
                  const Icon(Icons.calendar_today, size: 14),
                  const SizedBox(width: 6),
                  Text(_formatDate(assignment.due), style: const TextStyle(fontWeight: FontWeight.w500)),
                ]),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: priorityColor.withOpacity(0.12), borderRadius: BorderRadius.circular(8)),
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

class _GpaTab extends StatelessWidget {
  const _GpaTab();

  @override
  Widget build(BuildContext context) {
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
              const Text(
                '3.75',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),
              AppButton(
                text: 'Calculate New GPA',
                icon: Icons.calculate,
                onPressed: () {},
                isFullWidth: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const SectionTitle(title: 'Semester Courses'),
        const SizedBox(height: 12),
        ..._buildMockCourses(),
      ],
    );
  }

  List<Widget> _buildMockCourses() {
    final courses = [
      {'name': 'Data Structures', 'credits': '3', 'grade': 'A'},
      {'name': 'Algorithms', 'credits': '3', 'grade': 'A-'},
      {'name': 'Database Systems', 'credits': '4', 'grade': 'B+'},
      {'name': 'Software Engineering', 'credits': '3', 'grade': 'A'},
    ];

    return courses
        .map(
          (course) => AppCardOutlined(
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course['name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('Credits: ${course['credits']}'),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    course['grade']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}
