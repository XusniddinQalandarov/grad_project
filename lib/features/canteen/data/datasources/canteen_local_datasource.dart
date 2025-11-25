import '../../domain/entities/menu_item.dart';

/// Local data source for canteen menu items
/// In a real app, this would fetch from a local database or cache
class CanteenLocalDataSource {
  /// Fetches menu items for a specific date
  Future<List<MenuItem>> getMenuItemsByDate(DateTime date) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Return mock data
    return _getMockMenuItems()
        .where((item) => _isSameDay(item.availableDate, date))
        .toList();
  }

  /// Fetches menu items for a week starting from startDate
  Future<List<MenuItem>> getMenuItemsForWeek(DateTime startDate) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    final endDate = startDate.add(const Duration(days: 7));
    return _getMockMenuItems()
        .where((item) =>
            item.availableDate.isAfter(startDate.subtract(const Duration(days: 1))) &&
            item.availableDate.isBefore(endDate))
        .toList();
  }

  /// Fetches menu items filtered by tags
  Future<List<MenuItem>> getMenuItemsByTags(List<String> tags) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (tags.isEmpty) return _getMockMenuItems();
    
    return _getMockMenuItems()
        .where((item) => item.tags.any((tag) => tags.contains(tag)))
        .toList();
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// Mock data generator
  List<MenuItem> _getMockMenuItems() {
    final today = DateTime.now();
    return [
      // Today's menu
      MenuItem(
        id: '1',
        name: 'Grilled Chicken Salad',
        price: 8.99,
        calories: 450,
        tags: ['healthy', 'high-protein', 'gluten-free'],
        description: 'Fresh greens with grilled chicken breast',
        availableDate: today,
      ),
      MenuItem(
        id: '2',
        name: 'Beef Burger & Fries',
        price: 12.50,
        calories: 850,
        tags: ['popular', 'comfort-food'],
        description: 'Classic beef burger with crispy fries',
        availableDate: today,
      ),
      MenuItem(
        id: '3',
        name: 'Vegetarian Pizza',
        price: 10.99,
        calories: 650,
        tags: ['vegetarian', 'popular'],
        description: 'Fresh vegetables on thin crust',
        availableDate: today,
      ),
      MenuItem(
        id: '4',
        name: 'Salmon Bowl',
        price: 14.99,
        calories: 520,
        tags: ['healthy', 'high-protein', 'gluten-free'],
        description: 'Grilled salmon with quinoa and vegetables',
        availableDate: today,
      ),
      MenuItem(
        id: '5',
        name: 'Pasta Carbonara',
        price: 11.50,
        calories: 720,
        tags: ['comfort-food', 'popular'],
        description: 'Creamy pasta with bacon',
        availableDate: today,
      ),
      
      // Tomorrow's menu
      MenuItem(
        id: '6',
        name: 'Caesar Salad',
        price: 7.99,
        calories: 380,
        tags: ['healthy', 'vegetarian'],
        description: 'Classic Caesar with romaine lettuce',
        availableDate: today.add(const Duration(days: 1)),
      ),
      MenuItem(
        id: '7',
        name: 'Chicken Wrap',
        price: 9.50,
        calories: 480,
        tags: ['high-protein', 'popular'],
        description: 'Grilled chicken in a tortilla wrap',
        availableDate: today.add(const Duration(days: 1)),
      ),
      MenuItem(
        id: '8',
        name: 'Veggie Stir Fry',
        price: 10.00,
        calories: 420,
        tags: ['vegetarian', 'vegan', 'healthy'],
        description: 'Mixed vegetables with rice',
        availableDate: today.add(const Duration(days: 1)),
      ),
      MenuItem(
        id: '9',
        name: 'Fish & Chips',
        price: 13.50,
        calories: 780,
        tags: ['comfort-food'],
        description: 'Battered fish with chips',
        availableDate: today.add(const Duration(days: 1)),
      ),
      MenuItem(
        id: '10',
        name: 'Margherita Pizza',
        price: 9.99,
        calories: 600,
        tags: ['vegetarian', 'popular'],
        description: 'Traditional tomato and mozzarella',
        availableDate: today.add(const Duration(days: 1)),
      ),
    ];
  }
}
