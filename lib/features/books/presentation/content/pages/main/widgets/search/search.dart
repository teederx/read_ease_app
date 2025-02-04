import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:read_ease_app/core/utils/app_padding.dart';
import 'package:read_ease_app/features/books/presentation/content/pages/main/widgets/search/search_books.dart';
import 'package:read_ease_app/features/books/presentation/content/pages/main/widgets/search/search_books_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../../data/models/book/book.dart';

class Search extends StatelessWidget {
  const Search({
    super.key,
    required this.bookListState,
  });
  final AsyncValue<List<Book>> bookListState;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: AppPadding(
          child: Column(
            children: [
              const SearchBooks(),
              20.verticalSpace,
              Expanded(
                child: SearchBooksList(
                  booksListState: bookListState,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
