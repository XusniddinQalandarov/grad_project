import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/providers/auth_provider.dart';
import '../features/auth/domain/entities/user_role.dart';
import '../features/canteen/domain/entities/menu_item.dart';
import '../features/canteen/presentation/screens/canteen_screen.dart';
import '../features/canteen/presentation/screens/cook_canteen_screen.dart';
import '../features/canteen/presentation/widgets/meal_form_screen.dart';
import '../features/rooms_teaching/presentation/screens/rooms_teaching_screen.dart';
import '../features/schedule_assignments/presentation/screens/schedule_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import 'nav_scaffold.dart';
import 'cook_nav_scaffold.dart';

class AppRoutes {
  static const String login = '/login';
  static const String canteen = '/canteen';
  static const String cookCanteen = '/cook/canteen';
  static const String addMeal = '/cook/add-meal';
  static const String roomsTeaching = '/rooms-teaching';
  static const String schedule = '/schedule';
  static const String profile = '/profile';
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);
  final user = authState.user;
  final isCook = user?.role == UserRole.cook;
  
  return GoRouter(
    initialLocation: authState.isAuthenticated 
        ? (isCook ? AppRoutes.cookCanteen : AppRoutes.canteen)
        : AppRoutes.login,
    redirect: (context, state) {
      final isAuthenticated = authState.isAuthenticated;
      final isGoingToLogin = state.matchedLocation == AppRoutes.login;

      if (!isAuthenticated && !isGoingToLogin) {
        return AppRoutes.login;
      }

      if (isAuthenticated && isGoingToLogin) {
        return isCook ? AppRoutes.cookCanteen : AppRoutes.canteen;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      if (isCook) ...[
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return CookNavScaffold(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.cookCanteen,
                  builder: (context, state) => const CookCanteenScreen(),
                  routes: [
                    GoRoute(
                      path: 'add-meal',
                      builder: (context, state) {
                        final editingMeal = state.extra as MenuItem?;
                        return MealFormScreen(editingMeal: editingMeal);
                      },
                    ),
                  ],
                ),
              ],
            ),
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
      if (!isCook) ...[
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return NavScaffold(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.canteen,
                  builder: (context, state) => const CanteenScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.roomsTeaching,
                  builder: (context, state) => const RoomsTeachingScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.schedule,
                  builder: (context, state) => const ScheduleScreen(),
                ),
              ],
            ),
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
    ],
  );
});
