import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  User? get currentUser;
  Future<void> signUp({required String name, required String email, required String password});
  Future<void> signIn({required String email, required String password});
  Future<void> signOut();
  Future<void> changePassword(String password);
  Future<void> sendPasswordResetEmail(String email);
  Future<void> reloadUser();
  Future<void> reAuthWithCredentials(String email, String password);
  Future<void> syncProfileToCloud();
}