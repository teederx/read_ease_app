import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:read_ease_app/features/books/presentation/content/providers/book_search/book_search_provider.dart';

import '../../../../../../../../core/constants/app_colors.dart';
import '../../../../../../../../core/utils/debounce.dart';

class SearchBooks extends ConsumerStatefulWidget {
  const SearchBooks({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchBooksState();
}

class _SearchBooksState extends ConsumerState<SearchBooks> {
  final debounce = Debounce(milliseconds: 1000);

  @override
  void dispose() {
    debounce.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: 'Enter book title',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.w,
            color: AppColors.primaryColor,
          ),
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
      onChanged: (value) {
        //Run this after 1000 milliseconds of inactivity on the keyboard to manage data loading effectively
        debounce.run(
          () {
            ref
              .read(bookSearchProvider.notifier)
              .setSearchTerm(newSearchTerm: value);
          },
        );
      },
    );
  }
}
