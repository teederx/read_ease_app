import 'package:firebase_auth/firebase_auth.dart';

import '../constants/firebase_constants.dart';
import 'handle_exception.dart';

class AuthRepository {
  User? get currentUser => fbAuth.currentUser;

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

  Future<void> signOut() async {
    try {
      await fbAuth.signOut();
    } catch (e) {
      handleException(e);
    }
  }

  Future<void> changePassword(String password) async {
    try {
      await currentUser!.updatePassword(password);
    } catch (e) {
      handleException(e);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await fbAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      handleException(e);
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await currentUser!.sendEmailVerification();
    } catch (e) {
      handleException(e);
    }
  }

  Future<void> reloadUSer() async {
    try {
      await currentUser!.reload();
    } catch (e) {
      handleException(e);
    }
  }

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
}
