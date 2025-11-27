import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Extension methods for String
extension StringExtensions on String {
  /// Capitalizes first letter of the string
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalizes first letter of each word
  String capitalizeWords() {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word.isEmpty ? word : word.capitalize())
        .join(' ');
  }

  /// Checks if string is a valid email
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// Checks if string is numeric
  bool get isNumeric {
    return double.tryParse(this) != null;
  }

  /// Removes all whitespace
  String removeWhitespace() {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Truncates string with ellipsis
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$ellipsis';
  }
}

/// Extension methods for DateTime
extension DateTimeExtensions on DateTime {
  /// Formats date as 'MMM dd, yyyy' (e.g., 'Jan 15, 2024')
  String get formattedDate => DateFormat('MMM dd, yyyy').format(this);

  /// Formats date as 'MMMM dd, yyyy' (e.g., 'January 15, 2024')
  String get formattedDateLong => DateFormat('MMMM dd, yyyy').format(this);

  /// Formats time as 'hh:mm a' (e.g., '02:30 PM')
  String get formattedTime => DateFormat('hh:mm a').format(this);

  /// Formats date and time (e.g., 'Jan 15, 2024 at 02:30 PM')
  String get formattedDateTime => DateFormat('MMM dd, yyyy \'at\' hh:mm a').format(this);

  /// Returns day name (e.g., 'Monday')
  String get dayName => DateFormat('EEEE').format(this);

  /// Returns short day name (e.g., 'Mon')
  String get dayNameShort => DateFormat('EEE').format(this);

  /// Returns month name (e.g., 'January')
  String get monthName => DateFormat('MMMM').format(this);

  /// Returns short month name (e.g., 'Jan')
  String get monthNameShort => DateFormat('MMM').format(this);

  /// Checks if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Checks if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Checks if date is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Returns time ago string (e.g., '2 hours ago', '3 days ago')
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'just now';
    }
  }

  /// Returns start of day (00:00:00)
  DateTime get startOfDay => DateTime(year, month, day);

  /// Returns end of day (23:59:59)
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);
}

/// Extension methods for BuildContext
extension BuildContextExtensions on BuildContext {
  /// MediaQuery shortcuts
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get padding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  Brightness get brightness => Theme.of(this).brightness;

  /// Theme shortcuts
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  /// Checks if device is in dark mode
  bool get isDarkMode => brightness == Brightness.dark;

  /// Checks if device is in light mode
  bool get isLightMode => brightness == Brightness.light;

  /// Shows a SnackBar
  void showSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

  /// Shows an error SnackBar
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: theme.colorScheme.error,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  /// Shows a success SnackBar
  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

/// Extension methods for List
extension ListExtensions<T> on List<T> {
  /// Safely gets element at index or returns null
  T? getOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }

  /// Groups list by a key selector
  Map<K, List<T>> groupBy<K>(K Function(T) keySelector) {
    final map = <K, List<T>>{};
    for (final element in this) {
      final key = keySelector(element);
      map.putIfAbsent(key, () => []).add(element);
    }
    return map;
  }
}

/// Extension methods for double
extension DoubleExtensions on double {
  /// Rounds to specified decimal places
  double roundToDecimals(int decimals) {
    final mod = 10.0 * decimals;
    return (this * mod).round() / mod;
  }

  /// Formats as currency
  String toCurrency({String symbol = 'UZS', int decimals = 0}) {
    return '${toStringAsFixed(decimals)} $symbol';
  }

  /// Formats as percentage
  String toPercentage({int decimals = 1}) {
    return '${toStringAsFixed(decimals)}%';
  }
}

/// Extension methods for int
extension IntExtensions on int {
  /// Formats as currency
  String toCurrency({String symbol = 'UZS'}) {
    return '$this $symbol';
  }

  /// Converts to ordinal string (1st, 2nd, 3rd, etc.)
  String get ordinal {
    if (this % 100 >= 11 && this % 100 <= 13) {
      return '${this}th';
    }
    switch (this % 10) {
      case 1:
        return '${this}st';
      case 2:
        return '${this}nd';
      case 3:
        return '${this}rd';
      default:
        return '${this}th';
    }
  }
}
