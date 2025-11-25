import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/auth_local_datasource.dart';

/// Implementation of auth repository
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<AppUser> signIn(String email, String password) async {
    try {
      final user = await _remoteDataSource.signIn(email, password);
      await _localDataSource.saveUser(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _remoteDataSource.signOut();
      await _localDataSource.clearUser();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    try {
      // Try to get from Firebase first
      final user = await _remoteDataSource.getCurrentUser();
      if (user != null) {
        await _localDataSource.saveUser(user);
        return user;
      }
      
      // Fallback to cached user
      return _localDataSource.getCachedUser();
    } catch (e) {
      // Return cached user on error
      return _localDataSource.getCachedUser();
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      final user = await getCurrentUser();
      return user != null;
    } catch (e) {
      return false;
    }
  }
}
