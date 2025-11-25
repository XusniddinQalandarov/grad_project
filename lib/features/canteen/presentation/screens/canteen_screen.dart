import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/canteen_state.dart';
import '../../../../core/widgets/loaders.dart';
import '../providers/canteen_provider.dart';
import '../widgets/menu_day_selector.dart';
import '../widgets/menu_filter_chips.dart';
import '../widgets/menu_item_card.dart';

/// Main canteen screen showing daily/weekly menu
class CanteenScreen extends ConsumerWidget {
  const CanteenScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(canteenNotifierProvider);
    final notifier = ref.read(canteenNotifierProvider.notifier);
    final filteredItems = ref.watch(filteredMenuItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Canteen Menu'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => notifier.loadMenuItems(),
        child: CustomScrollView(
          slivers: [
            _buildDaySelector(context, state.selectedDate, notifier.changeDate),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            _buildFilterChips(context, state, notifier),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            _buildMenuList(context, state, filteredItems),
          ],
        ),
      ),
    );
  }

  Widget _buildDaySelector(
    BuildContext context,
    DateTime selectedDate,
    Function(DateTime) onDateSelected,
  ) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(height: 16),
          MenuDaySelector(
            selectedDate: selectedDate,
            onDateSelected: onDateSelected,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(
    BuildContext context,
    CanteenState state,
    CanteenNotifier notifier,
  ) {
    final availableTags = _extractUniqueTags(state.menuItems);

    if (availableTags.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: MenuFilterChips(
        availableTags: availableTags,
        selectedTags: state.selectedTags,
        onTagToggle: notifier.toggleTag,
        onClearAll: notifier.clearTags,
      ),
    );
  }

  Widget _buildMenuList(
    BuildContext context,
    CanteenState state,
    List filteredItems,
  ) {
    if (state.isLoading) {
      return const SliverFillRemaining(
        child: AppLoadingIndicator(message: 'Loading menu...'),
      );
    }

    if (state.errorMessage != null) {
      return SliverFillRemaining(
        child: Consumer(
        builder: (context, ref, _) => ErrorState(
          title: 'Failed to load menu',
          subtitle: state.errorMessage,
          onRetry: () {
            ref.read(canteenNotifierProvider.notifier).loadMenuItems();
          },
        ),
      ),
      );
    }

    if (filteredItems.isEmpty) {
      return SliverFillRemaining(
        child: EmptyState(
          icon: Icons.restaurant_menu,
          title: 'No menu items available',
          subtitle: state.selectedTags.isNotEmpty
              ? 'Try removing some filters'
              : 'Check back later for today\'s menu',
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return MenuItemCard(item: filteredItems[index]);
          },
          childCount: filteredItems.length,
        ),
      ),
    );
  }

  List<String> _extractUniqueTags(List menuItems) {
    final tags = <String>{};
    for (final item in menuItems) {
      tags.addAll(item.tags as Iterable<String>);
    }
    return tags.toList()..sort();
  }
}
