import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:read_ease_app/core/constants/firebase_constants.dart';

import '../models/app_user/app_user.dart';
import 'handle_exception.dart';

class ProfileRepository {
  Future<AppUser> getProfile({required String uid}) async{
    try{
      final DocumentSnapshot appUSerDoc = await userCollection.doc(uid).get();
      if (appUSerDoc.exists){
        final appUser = AppUser.fromDoc(appUSerDoc);
        return appUser;
      }
      throw 'User not found';
    } catch(e){
      throw handleException(e); //throws custom error 
    }
  }
}
