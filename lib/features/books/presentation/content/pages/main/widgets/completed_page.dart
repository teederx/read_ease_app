import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/app_padding.dart';
import '../../../../../data/models/book/book.dart';
import '../../../providers/book_list_provider/book_list_provider.dart';
import '../../../widgets/my_books_list.dart';
import '../../../widgets/no_data.dart';

class CompletedPage extends ConsumerWidget {
  const CompletedPage({
    super.key,
    required this.bookListState,
  });
  final AsyncValue<List<Book>> bookListState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppPadding(
      child: bookListState.when(
        data: (List<Book> allBooks) {
          if (allBooks.isEmpty) {
            return const NoData(
              dataEntry: DataEntry.noBook,
            );
          }

          final myFilteredBooks = allBooks
              .where(
                (book) => book.isCompleted,
              )
              .toList();

          if (myFilteredBooks.isEmpty) {
            return const NoData(dataEntry: DataEntry.noBookCompleted);
          }

          return MyBooksList(
            ref: ref,
            books: myFilteredBooks,
          );
        },
        error: (e, st) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                e.toString(),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton(
                onPressed: () => ref.invalidate(bookListProvider),
                child: const Text(
                  'Please Retry',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        loading: () => const SizedBox.shrink(),
      ),
    );
  }
}
