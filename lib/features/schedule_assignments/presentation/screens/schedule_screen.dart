import 'package:flutter/material.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_button.dart';

/// Unified Schedule, Assignments, and GPA screen
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
        children: const [
          _ScheduleTab(),
          _AssignmentsTab(),
          _GpaTab(),
        ],
      ),
    );
  }
}

/// Schedule tab
class _ScheduleTab extends StatelessWidget {
  const _ScheduleTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionTitle(title: 'Today\'s Classes'),
        const SizedBox(height: 12),
        ..._buildMockClasses(),
      ],
    );
  }

  List<Widget> _buildMockClasses() {
    final classes = [
      {'time': '9:00 AM', 'name': 'Data Structures', 'room': 'Room 101'},
      {'time': '11:00 AM', 'name': 'Algorithms', 'room': 'Room 205'},
      {'time': '2:00 PM', 'name': 'Database Systems', 'room': 'Room 303'},
      {'time': '4:00 PM', 'name': 'Software Engineering', 'room': 'Room 201'},
    ];

    return classes
        .map(
          (cls) => AppCardElevated(
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cls['name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 14),
                          const SizedBox(width: 4),
                          Text(cls['time']!),
                          const SizedBox(width: 12),
                          const Icon(Icons.location_on, size: 14),
                          const SizedBox(width: 4),
                          Text(cls['room']!),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}

/// Assignments tab
class _AssignmentsTab extends StatelessWidget {
  const _AssignmentsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SectionTitle(
              title: 'Pending Assignments',
              padding: EdgeInsets.zero,
            ),
            AppButton.text(
              text: 'Add New',
              icon: Icons.add,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 12),
        ..._buildMockAssignments(),
      ],
    );
  }

  List<Widget> _buildMockAssignments() {
    final assignments = [
      {
        'title': 'Algorithm Analysis Report',
        'course': 'Algorithms',
        'due': 'Due Tomorrow',
        'priority': 'high'
      },
      {
        'title': 'Database Design Project',
        'course': 'Database Systems',
        'due': 'Due in 3 days',
        'priority': 'medium'
      },
      {
        'title': 'Software Requirements Doc',
        'course': 'Software Engineering',
        'due': 'Due in 5 days',
        'priority': 'low'
      },
    ];

    return assignments
        .map(
          (assignment) => AppCardElevated(
            margin: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        assignment['title']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getPriorityColor(assignment['priority']!)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        assignment['priority']!.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _getPriorityColor(assignment['priority']!),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(assignment['course']!),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      assignment['due']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
        .toList();
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
}

/// GPA tab
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
