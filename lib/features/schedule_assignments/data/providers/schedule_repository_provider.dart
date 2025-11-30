import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../datasources/schedule_firestore_datasource.dart';
import '../repositories/schedule_repository_impl.dart';
import '../../domain/repositories/schedule_repository.dart';

final scheduleFirestoreDataSourceProvider = Provider<ScheduleFirestoreDataSource>((ref) {
  return ScheduleFirestoreDataSource(FirebaseFirestore.instance);
});

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  final dataSource = ref.watch(scheduleFirestoreDataSourceProvider);
  return ScheduleRepositoryImpl(dataSource);
});
