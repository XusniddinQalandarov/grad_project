import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/user_role.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDataSource(this._firebaseAuth);

  Future<AppUser> signIn(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw Exception('Sign in failed: User is null');
      }

      final role = _getRoleFromEmail(email);
      
      return AppUser(
        id: user.uid,
        email: user.email ?? email,
        name: _getNameFromEmail(email),
        role: role,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }

  Future<AppUser?> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) return null;

      final role = _getRoleFromEmail(user.email ?? '');
      
      return AppUser(
        id: user.uid,
        email: user.email ?? '',
        name: _getNameFromEmail(user.email ?? ''),
        role: role,
      );
    } catch (e) {
      return null;
    }
  }

  bool isAuthenticated() {
    return _firebaseAuth.currentUser != null;
  }

  UserRole _getRoleFromEmail(String email) {
    if (email.contains('cook@') || email.contains('chef@')) {
      return UserRole.cook;
    }
    return UserRole.student;
  }

  String _getNameFromEmail(String email) {
    final username = email.split('@').first;
    return username.split('.').map((part) {
      return part[0].toUpperCase() + part.substring(1);
    }).join(' ');
  }

  Exception _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return Exception('No user found with this email');
      case 'wrong-password':
        return Exception('Incorrect password');
      case 'invalid-email':
        return Exception('Invalid email address');
      case 'user-disabled':
        return Exception('This account has been disabled');
      case 'too-many-requests':
        return Exception('Too many failed attempts. Try again later');
      case 'network-request-failed':
        return Exception('Network error. Check your connection');
      default:
        return Exception('Authentication failed: ${e.message}');
    }
  }
}
