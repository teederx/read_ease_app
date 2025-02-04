import 'package:hive_flutter/hive_flutter.dart';

import '../../models/app_user/app_user.dart';
import '../../models/book/book.dart';

class LocalDataSource {
  static const boxName = 'users';

  final Box<AppUser> userBox = Hive.box<AppUser>(boxName);

  Future<void> addUser({required AppUser user}) async {
    await userBox.put(user.userID, user);
  }

  AppUser? getUser({required String id}) {
    return userBox.get(id);
  }

  Future<void> deleteUser({required String id}) async {
    await userBox.delete(id);
  }

  /* List<AppUser> getAllUsers() {
    return userBox.values.toList();
  } */

  Future<void> updateBook(
      {required String userId, required Book updatedBook}) async {
    final user = userBox.get(userId);
    if (user != null) {
      final updatedBooks = user.books.map((book) {
        if (book.bookID == updatedBook.bookID) {
          return updatedBook;
        }
        return book;
      }).toList();

      final updatedUser = user.copyWith(books: updatedBooks);
      await userBox.put(userId, updatedUser);
      print('Book updated successfully for user: $userId');
    } else {
      print('User not found: $userId');
    }
  }

  Future<void> editNote(
      {required String userId,
      required String bookId,
      required String note}) async {
    final user = userBox.get(userId);
    if (user != null) {
      final updatedBooks = user.books.map((book) {
        if (book.bookID == bookId) {
          return book.copyWith(notes: note);
        }
        return book;
      }).toList();

      final updatedUser = user.copyWith(books: updatedBooks);
      await userBox.put(userId, updatedUser);
    }
  }

  Future<List<Book>> getAllBooksOfUser({required String userId}) async {
    final user = userBox.get(userId);
    print('Book gotten');
    return user?.books ?? [];
  }

  Future<void> addBook({required String userId, required Book newBook}) async {
    final user = userBox.get(userId);
    if (user != null) {
      final updatedBooks = List<Book>.from(user.books)..add(newBook);
      final updatedUser = user.copyWith(books: updatedBooks);
      await userBox.put(userId, updatedUser);
    }
  }

  Future<void> removeABookOfUser(
      {required String userId, required String bookId}) async {
    final user = userBox.get(userId);
    if (user != null) {
      final updatedBooks =
          user.books.where((book) => book.bookID != bookId).toList();
      final updatedUser = user.copyWith(books: updatedBooks);
      await userBox.put(userId, updatedUser);
    }
  }

  Future<void> toggleFavorites(
      {required String userId, required String bookId}) async {
    final user = userBox.get(userId);
    if (user != null) {
      final updatedBooks = user.books.map((book) {
        if (book.bookID == bookId) {
          return book.copyWith(isFavorite: !book.isFavorite);
        }
        return book;
      }).toList();

      final updatedUser = user.copyWith(books: updatedBooks);
      await userBox.put(userId, updatedUser);
    }
  }

  Future<void> toggleCompleted(
      {required String userId, required String bookId}) async {
    final user = userBox.get(userId);
    if (user != null) {
      final updatedBooks = user.books.map((book) {
        if (book.bookID == bookId) {
          return book.copyWith(isCompleted: !book.isCompleted);
        }
        return book;
      }).toList();

      final updatedUser = user.copyWith(books: updatedBooks);
      await userBox.put(userId, updatedUser);
    }
  }
}
