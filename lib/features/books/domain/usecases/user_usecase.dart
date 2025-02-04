import '../../../../core/constants/firebase_constants.dart';
import '../../data/models/book/book.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class UserUsecase {
  final UserRepository userRepository;

  UserUsecase(this.userRepository);

  UserDetails? getUser() {
    final uid = fbAuth.currentUser!.uid;
    final userRep = userRepository.getUser();
    return UserDetails(
      id: uid,
      name: userRep!.name,
      email: userRep.email,
    );
  }

  // Future<void> addUser({required UserEntity user})async{};
  Future<void> deleteUser() async {
    return await userRepository.deleteUser();
  }

  Future<void> addBook({required Book newBook}) async {
    return await userRepository.addBook(newBook: newBook);
  }

  Future<void> updateBook({required Book updatedBook}) async {
    return await userRepository.updateBook(updatedBook: updatedBook);
  }

  Future<void> editNote({required String bookId, required String note}) async {
    return await userRepository.editNote(bookId: bookId, note: note);
  }

  Future<List<Book>> getAllBooksOfUser() {
    return userRepository.getAllBooksOfUser();
  }

  Future<void> toggleFavorites({required String bookId}) async {
    return await userRepository.toggleFavorites(bookId: bookId);
  }

  Future<void> toggleCompleted({required String bookId}) async {
    return await userRepository.toggleIsCompleted(bookId: bookId);
  }

  Future<void> removeABookOfUser({required String bookId}) async {
    return await userRepository.removeABookOfUser(bookId: bookId);
  }

  Future<void> syncProfileToLocalDatabase() async {
    return await userRepository.syncProfileToLocalDatabase();
  }
}
