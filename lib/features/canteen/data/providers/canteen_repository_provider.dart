import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../datasources/canteen_firestore_datasource.dart';
import '../datasources/storage_service.dart';
import '../repositories/canteen_repository_impl.dart';
import '../../domain/repositories/canteen_repository.dart';
import '../../domain/entities/menu_item.dart';

part 'canteen_repository_provider.g.dart';

@riverpod
CanteenFirestoreDataSource canteenFirestoreDataSource(
  CanteenFirestoreDataSourceRef ref,
) {
  return CanteenFirestoreDataSource(FirebaseFirestore.instance);
}

@riverpod
StorageService storageService(StorageServiceRef ref) {
  return StorageService(FirebaseStorage.instance);
}

@riverpod
CanteenRepository canteenRepository(CanteenRepositoryRef ref) {
  final dataSource = ref.watch(canteenFirestoreDataSourceProvider);
  return CanteenRepositoryImpl(dataSource);
}

@riverpod
Stream<List<MenuItem>> menuItemsStream(MenuItemsStreamRef ref) {
  final dataSource = ref.watch(canteenFirestoreDataSourceProvider);
  return dataSource.getMenuItemsStream();
}

@riverpod
Future<List<MenuItem>> menuItemsByDate(
  MenuItemsByDateRef ref,
  DateTime date,
) {
  final dataSource = ref.watch(canteenFirestoreDataSourceProvider);
  return dataSource.getMenuItemsByDate(date);
}
