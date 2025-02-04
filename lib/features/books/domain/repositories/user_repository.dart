import '../entities/user_entity.dart';
import '../../data/models/book/book.dart';

abstract class UserRepository {
  // Future<void> addUser({required UserEntity user});
  UserEntity? getUser ();
  Future<void> deleteUser();
  Future<void> addBook({required Book newBook});
  Future<void> updateBook({required Book updatedBook});
  Future<void> editNote({required String bookId, required String note});
  Future<List<Book>> getAllBooksOfUser();
  Future<void> toggleFavorites({required String bookId});
  Future<void> toggleIsCompleted({required String bookId});
  Future<void> removeABookOfUser({required String bookId});
  Future<void> syncProfileToLocalDatabase();
}