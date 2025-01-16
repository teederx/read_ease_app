import 'package:read_ease_app/features/books/domain/repositories/user_repository.dart';
import 'package:read_ease_app/features/books/data/src/local_source/local_data_source.dart';

import '../../../domain/entities/user_entity.dart';
import '../../models/book/book.dart';
import '../../src/data_mapper/user_mapper.dart';
import '../profile_repository/profile_repository.dart';

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
  UserEntity? getUser({required String id}) {
    final appUser = localDataSource.getUser(id: id);
    if (appUser != null) {
      return UserMapper.toEntity(appUser);
    }else{
      return null;
    }
  }

  @override
  Future<void> deleteUser({required String id}) async {
    await localDataSource.deleteUser(id: id);
  }

  /* List<AppUser> getAllUsers() {
    return userBox.values.toList();
  } */

  @override
  Future<void> updateBook(
      {required String userId, required Book updatedBook}) async {
    await localDataSource.updateBook(userId: userId, updatedBook: updatedBook);
  }

  @override
  List<Book>? getAllBooksOfUser({required String userId}) {
    return localDataSource.getAllBooksOfUser(userId: userId);
  }

  @override
  Future<void> addBook({required String userId, required Book newBook}) async {
    await localDataSource.addBook(userId: userId, newBook: newBook);
  }

  @override
  Future<void> removeABookOfUser(
      {required String userId, required String bookId}) async {
    await localDataSource.removeABookOfUser(userId: userId, bookId: bookId);
  }

  @override
  Future<void> toggleFavorites(
      {required String userId, required String bookId}) async {
    await localDataSource.toggleFavorites(userId: userId, bookId: bookId);
  }

  @override
  Future<void> syncProfileToLocalDatabase({required String uid}) async {
    await profileRepository.syncProfileToLocalDatabase(uid: uid);
  }
}
