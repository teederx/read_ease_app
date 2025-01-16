import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:read_ease_app/core/constants/firebase_constants.dart';

import '../../models/app_user/app_user.dart';
import '../../src/local_source/local_data_source.dart';
import '../handle_exception.dart';

class ProfileRepository {
  final LocalDataSource localDataSource;

  ProfileRepository(this.localDataSource);

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

  Future<void> syncWithCloud({required String uid}) async{
    try{
      final localUser = localDataSource.getUser(id: uid);

      if(localUser != null){
        await userCollection.doc(uid).set(localUser.toJson());
        // print('User data synced with cloud');
      } else{
        throw 'Local user not found';
      }
    } catch(e){
      throw handleException(e); //throws custom error 
    }
  }

  Future<void> syncProfileToLocalDatabase({required String uid}) async {
    try {
      // Check if user exists in local database
      final localUser = localDataSource.getUser(id: uid);
      if (localUser == null) {
        // Fetch user profile from Firebase
        final appUser = await getProfile(uid: uid);
        
        // Store user profile in local database
        await localDataSource.addUser(user: appUser);
      }
    } catch (e) {
      throw handleException(e); // throws custom error
    }
  }
}