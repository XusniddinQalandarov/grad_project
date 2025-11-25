import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/section_title.dart';
import '../../data/providers/canteen_repository_provider.dart';
import '../widgets/cook_meal_card.dart';

/// Cook's main screen for managing meals
class CookCanteenScreen extends ConsumerWidget {
  const CookCanteenScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final menuItemsAsync = ref.watch(menuItemsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Menu'),
        elevation: 0,
      ),
      body: menuItemsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
              const SizedBox(height: 16),
              Text('Error: $error'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref.refresh(menuItemsStreamProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (menuItems) {
          if (menuItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.restaurant_menu_outlined,
                    size: 80,
                    color: isDark ? Colors.grey[700] : Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No meals yet',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to add your first meal',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            );
          }

          // Group by availability
          final availableMeals =
              menuItems.where((item) => item.isAvailable).toList();
          final unavailableMeals =
              menuItems.where((item) => !item.isAvailable).toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (availableMeals.isNotEmpty) ...[
                const SectionTitle(title: 'Available'),
                const SizedBox(height: 12),
                ...availableMeals.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CookMealCard(meal: item),
                    )),
              ],
              if (unavailableMeals.isNotEmpty) ...[
                if (availableMeals.isNotEmpty) const SizedBox(height: 24),
                const SectionTitle(title: 'Out of Stock'),
                const SizedBox(height: 12),
                ...unavailableMeals.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CookMealCard(meal: item),
                    )),
              ],
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.go('/cook/canteen/add-meal');
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Meal'),
      ),
    );
  }
}
