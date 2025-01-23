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
    final books = ref.read(userUsecaseProvider).getAllBooksOfUser();
    return books ?? [];
  }

  Future<void> addBook(
      {required String imageURL,
      required String title,
      required String desc,
      required String author,
      required String notes}) async {
    state = const AsyncLoading();
    print('done');

    state = await AsyncValue.guard(() async {
      final newBook = Book.add(
        imageURL: imageURL,
        title: title,
        desc: desc,
        notes: notes,
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
            book.copyWith(
              title: updatedBook.title,
              imageURL: updatedBook.imageURL,
              desc: updatedBook.desc,
              notes: updatedBook.notes,
              author: updatedBook.author,
            )
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
