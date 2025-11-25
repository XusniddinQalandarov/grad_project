// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canteen_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$canteenFirestoreDataSourceHash() =>
    r'6f7d86bb2be51dbb06f19fffd29fcb117fa3eebf';

/// Provider for Firestore data source
///
/// Copied from [canteenFirestoreDataSource].
@ProviderFor(canteenFirestoreDataSource)
final canteenFirestoreDataSourceProvider =
    AutoDisposeProvider<CanteenFirestoreDataSource>.internal(
      canteenFirestoreDataSource,
      name: r'canteenFirestoreDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$canteenFirestoreDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CanteenFirestoreDataSourceRef =
    AutoDisposeProviderRef<CanteenFirestoreDataSource>;
String _$storageServiceHash() => r'1ab9d647b04f0e9dfec13e505489106bde8af30d';

/// Provider for Storage service
///
/// Copied from [storageService].
@ProviderFor(storageService)
final storageServiceProvider = AutoDisposeProvider<StorageService>.internal(
  storageService,
  name: r'storageServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$storageServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StorageServiceRef = AutoDisposeProviderRef<StorageService>;
String _$menuItemsStreamHash() => r'fa3a82be7a386e7ff0a791e7943403e65717d8bd';

/// Provider for menu items stream
///
/// Copied from [menuItemsStream].
@ProviderFor(menuItemsStream)
final menuItemsStreamProvider =
    AutoDisposeStreamProvider<List<MenuItem>>.internal(
      menuItemsStream,
      name: r'menuItemsStreamProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$menuItemsStreamHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MenuItemsStreamRef = AutoDisposeStreamProviderRef<List<MenuItem>>;
String _$menuItemsByDateHash() => r'5130e91025c5b31c17b63f747f4d3bb6ff7f6e34';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider for menu items by date
///
/// Copied from [menuItemsByDate].
@ProviderFor(menuItemsByDate)
const menuItemsByDateProvider = MenuItemsByDateFamily();

/// Provider for menu items by date
///
/// Copied from [menuItemsByDate].
class MenuItemsByDateFamily extends Family<AsyncValue<List<MenuItem>>> {
  /// Provider for menu items by date
  ///
  /// Copied from [menuItemsByDate].
  const MenuItemsByDateFamily();

  /// Provider for menu items by date
  ///
  /// Copied from [menuItemsByDate].
  MenuItemsByDateProvider call(DateTime date) {
    return MenuItemsByDateProvider(date);
  }

  @override
  MenuItemsByDateProvider getProviderOverride(
    covariant MenuItemsByDateProvider provider,
  ) {
    return call(provider.date);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'menuItemsByDateProvider';
}

/// Provider for menu items by date
///
/// Copied from [menuItemsByDate].
class MenuItemsByDateProvider
    extends AutoDisposeFutureProvider<List<MenuItem>> {
  /// Provider for menu items by date
  ///
  /// Copied from [menuItemsByDate].
  MenuItemsByDateProvider(DateTime date)
    : this._internal(
        (ref) => menuItemsByDate(ref as MenuItemsByDateRef, date),
        from: menuItemsByDateProvider,
        name: r'menuItemsByDateProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$menuItemsByDateHash,
        dependencies: MenuItemsByDateFamily._dependencies,
        allTransitiveDependencies:
            MenuItemsByDateFamily._allTransitiveDependencies,
        date: date,
      );

  MenuItemsByDateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime date;

  @override
  Override overrideWith(
    FutureOr<List<MenuItem>> Function(MenuItemsByDateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MenuItemsByDateProvider._internal(
        (ref) => create(ref as MenuItemsByDateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<MenuItem>> createElement() {
    return _MenuItemsByDateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MenuItemsByDateProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MenuItemsByDateRef on AutoDisposeFutureProviderRef<List<MenuItem>> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _MenuItemsByDateProviderElement
    extends AutoDisposeFutureProviderElement<List<MenuItem>>
    with MenuItemsByDateRef {
  _MenuItemsByDateProviderElement(super.provider);

  @override
  DateTime get date => (origin as MenuItemsByDateProvider).date;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
