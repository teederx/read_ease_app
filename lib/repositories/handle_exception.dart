import 'package:firebase_auth/firebase_auth.dart';

import '../models/custom_error.dart';

CustomError handleException(e) {
  try {
    throw e;
  } on FirebaseAuthException catch (e) {
    throw CustomError(
      code: e.code,
      message: e.message ?? 'Invalid credential',
      plugin: e.plugin,
    );
  } on FirebaseException catch (e) {
    throw CustomError(
      code: e.code,
      message: e.message ?? 'Firebase Error',
      plugin: e.plugin,
    );
  } catch (e) {
    throw CustomError(
      code: 'Exception',
      message: e.toString(),
      plugin: 'Unknown error',
    );
  }
}
