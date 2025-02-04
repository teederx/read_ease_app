import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:read_ease_app/core/utils/app_padding.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../data/models/book/book.dart';
import '../providers/book_list_provider/book_list_provider.dart';
import '../widgets/my_books_list.dart';
import '../widgets/no_data.dart';

class Favorites extends ConsumerWidget {
  const Favorites({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bookListState = ref.watch(bookListProvider); 

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Favorites'),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
          color: AppColors.primaryColor,
          height: 2.h,
        ),
      ),
      body: AppPadding(
        child: bookListState.when(
          data: (List<Book> allBooks) {
            if (allBooks.isEmpty) {
              return const NoData(
                dataEntry: DataEntry.noBook,
              );
            }

            final myFilteredBooks = allBooks
                .where(
                  (book) => book.isFavorite,
                )
                .toList();

            if (myFilteredBooks.isEmpty) {
              return const NoData(dataEntry: DataEntry.noFavorite);
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
      ),
    );
  }
}
