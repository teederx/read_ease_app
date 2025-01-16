import '../entities/user_entity.dart';
import '../../data/models/book/book.dart';

abstract class UserRepository {
  // Future<void> addUser({required UserEntity user});
  UserEntity? getUser ({required String id});
  Future<void> deleteUser({required String id});
  Future<void> addBook({required String userId,required Book newBook});
  Future<void> updateBook({required String userId,required Book updatedBook});
  List<Book>? getAllBooksOfUser({required String userId});
  Future<void> toggleFavorites({required String userId,required String bookId});
  Future<void> removeABookOfUser({required String userId,required String bookId});
  Future<void> syncProfileToLocalDatabase({required String uid});
}