import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/router/route_names.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../data/models/book/book.dart';
import '../providers/book_list_provider/book_list_provider.dart';

class BookTiles extends StatelessWidget {
  const BookTiles({
    super.key,
    required this.myBook,
    required this.image,
    required this.ref,
    required this.bookID,
  });

  final Book myBook;
  final String image;
  final WidgetRef ref;
  final String bookID;

  void _editItem(BuildContext context) {
    context.pushNamed(
      RouteNames.editBook,
      extra: bookID,
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text(
          'Warning!!',
          style: TextStyle(
            color: AppColors.primaryColor,
          ),
        ),
        content: Text(
            'Are you sure you want to permanently delete your notes on ${myBook.title}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(bookListProvider.notifier).removeBook(bookId: bookID);
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(
                color: AppColors.iconRedColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(bookID),
      background: _swipeRight(),
      secondaryBackground: _swipeLeft(),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          _editItem(context);
          return false; //Prevent auto-dismiss
        } else if (direction == DismissDirection.endToStart) {
          _confirmDelete(context);
          return false;
        }
        return false;
      },
      child: Stack(
        children: [
          ListTile(
            onTap: () {
              context.goNamed(
                RouteNames.viewBook,
                extra: myBook.bookID,
              );
            },
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
                      fit: BoxFit.fill,
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
                      fontSize: 16.sp,
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
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                5.verticalSpace,
                Text(
                  myBook.desc,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            trailing: Column(
              children: [
                IconButton(
                  onPressed: () => ref
                      .read(bookListProvider.notifier)
                      .toggleFavorite(bookId: bookID),
                  icon: Icon(
                    myBook.isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_outline_rounded,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          if (myBook.isCompleted)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(3.r),
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      bottomLeft: Radius.circular(10.r),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/bookmark.svg',
                      height: 15.h,
                      width: 15.w,
                      colorFilter: const ColorFilter.mode(
                        AppColors.secondaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    Text(
                      'completed',
                      style: TextStyle(
                          color: AppColors.secondaryColor, fontSize: 13.sp),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Widget _swipeRight() {
  return Container(
    color: AppColors.primaryColor,
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    child: const Icon(
      Icons.mode_edit_outline_outlined,
      color: AppColors.secondaryColor,
    ),
  );
}

Widget _swipeLeft() {
  return Container(
    color: AppColors.iconRedColor,
    alignment: Alignment.centerRight,
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    child: const Icon(
      Icons.delete_outline_rounded,
      color: AppColors.secondaryColor,
    ),
  );
}
