import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/iauth_repo.dart';

class AuthUseCase {
  final IAuthRepository authRepository;

  AuthUseCase(this.authRepository);

  User? get currentUser => authRepository.currentUser;

  Future<void> signIn(String email, String password) async {
    return await authRepository.signIn(email: email, password: password);
  }

  Future<void> signOut() async {
    return await authRepository.signOut();
  }

  Future<void> signUp(String name, String email, String password) async {
    return await authRepository.signUp(name: name, email: email, password: password);
  }

  Future<void> changePassword(String password) async {
    return await authRepository.changePassword(password);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    return await authRepository.sendPasswordResetEmail(email);
  }

  Future<void> reloadUser() async {
    return await authRepository.reloadUser();
  }

  Future<void> reAuthWithCredentials(String email, String password) async {
    return await authRepository.reAuthWithCredentials(email, password);
  }

  Future<void> syncProfileToCloud() async{
    return await authRepository.syncProfileToCloud();
  }
}