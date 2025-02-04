import 'package:flutter_quill/quill_delta.dart';
import 'package:read_ease_app/features/books/data/models/book/book.dart';
import 'package:read_ease_app/features/books/data/usecases_providers/user/user_usecase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_list_provider.g.dart';

@riverpod
class BookList extends _$BookList {
  @override
  FutureOr<List<Book>> build() async {
    return await _getBooks();
  }

  Future<List<Book>> _getBooks() async {
    print('[bookListProvider] initialized');
    ref.onDispose(() {
      print('[bookListProvider] disposed');
    });
    final books = ref.watch(userUsecaseProvider).getAllBooksOfUser();
    return books;
  }

  Future<void> addBook({
    required String imageURL,
    required String title,
    required String desc,
    required String author,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final newBook = Book.add(
        imageURL: imageURL,
        title: title,
        desc: desc,
        notes: Delta(),
        author: author,
      );

      await ref.read(userUsecaseProvider).addBook(newBook: newBook);

      return [...state.value ?? [], newBook];
    });
  }

  Future<void> editBook({required Book updatedBook}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(userUsecaseProvider).updateBook(updatedBook: updatedBook);

      return [
        for (final book in state.value!)
          if (book.bookID == updatedBook.bookID)
            updatedBook
          else
            book
      ];
    });
  }

  Future<void> editNote({required String bookId, required String notes}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(userUsecaseProvider).editNote(bookId: bookId, note: notes);

      return [
        for (final book in state.value!)
          if (book.bookID == bookId) book.copyWith(notes: notes) else book
      ];
    });
  }

  Future<void> toggleCompleted({required String bookId}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(userUsecaseProvider).toggleCompleted(bookId: bookId);

      return [
        for (final book in state.value!)
          if (book.bookID == bookId)
            book.copyWith(isCompleted: !book.isCompleted)
          else
            book
      ];
    });
  }

  Future<void> toggleFavorite({required String bookId}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(userUsecaseProvider).toggleFavorites(bookId: bookId);

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
      await ref.read(userUsecaseProvider).removeABookOfUser(bookId: bookId);

      return [
        for (final book in state.value!)
          if (book.bookID != bookId) book
      ];
    });
  }
}
