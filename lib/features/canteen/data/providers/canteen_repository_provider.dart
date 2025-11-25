import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../datasources/canteen_firestore_datasource.dart';
import '../datasources/storage_service.dart';
import '../../domain/entities/menu_item.dart';

part 'canteen_repository_provider.g.dart';

/// Provider for Firestore data source
@riverpod
CanteenFirestoreDataSource canteenFirestoreDataSource(
  CanteenFirestoreDataSourceRef ref,
) {
  return CanteenFirestoreDataSource(FirebaseFirestore.instance);
}

/// Provider for Storage service
@riverpod
StorageService storageService(StorageServiceRef ref) {
  return StorageService(FirebaseStorage.instance);
}

/// Provider for menu items stream
@riverpod
Stream<List<MenuItem>> menuItemsStream(MenuItemsStreamRef ref) {
  final dataSource = ref.watch(canteenFirestoreDataSourceProvider);
  return dataSource.getMenuItemsStream();
}

/// Provider for menu items by date
@riverpod
Future<List<MenuItem>> menuItemsByDate(
  MenuItemsByDateRef ref,
  DateTime date,
) {
  final dataSource = ref.watch(canteenFirestoreDataSourceProvider);
  return dataSource.getMenuItemsByDate(date);
}
