import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_role.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

/// Domain entity for authenticated user
@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String email,
    required String name,
    required UserRole role,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
