import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../data/models/book/book.dart';
import '../providers/book_list_provider/book_list_provider.dart';

class MyBooksList extends StatelessWidget {
  const MyBooksList({
    super.key,
    required this.ref,
    required this.books,
  });

  final WidgetRef ref;
  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final myBook = books[index];
        final bookID = myBook.bookID;
        final image = myBook.imageURL;
        return ListTile(
          isThreeLine: true,
          leading: Container(
            height: 60.h,
            width: 55.w,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor1,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: image == ''
                ? SvgPicture.asset(
                    'assets/icons/book.svg',
                    fit: BoxFit.fill,
                  )
                : Image.memory(
                      base64Decode(image),
                      fit: BoxFit.cover,
                    ),
          ),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  myBook.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Author: ${myBook.author}',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
          subtitle: Text(
            myBook.desc,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: IconButton(
            onPressed: () => ref
                .read(bookListProvider.notifier)
                .toggleFavorite(bookId: bookID),
            icon: Icon(
              books[index].isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_outline_rounded,
              color: AppColors.primaryColor,
            ),
          ),
        );
      },
      separatorBuilder: (context, _) => const Divider(),
      itemCount: books.length,
    );
  }
}
