import '../entities/app_user.dart';

/// Abstract repository for authentication operations
abstract class AuthRepository {
  /// Signs in user with email and password
  Future<AppUser> signIn(String email, String password);
  
  /// Signs out current user
  Future<void> signOut();
  
  /// Gets current authenticated user
  Future<AppUser?> getCurrentUser();
  
  /// Checks if user is authenticated
  Future<bool> isAuthenticated();
}
