import '../../data/models/book/book.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class UserUsecase {
  final UserRepository userRepository;

  UserUsecase(this.userRepository);

  UserEntity? getUser ({required String id}) => userRepository.getUser(id: id);

  // Future<void> addUser({required UserEntity user})async{};
  Future<void> deleteUser({required String id}) async {
    return await userRepository.deleteUser(id: id);
  }

  Future<void> addBook({required String userId, required Book newBook}) async {
    return await userRepository.addBook(userId: userId, newBook: newBook);
  }

  Future<void> updateBook(
      {required String userId, required Book updatedBook}) async {
    return await userRepository.updateBook(
        userId: userId, updatedBook: updatedBook);
  }

  List<Book>? getAllBooksOfUser({required String userId}) {
    return userRepository.getAllBooksOfUser(userId: userId);
  }

  Future<void> toggleFavorites(
      {required String userId, required String bookId}) async {
    return await userRepository.toggleFavorites(userId: userId, bookId: bookId);
  }

  Future<void> removeABookOfUser(
      {required String userId, required String bookId}) async {
    return await userRepository.removeABookOfUser(
        userId: userId, bookId: bookId);
  }

  Future<void> syncProfileToLocalDatabase({required String uid}) async {
    return await userRepository.syncProfileToLocalDatabase(uid: uid);
  }
}
