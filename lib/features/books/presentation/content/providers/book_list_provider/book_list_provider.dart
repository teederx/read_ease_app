import 'package:read_ease_app/features/books/data/models/book/book.dart';
import 'package:read_ease_app/features/books/data/usecases_providers/user/user_usecase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_list_provider.g.dart';

@riverpod
class BookList extends _$BookList {
  @override
  FutureOr<List<Book>> build(String userId) async {
    return await _getBooks();
  }

  Future<List<Book>> _getBooks() async {
    print('[bookListProvider] initialized');
    ref.onDispose(() {
      print('[bookListProvider] disposed');
    });
    final books =
        ref.read(userUsecaseProvider).getAllBooksOfUser(userId: userId);
    return books ?? [];
  }

  Future<void> addBook(
      {required String imageURL,
      required String title,
      required String desc,
      required String notes}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final newBook =
          Book.add(imageURL: imageURL, title: title, desc: desc, notes: notes);

      await ref
          .read(userUsecaseProvider)
          .addBook(userId: userId, newBook: newBook);

      return [...state.value!, newBook];
    });
  }

  Future<void> editBook({required Book updatedBook}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref
          .read(userUsecaseProvider)
          .updateBook(userId: userId, updatedBook: updatedBook);

      return [
        for (final book in state.value!)
          if (book.bookID == updatedBook.bookID)
            book.copyWith(
                title: updatedBook.title,
                imageURL: updatedBook.imageURL,
                desc: updatedBook.desc,
                notes: updatedBook.notes)
          else
            book
      ];
    });
  }

  Future<void> toggleFavorite({required String bookId}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref
          .read(userUsecaseProvider)
          .toggleFavorites(userId: userId, bookId: bookId);

      return [
        for (final book in state.value!)
          if (book.bookID == bookId)
            book.copyWith(isFavorite: !book.isFavorite)
          else
            book
      ];
    });
  }

  Future<void> removeBook({required String bookId}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(userUsecaseProvider).removeABookOfUser(userId: userId, bookId: bookId);

      return [
        for (final book in state.value!)
          if (book.bookID != bookId) book
      ];
    });
  }
}
