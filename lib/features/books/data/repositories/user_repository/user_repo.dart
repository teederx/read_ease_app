import 'package:read_ease_app/features/books/domain/repositories/user_repository.dart';
import 'package:read_ease_app/features/books/data/src/local_source/local_data_source.dart';

import '../../../../../core/constants/firebase_constants.dart';
import '../../../domain/entities/user_entity.dart';
import '../../models/book/book.dart';
import '../../src/data_mapper/user_mapper.dart';
import '../profile_repository/profile_repository.dart';

final uid = fbAuth.currentUser!.uid;

class UserRepo extends UserRepository {
  final LocalDataSource localDataSource;
  final ProfileRepository profileRepository;
  UserRepo(this.localDataSource, this.profileRepository);

  /* @override
  Future<void> addUser({required UserEntity user}) async {
    final appUser = UserMapper.fromEntity(user);
    await localDataSource.addUser(user: appUser);
  } */

  @override
  UserEntity? getUser() {
    final appUser = localDataSource.getUser(id: uid);
    if (appUser != null) {
      return UserMapper.toEntity(appUser);
    } else {
      return null;
    }
  }

  @override
  Future<void> deleteUser() async {
    await localDataSource.deleteUser(id: uid);
  }

  /* List<AppUser> getAllUsers() {
    return userBox.values.toList();
  } */

  @override
  Future<void> updateBook({required Book updatedBook}) async {
    await localDataSource.updateBook(userId: uid, updatedBook: updatedBook);
  }

  @override
  Future<void> editNote({required String bookId, required String note}) async {
    await localDataSource.editNote(
      userId: uid,
      bookId: bookId,
      note: note,
    );
  }

  @override
  Future<List<Book>> getAllBooksOfUser() async{
    return  await localDataSource.getAllBooksOfUser(userId: uid);
  }

  @override
  Future<void> addBook({required Book newBook}) async {
    await localDataSource.addBook(userId: uid, newBook: newBook);
  }

  @override
  Future<void> removeABookOfUser({required String bookId}) async {
    await localDataSource.removeABookOfUser(userId: uid, bookId: bookId);
  }

  @override
  Future<void> toggleFavorites({required String bookId}) async {
    await localDataSource.toggleFavorites(userId: uid, bookId: bookId);
  }

  @override
  Future<void> syncProfileToLocalDatabase() async {
    await profileRepository.syncProfileToLocalDatabase(uid: uid);
  }

  @override
  Future<void> toggleIsCompleted({required String bookId}) async {
    await localDataSource.toggleCompleted(userId: uid, bookId: bookId);
  }
}
