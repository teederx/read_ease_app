import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:read_ease_app/features/books/data/models/book/book.dart';
import 'package:read_ease_app/features/books/presentation/content/widgets/my_books_list.dart';
import 'package:read_ease_app/features/books/presentation/content/widgets/no_data.dart';

import '../../../../providers/book_list_provider/book_list_provider.dart';
import '../../../../providers/book_search/book_search_provider.dart';

// ignore: must_be_immutable
class SearchBooksList extends ConsumerWidget {
  SearchBooksList({
    super.key,
    required this.booksListState,
  });
  final AsyncValue<List<Book>> booksListState;

  

  List<Book> searchedBooks(List<Book> allBooks, String searchedEntry) {
    List<Book> searchedBooks = allBooks;

    if (searchedEntry.isNotEmpty) {
      searchedBooks = searchedBooks
          .where((book) =>
              book.title.toLowerCase().contains(searchedEntry.toLowerCase()))
          .toList();
    }
    return searchedBooks;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchedEntry = ref.watch(bookSearchProvider);

    return booksListState.when(
      skipError: true,
      data: (List<Book> allBooks) {
        Widget prevBooksWidget = const SizedBox.shrink();

        if (allBooks.isEmpty) {
          prevBooksWidget = const NoData(
            dataEntry: DataEntry.noBook,
          );
          return prevBooksWidget;
        }
        final mySearchedBooks = searchedBooks(allBooks, searchedEntry);

        if (mySearchedBooks.isEmpty) {
          prevBooksWidget = NoData(
            dataEntry: DataEntry.noBookTitle,
            entry: searchedEntry,
          );
          return prevBooksWidget;
        }

        prevBooksWidget = MyBooksList(
          ref: ref,
          books: mySearchedBooks,
        );

        return prevBooksWidget;
      },
      error: (e, st) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              e.toString(),
              style: TextStyle(
                fontSize: 20.sp,
              ),
            ),
            20.verticalSpace,
            OutlinedButton(
              onPressed: () => ref.invalidate(bookListProvider),
              child: Text(
                'Please Retry',
                style: TextStyle(
                  fontSize: 20.sp,
                ),
              ),
            ),
          ],
        ),
      ),
      loading: () => const SizedBox.shrink(),
    );
  }
}
