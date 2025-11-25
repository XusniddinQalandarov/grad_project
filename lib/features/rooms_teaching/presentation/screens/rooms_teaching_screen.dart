import 'package:flutter/material.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../../core/widgets/app_card.dart';

/// Rooms & Peer Teaching screen with tabs
class RoomsTeachingScreen extends StatefulWidget {
  const RoomsTeachingScreen({super.key});

  @override
  State<RoomsTeachingScreen> createState() => _RoomsTeachingScreenState();
}

class _RoomsTeachingScreenState extends State<RoomsTeachingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: const Text('Rooms & Teaching'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Available Rooms', icon: Icon(Icons.meeting_room)),
            Tab(text: 'Peer Tutors', icon: Icon(Icons.people)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _RoomsTab(),
          _TutorsTab(),
        ],
      ),
    );
  }
}

/// Tab for available rooms
class _RoomsTab extends StatelessWidget {
  const _RoomsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionTitle(title: 'Available Now'),
        const SizedBox(height: 12),
        ..._buildMockRooms(),
      ],
    );
  }

  List<Widget> _buildMockRooms() {
    return List.generate(
      5,
      (index) => AppCardElevated(
        margin: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Room ${index + 101}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Available',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.people, size: 16),
                const SizedBox(width: 4),
                Text('Capacity: ${20 + index * 5}'),
                const SizedBox(width: 16),
                const Icon(Icons.computer, size: 16),
                const SizedBox(width: 4),
                Text('Equipment: ${index % 2 == 0 ? 'Projector' : 'Smart Board'}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Tab for peer tutors
class _TutorsTab extends StatelessWidget {
  const _TutorsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionTitle(title: 'Available Tutors'),
        const SizedBox(height: 12),
        ..._buildMockTutors(),
      ],
    );
  }

  List<Widget> _buildMockTutors() {
    final tutors = [
      {'name': 'John Doe', 'subject': 'Mathematics', 'rating': '4.8'},
      {'name': 'Jane Smith', 'subject': 'Physics', 'rating': '4.9'},
      {'name': 'Mike Johnson', 'subject': 'Computer Science', 'rating': '4.7'},
      {'name': 'Sarah Williams', 'subject': 'Chemistry', 'rating': '4.6'},
    ];

    return tutors
        .map(
          (tutor) => AppCardElevated(
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Text(
                    tutor['name']![0],
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tutor['name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(tutor['subject']!),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(tutor['rating']!),
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
