import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/constants/firebase_constants.dart';
import '../../../domain/repositories/iauth_repo.dart';
import '../handle_exception.dart';
import '../profile_repository/profile_repository.dart';

class AuthRepository implements IAuthRepository {
  final ProfileRepository profileRepository;
  AuthRepository(this.profileRepository);

  @override
  User? get currentUser => fbAuth.currentUser;

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await fbAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final signedInUser = userCredential.user!;

      await userCollection.doc(signedInUser.uid).set(
        {
          'name': name,
          'email': email,
          'books': [
            {
              'imageURL': '',
              'title': 'Test1',
              'description': 'Test1 desc',
              'isFavorite' : true,
            },
            {
              'imageURL': '',
              'title': 'Test1',
              'description': 'Test1 desc',
              'isFavorite' : true,
            },
          ],
        },
      );
    } catch (e) {
      handleException(e);
    }
  }

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await fbAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      handleException(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await fbAuth.signOut();
    } catch (e) {
      handleException(e);
    }
  }

  @override
  Future<void> changePassword(String password) async {
    try {
      await currentUser!.updatePassword(password);
    } catch (e) {
      handleException(e);
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await fbAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      handleException(e);
    }
  }
  //TODO: Implement email verification
  /* Future<void> sendEmailVerification() async {
    try {
      if (currentUser != null) {
        await currentUser!.sendEmailVerification();
      } else {
        throw FirebaseAuthException(
          code: 'user-not-logged-in',
          message: 'No user is currently logged in.',
        );
      }
    } catch (e) {
      handleException(e);
    }
  } */

  

  @override
  Future<void> reloadUser() async {
    try {
      await currentUser!.reload();
    } catch (e) {
      handleException(e);
    }
  }
  

  @override
  Future<void> reAuthWithCredentials(String email, String password) async {
    try {
      await currentUser!.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: email,
          password: password,
        ),
      );
    } catch (e) {
      handleException(e);
    }
  }
  
  @override
  Future<void> syncProfileToCloud({required String uid}) async{
    try {
      await profileRepository.syncWithCloud(uid: uid);
    } catch (e) {
      handleException(e);
    }
  }
}
