import 'package:go_router/go_router.dart';
import '../features/canteen/presentation/screens/canteen_screen.dart';
import '../features/rooms_teaching/presentation/screens/rooms_teaching_screen.dart';
import '../features/schedule_assignments/presentation/screens/schedule_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import 'nav_scaffold.dart';

/// Route paths
class AppRoutes {
  static const String canteen = '/canteen';
  static const String roomsTeaching = '/rooms-teaching';
  static const String schedule = '/schedule';
  static const String profile = '/profile';
}

/// Global router configuration
final goRouter = GoRouter(
  initialLocation: AppRoutes.canteen,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return NavScaffold(navigationShell: navigationShell);
      },
      branches: [
        // Canteen Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.canteen,
              builder: (context, state) => const CanteenScreen(),
            ),
          ],
        ),
        // Rooms & Teaching Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.roomsTeaching,
              builder: (context, state) => const RoomsTeachingScreen(),
            ),
          ],
        ),
        // Schedule Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.schedule,
              builder: (context, state) => const ScheduleScreen(),
            ),
          ],
        ),
        // Profile Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
